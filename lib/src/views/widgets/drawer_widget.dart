import 'package:flutter/material.dart';
import 'package:todo_list/src/views/widgets/drawer_card.dart';

import '../../res/notifier.dart';

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
            DrawerCard(
              title: 'Note',
              icon: Icon(Icons.description),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerCard(
              title: 'TO-DO',
              icon: Icon(Icons.checklist),
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.only(bottom: 6, left: 8, right: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: ValueListenableBuilder(
                  valueListenable: isDarkNotifier,
                  builder: (context, isDarkMode, child) {
                    return Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode);
                  },
                ),
                title: ValueListenableBuilder(
                  valueListenable: isDarkNotifier,
                  builder: (context, isDarkMode, child) {
                    return Text(isDarkMode ? "Dark mode" : "Light mode");
                  },
                ),
                onTap: () {
                  isDarkNotifier.value = !isDarkNotifier.value;
                },
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 6, left: 8, right: 8),
              child: DrawerCard(
                title: 'Exit',
                icon: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
