import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins', // optional custom font
  useMaterial3: true,

  textTheme: TextTheme(
    // headline2
    displayMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      letterSpacing: .5
    ),
    //headline3
    displaySmall: GoogleFonts.roboto(
      fontWeight: FontWeight.normal,
      fontSize: 20,
      letterSpacing: .35,
      color: const Color(0xFF8E8E93)
    ),
    //body/body 17/regular
    bodyMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.normal,
      fontSize: 17,
      letterSpacing: .35,
      color: const Color(0xFF8E8E93)
    ),
    //tagline 15
    labelMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        letterSpacing: .41,
        color: const Color(0xFF8E8E93),
    ),
  ),
);
