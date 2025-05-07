import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ElevatedButtonThemeData get buttonTheme => Theme.of(this).elevatedButtonTheme;
  OutlinedButtonThemeData get outlineButtonTheme => Theme.of(this).outlinedButtonTheme;
}
