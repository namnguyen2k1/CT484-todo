import 'package:flutter/material.dart';

class DarkTheme {
  static final value = ThemeData.dark().copyWith(
    primaryColor: Colors.black54,
    backgroundColor: Colors.black54,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black54,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    tabBarTheme: TabBarTheme(
      labelStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: Colors.white,
          border: Border.all(
            color: Colors.deepOrange,
            width: 2.0,
          )),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.white60,
    ),
    bottomAppBarColor: Colors.grey,
    focusColor: Colors.deepOrange,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.orange,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.deepOrange,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      prefixIconColor: Colors.deepOrange,
      suffixIconColor: Colors.deepOrange,
      floatingLabelStyle: TextStyle(color: Colors.deepOrange, fontSize: 20),
      counterStyle: TextStyle(color: Colors.deepOrange, fontSize: 20),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.deepOrange,
        ),
      ),
    ),
  );
}
