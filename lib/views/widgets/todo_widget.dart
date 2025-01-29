import 'package:flutter/material.dart';
import 'package:todo_list/data/notifier.dart';
import '../../data/constant.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.date,
  });

  final String title;
  final String subtitle;
  final String? date;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isRed,
      builder: (context, value, child) {
        return Dismissible(
          key: Key(widget.title),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Todo item dismissed: ${widget.title}')),
            );
          },
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: primaryColor.withValues(alpha: 0.4),
              onTap: () {},
              leading: SizedBox(
                height: fiftyPercentHeight(context),
                width: tenPercentWidth(context),
                child: IconButton(
                  onPressed: () {
                    isRed.value = !isRed.value; // Toggle color state
                  },
                  icon: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 8,
                  ),
                ),
              ),
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
                  Text("Due date: ${widget.date}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
