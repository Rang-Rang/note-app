import 'package:flutter/material.dart';
import 'package:todo_list/src/views/widgets/empty_widget.dart';
import 'package:todo_list/src/views/widgets/note_widget.dart';
import '../../res/notifier.dart';
import '../../services/database_helper.dart';
import 'create_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _notes = [];
  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _dbHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    _loadNotes();
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteNote(id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isListViews,
        builder: (context, isListView, child) {
          if (_notes.isEmpty) return EmptyWidget();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: isListView
                ? ListView.builder(
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return NoteWidget(
                        id: note['id'],
                        title: note['title'],
                        subtitle: note['note'],
                        onTap: _loadNotes,
                        onDelete: () => _confirmDelete(note['id']),
                      );
                    },
                  )
                : GridView.builder(
                    itemCount: _notes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return NoteWidget(
                        id: note['id'],
                        title: note['title'],
                        subtitle: note['note'],
                        onTap: _loadNotes,
                        onDelete: () => _confirmDelete(note['id']),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNotePage()),
          );
          _loadNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
