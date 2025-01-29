import 'package:flutter/material.dart';
import 'package:todo_list/data/constant.dart';
import 'package:todo_list/data/notifier.dart';
import 'package:todo_list/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorKey.seedColor,
              brightness: darkMode,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: WidgetTree(),
        );
      },
    );
  }
}
