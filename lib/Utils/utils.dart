import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget submitButton({required String text, required Function onPressed}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget myTextField(BuildContext context,
    {required String label, required TextEditingController controller}) {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      height: 49,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * .9,
      decoration: const BoxDecoration(),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color.fromRGBO(0, 0, 0, 0.4))),
      ),
    ),
  );
}

Widget pickMediaButton({required Function onPressed, required String text}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget inputField(
    {required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}

class Themes {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.roboto(
          fontSize: 24,
          color: Colors.black,
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      headlineLarge: GoogleFonts.roboto(
          fontSize: 32,
          color: Colors.black,
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      headlineMedium: GoogleFonts.roboto(
          fontSize: 28,
          color: Colors.black,
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      headlineSmall: GoogleFonts.roboto(
          fontSize: 24,
          color: Colors.black,
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.roboto(
          fontSize: 18,
          color: Colors.black,
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      labelSmall: GoogleFonts.montserrat(
          fontSize: 16,
          color: Colors.white,
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 20,
          color: Colors.black,
          letterSpacing: .07,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700),
      bodyMedium: GoogleFonts.montserrat(
          fontSize: 16,
          color: const Color(0xFF2F3037),
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      bodySmall: GoogleFonts.roboto(
          fontSize: 14,
          color: const Color(0xFF6A6C7B),
          letterSpacing: .07,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      displayMedium: GoogleFonts.roboto(
          fontSize: 14,
          color: const Color(0xFF061D28),
          letterSpacing: .0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
    ),
    colorScheme: const ColorScheme(
        background: Colors.white,
        brightness: Brightness.dark,
        primary: Color(0xFF2E3B62),
        onPrimary: Colors.white,
        secondary: Color(0xFF93D2F3),
        onSecondary: Colors.white10,
        primaryContainer: Colors.transparent,
        secondaryContainer: Color.fromARGB(255, 5, 52, 49),
        error: Colors.red,
        tertiary: Colors.black,
        onError: Colors.white,
        onBackground: Colors.black,
        surface: Color(0xFF6A6C7B),
        onSurface: Color(0xFF2F3037)),
  );

  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.light,
    primaryColorDark: const Color.fromARGB(255, 250, 250, 250),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.roboto(
          fontSize: 24,
          color: Colors.white,
          letterSpacing: 0.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      headlineLarge: GoogleFonts.roboto(
          fontSize: 32,
          color: Colors.white,
          letterSpacing: 0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      headlineMedium: GoogleFonts.roboto(
          fontSize: 28,
          color: Colors.white,
          letterSpacing: 0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      headlineSmall: GoogleFonts.roboto(
          fontSize: 24,
          color: Colors.white,
          letterSpacing: 0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.roboto(
          fontSize: 12,
          color: Colors.white,
          letterSpacing: 0.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.roboto(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 0.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 0.07,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 0.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      bodySmall: GoogleFonts.roboto(
          fontSize: 14,
          color: Colors.white,
          letterSpacing: 0.07,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
      displayMedium: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.white,
          letterSpacing: 0.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400),
    ),
    colorScheme: ColorScheme(
        background: Colors.black,
        brightness: Brightness.light,
        primary: const Color(0xFF2E3B62),
        onPrimary: Colors.white,
        secondary: const Color(0xFF93D2F3),
        onSecondary: Colors.white10,
        primaryContainer: Colors.transparent,
        secondaryContainer: const Color.fromARGB(71, 5, 52, 49),
        error: Colors.red,
        tertiary: Colors.black,
        onError: Colors.white,
        onBackground: Colors.white,
        surface: Colors.grey.shade900,
        onSurface: Colors.grey.shade300),
  );
}
