import 'package:flutter/material.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1),
      colorScheme: const ColorScheme.light(
        surface: Color.fromARGB(26, 13, 184, 247),
      ));
  //
  // primaryColor: Colors.blue,
  // primaryColorLight: Colors.blue,
  // primaryColorDark: Colors.blue,
  // accentColor: Colors.blue,
  // backgroundColor: Colors.white,
  // scaffoldBackgroundColor: Colors.white,
  // bottomAppBarColor: Colors.white,
  // cardColor: Colors.white,
  // dividerColor: Colors.white,
  // errorColor: Colors.white,
  // buttonColor: Colors.blue,
  // disabledColor: Colors.blue,
  // hintColor: Colors.blue,
  // highlightColor: Colors.blue,
  // indicatorColor: Colors.blue,
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.teal,
      ));
}
