import 'package:flutter/material.dart';
import 'package:note_app/common/app_colors.dart';

class AppThemes {
  static const String fontFamily = "Poppins";

  static ThemeData get lightTheme => ThemeData(
      fontFamily: fontFamily,
      scaffoldBackgroundColor: AppColors.lightPrimary,
      textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.darkPrimary),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: AppColors.darkPrimary,
          ),
          headlineSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.darkPrimary),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.darkPrimary,
          ),
          bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.lightPlaceHolder)));

  static ThemeData get darkTheme => ThemeData();
}
