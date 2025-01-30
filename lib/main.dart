import 'package:flutter/material.dart';
import 'package:todo_list/src/res/constant.dart';
import 'package:todo_list/src/res/notifier.dart';
import 'package:todo_list/src/views/widget_tree.dart';

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
          title: AppStrings.appName,
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
