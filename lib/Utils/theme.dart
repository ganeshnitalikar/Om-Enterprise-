// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 244, 173, 131),
    primaryColor: Colors.blue, // Primary color
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.orange,
      background: Colors.white,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue, // AppBar color
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.orange, // Button background color
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        disabledBackgroundColor: Colors.white,
        textStyle: GoogleFonts.roboto(fontSize: 18),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: const Color.fromARGB(255, 205, 147, 147),
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      contentTextStyle: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.orange),
      ),
      labelStyle: const TextStyle(color: Colors.blue),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor:
          const Color.fromARGB(255, 234, 109, 37), // Drawer background
      elevation: 10,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blueGrey, // Primary color
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey,
      secondary: Colors.orange,
      background: Colors.black,
      surface: Colors.black,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onError: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey, // AppBar color
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orange, // Button background color
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        disabledBackgroundColor: Colors.white,
        textStyle: GoogleFonts.roboto(fontSize: 18),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[850],
      shadowColor: Colors.black54,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey[900],
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      contentTextStyle: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.orange),
      ),
      labelStyle: const TextStyle(color: Colors.orange),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[850],
      elevation: 10,
    ),
  );
}
