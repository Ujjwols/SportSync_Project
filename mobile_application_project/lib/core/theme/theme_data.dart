import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Primary color for the application
    primarySwatch: Colors.orange,

    // Background color for the scaffold
    scaffoldBackgroundColor: Colors.white,

    // Default font family for the app
    fontFamily: 'Montserrat Regular',

    // AppBar theme customization
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'cursive',
        color: Colors.black,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
      toolbarHeight: 80.0, // Increased height to move title lower
      backgroundColor: Colors.white, // Background color for AppBar
      elevation: 0, // Removes shadow if desired
    ),

    // ElevatedButton theme customization
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Text color
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat Regular',
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size(200, 50), // Minimum size for buttons
        maximumSize: const Size(300, 50), // Optional maximum size
      ),
    ),

    // TextButton theme (optional)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blueGrey, // Text color
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // // FloatingActionButton theme (optional)
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: Colors.orange,
    //   foregroundColor: Colors.white, // Icon/text color
    // ),

    // InputDecoration theme for forms
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Color(0xFF6342a6)),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Montserrat Regular',
        color: Colors.black,
        fontSize: 14.0,
      ),
    ),
  );
}
