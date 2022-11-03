import 'package:flutter/material.dart';

class LightTheme {
  static final value = ThemeData.light().copyWith(
    primaryColor: Colors.white70,
    backgroundColor: Colors.teal[900],
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal[900],
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: Colors.white,
          border: Border.all(
            color: Colors.green,
            width: 2.0,
          )),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
    ),
    bottomAppBarColor: Colors.black54,
    focusColor: Colors.green,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.teal,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.teal,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.teal[700],
      suffixIconColor: Colors.teal[700],
      floatingLabelStyle: TextStyle(color: Colors.teal[700], fontSize: 20),
      counterStyle: TextStyle(color: Colors.teal[700], fontSize: 20),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.teal[700]!,
        ),
      ),
    ),
  );
}
