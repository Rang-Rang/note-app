import 'package:flutter/material.dart';
import 'package:todo_list/views/widgets/todo_widget.dart';

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
            TodoWidget(
              title: 'Todo Title',
              subtitle: 'Todo Subtitle',
              date: 'Today',
            ),
            TodoWidget(
              title: 'Todo Title',
              subtitle: 'Todo Subtitle',
              date: 'Tomorrow',
            ),
          ],
        ),
      ),
    );
  }
}
