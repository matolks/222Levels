import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Universal Colors
class AppColors {
  static const Color backgroundColor = Color(0xff222222);
  static const Color darkerGrey = Color(0xFF333333);
  static const Color darkGrey = Color(0xFF444444);
  static const Color middleGrey = Color(0xFFA1A1A1);
  static const Color lightGrey = Color(0xFFD2D2D2);
  static const Color babyv = Color(0xFF8AAAE5);
  static const Color redError = Color(0xffE92A2A);
}

// Centered Text
Text appText(
  String text,
  Color color,
  double fontSize,
  FontWeight fontWeight,
) {
  return Text(text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: TextDecoration.none),
      ),
      textAlign: TextAlign.center);
}

// Left Test
Text appText2(
  String text,
  Color color,
  double fontSize,
  FontWeight fontWeight,
) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: TextDecoration.none),
    ),
  );
}
