import 'package:flutter/material.dart';
import 'package:todo_list/views/widgets/note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            NoteWidget(
              title: 'Todo Title',
              subtitle: 'Todo Subtitle',
            ),
            NoteWidget(
              title: 'Todo Title',
              subtitle: 'Todo Subtitle',
            ),
          ],
        ),
      ),
    );
  }
}
