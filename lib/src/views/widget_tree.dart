import 'package:flutter/material.dart';
import 'package:todo_list/src/views/widgets/drawer_widget.dart';
import '../res/notifier.dart';
import 'pages/home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ValueListenableBuilder(
              valueListenable: isListViews,
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    isListViews.value = !isListViews.value;
                  },
                  icon: listViews,
                );
              },
            ),
          ),
        ],
      ),
      body: HomePage(),
    );
  }
}
