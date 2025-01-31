import 'package:flutter/material.dart';

import '../pages/create_note_page.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onDelete,
  });

  final int id;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  State<NoteWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<NoteWidget> {
  void _editNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateNotePage(
          note: {
            'id': widget.id,
            'title': widget.title,
            'note': widget.subtitle,
          },
        ),
      ),
    );
    widget.onTap(); // Pastikan memanggil fungsi onTap setelah kembali
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          return _editNote(context);
        },
        onLongPress: () {
          return widget.onDelete();
        },
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
