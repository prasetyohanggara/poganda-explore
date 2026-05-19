import 'package:flutter/material.dart';

class AppTheme {
  // Color palette sesuai desain PogandaExplore
  static const Color primary = Color(0xFF006D6D);
  static const Color primaryDark = Color(0xFF004F4F);
  static const Color primaryLight = Color(0xFF4FC3F7);
  static const Color accent = Color(0xFF1B8A7E);
  static const Color background = Color(0xFFF5F5F0);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color feedbackBg = Color(0xFFE0F4F4);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          secondary: primaryLight,
          surface: const Color(0xFFF8F9FA),
        ),
        scaffoldBackgroundColor: background,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: textDark),
          headlineLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: textDark),
          headlineMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: textDark),
          titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: textDark),
          titleMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, color: textDark),
          bodyLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: textDark, height: 1.6),
          bodyMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: textGrey, height: 1.5),
          labelLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
      );
}
