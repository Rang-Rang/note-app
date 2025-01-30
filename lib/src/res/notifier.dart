import 'package:flutter/material.dart';

ValueNotifier<bool> isPin = ValueNotifier(false);
ValueNotifier<bool> isDarkNotifier = ValueNotifier(false);
ValueNotifier<bool> isListViews = ValueNotifier(true);

ValueNotifier<bool> isAtTop = ValueNotifier(true);
ValueNotifier<Position> scrollButtonPosition = ValueNotifier(Position.bottom);
ValueNotifier<Icon> scrollButtonIcon =
    ValueNotifier(Icon(Icons.arrow_downward));

ValueNotifier<bool> isAtTopHome = ValueNotifier(true);
ValueNotifier<Position> scrollButtonPositionHome = ValueNotifier(Position.top);
ValueNotifier<Icon> scrollButtonIconHome =
    ValueNotifier(Icon(Icons.arrow_downward));

ValueNotifier<int> avatarColorIndexNotifier = ValueNotifier(0);

Brightness get darkMode {
  return isDarkNotifier.value ? Brightness.light : Brightness.dark;
}

Icon get pin {
  return isPin.value
      ? Icon(Icons.push_pin_rounded)
      : Icon(Icons.push_pin_outlined);
}

Icon get listViews {
  return isListViews.value ? Icon(Icons.splitscreen) : Icon(Icons.grid_view);
}

final List<Color> lightModeColors = [
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.red,
  Colors.teal,
  Colors.cyan,
  Colors.amber,
  Colors.indigo,
  Colors.deepOrange,
];

final List<Color> darkModeColors = [
  Colors.blueGrey,
  Colors.cyan,
  Colors.deepPurple,
  Colors.greenAccent,
  Colors.redAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.lightBlueAccent,
  Colors.amberAccent,
  Colors.tealAccent,
];

enum Position { top, bottom }
