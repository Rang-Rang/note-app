import 'package:flutter/material.dart';

ValueNotifier<bool> isRed = ValueNotifier(false);
ValueNotifier<bool> isPin = ValueNotifier(false);
ValueNotifier<bool> isDarkNotifier = ValueNotifier(false);
ValueNotifier<bool> isAtTop = ValueNotifier(true);
ValueNotifier<Position> scrollButtonPosition = ValueNotifier(Position.top);
ValueNotifier<Icon> scrollButtonIcon = ValueNotifier(Icon(Icons.arrow_upward));

Color get primaryColor {
  return isRed.value ? Colors.red : Colors.green;
}

Brightness get darkMode {
  return isDarkNotifier.value ? Brightness.light : Brightness.dark;
}

Icon get pin {
  return isPin.value
      ? Icon(Icons.push_pin_rounded)
      : Icon(Icons.push_pin_outlined);
}

enum Position { top, bottom }
