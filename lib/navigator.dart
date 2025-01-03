import 'package:flutter/material.dart';

class AppCustomNavigator {
  static void push(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void replace(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}