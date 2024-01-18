import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const String fontFamily = 'Roboto';

  static TextTheme get theme => const TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          letterSpacing: -1.5,
          fontFamily: fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.5,
          fontFamily: fontFamily,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          fontFamily: fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,
        ),
      );
}
