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

Brightness get darkMode {
  return isDarkNotifier.value ? Brightness.light : Brightness.dark;
}

Icon get pin {
  return isPin.value
      ? Icon(Icons.push_pin_rounded)
      : Icon(Icons.push_pin_outlined);
}

Icon get listViews {
  return isListViews.value ? Icon(Icons.grid_view) : Icon(Icons.splitscreen);
}

enum Position { top, bottom }
