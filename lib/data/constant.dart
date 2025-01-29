import 'package:flutter/material.dart';

double fiftyPercentHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 0.5;
}

double tenPercentWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.1;
}

class ColorKey {
  static Color seedColor = Colors.deepPurpleAccent;
}
