import 'package:flutter/material.dart';
import '../../res/notifier.dart';
import 'package:intl/intl.dart';
import '../../services/database_helper.dart';

class CreateNotePage extends StatefulWidget {
  final Map<String, dynamic>? note;
  const CreateNotePage({super.key, this.note});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  DateTime? _lastEditedTime;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'];
      _noteController.text = widget.note!['note'];
      if (widget.note!['onModified'] != null) {
        _lastEditedTime =
            DateTime.fromMillisecondsSinceEpoch(widget.note!['onModified']);
      } else {
        _lastEditedTime = null;
      }
    }
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty && _noteController.text.isEmpty) {
      return;
    }

    final now = DateTime.now();
    if (widget.note == null) {
      await _dbHelper.addNote(
        _titleController.text,
        _noteController.text,
      );
    } else {
      await _dbHelper.updateNote(
        widget.note!['id'],
        _titleController.text,
        _noteController.text,
      );
    }
    setState(() {
      _lastEditedTime = now;
    });
  }

  Future<bool> onWillPop() async {
    if (_titleController.text.isEmpty && _noteController.text.isEmpty) {}
    await _saveNote();
    return true;
  }

  String _getLastEditedText() {
    if (_lastEditedTime == null) return 'Edited just now';
    final now = DateTime.now();
    final difference = now.difference(_lastEditedTime!);

    if (difference.inMinutes < 1) return 'Edited just now';
    if (difference.inMinutes < 60)
      return 'Edited ${difference.inMinutes} minutes ago';
    if (difference.inHours < 24)
      return 'Edited ${difference.inHours} hours ago';

    return 'Edited on ${DateFormat.yMMMd().add_Hm().format(_lastEditedTime!)}';
  }

  void _scrollListener() {
    if (_scrollController.offset <= 0) {
      if (!isAtTop.value) {
        isAtTop.value = true;
        scrollButtonPosition.value = Position.top;
        scrollButtonIcon.value = Icon(Icons.arrow_downward);
      }
    } else if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (isAtTop.value) {
        isAtTop.value = false;
        scrollButtonPosition.value = Position.bottom;
        scrollButtonIcon.value = Icon(Icons.arrow_upward);
      }
    }
  }

  void _scrollToPosition() {
    if (scrollButtonPosition.value == Position.top) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: _scrollToPosition,
                  icon: ValueListenableBuilder(
                    valueListenable: scrollButtonIcon,
                    builder: (context, icon, child) {
                      return icon;
                    },
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: isPin,
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: () {
                        isPin.value = !isPin.value;
                      },
                      icon: pin,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        maxLines: null,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                        ),
                      ),
                      TextFormField(
                        controller: _noteController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Note',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _getLastEditedText(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
