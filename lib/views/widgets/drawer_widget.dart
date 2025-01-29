import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 12),
              child: Row(
                children: [
                  Text(
                    'Note App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),
            Card(
              margin: EdgeInsets.only(bottom: 6, left: 8, right: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Icon(Icons.description),
                title: const Text('Note'),
                onTap: () {},
              ),
            ),
            Card(
              margin: EdgeInsets.only(bottom: 6, left: 8, right: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Icon(Icons.checklist),
                title: const Text('TO-DO'),
                onTap: () {},
              ),
            ),
            Spacer(),
            Card(
              margin: EdgeInsets.only(bottom: 16, left: 8, right: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text('Exit', style: TextStyle(color: Colors.red)),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
