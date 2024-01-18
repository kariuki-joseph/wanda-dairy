import 'package:flutter/material.dart';
import 'package:wanda_dairy/themes/text_theme.dart';

class AppTheme {
  const AppTheme._();
  static const Color _primaryColor = Color.fromRGBO(103, 80, 164, 1);
  static const Color _primaryVariantColor = Color.fromARGB(255, 247, 247, 247);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: _primaryColor,
      primaryColorDark: _primaryVariantColor,
      textTheme: AppTextTheme.theme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        background: const Color(0XFFFAFAF3),
        secondary: const Color(0xFFB9B9B9),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFB9B9B9),
        selectedItemColor: _primaryColor,
        unselectedItemColor: Colors.black54,
      ),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
    );
  }
}
