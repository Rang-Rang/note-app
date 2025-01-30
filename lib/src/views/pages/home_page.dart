import 'package:flutter/material.dart';
import 'package:todo_list/src/views/widgets/note_widget.dart';
import 'create_note_page.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController;
  const HomePage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) => NoteWidget(
            title: 'Title',
            subtitle: 'Note',
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 1,
          ),
          itemCount: 20, 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNotePage(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
