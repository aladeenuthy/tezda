
import 'package:flutter/material.dart';

import '../utils/constants.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgColor,
    appBarTheme: ThemeData.light()
        .appBarTheme
        .copyWith(backgroundColor: bgColor, elevation: 0),
    colorScheme: ThemeData().colorScheme.copyWith(primary: greyColor),
    inputDecorationTheme: _inputTheme(),
    textTheme: _textTheme(),
    textButtonTheme: _textButtonTheme(),
    elevatedButtonTheme: _elevatedButtonTheme(),
  );
}

InputDecorationTheme _inputTheme() {
  return const InputDecorationTheme(
      hintStyle: TextStyle(
          color: greyColor, fontWeight: FontWeight.bold, fontSize: 19));
}

ElevatedButtonThemeData _elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 53),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))));
}

TextButtonThemeData _textButtonTheme() {
  return TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(color: primaryColor)));
}

TextTheme _textTheme() {
  return ThemeData.light().textTheme.copyWith(
        headlineLarge: const TextStyle(fontSize: 35, color: Colors.black),
        headlineMedium: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        headlineSmall:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
}
