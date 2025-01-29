import 'package:flutter/material.dart';
import 'package:todo_list/views/pages/home_page.dart';
import 'package:todo_list/views/widgets/drawer_widget.dart';
import 'package:todo_list/views/widgets/floating_button_widget.dart';

import '../data/notifier.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                isDarkNotifier.value = !isDarkNotifier.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: isDarkNotifier,
                builder: (context, isDarkMode, child) {
                  return Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode);
                },
              ),
            ),
          ),
        ],
      ),
      body: HomePage(),
      floatingActionButton: FloatingButtonWidget(),
    );
  }
}
