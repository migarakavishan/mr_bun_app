import 'package:flutter/material.dart';

class CustomNavigators {
  // Navigate to a new screen
  static void goTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
