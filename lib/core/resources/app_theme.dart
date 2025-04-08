import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/dimens.dart';

class AppTheme {
  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  static final lightThemeMode = ThemeData(
    scaffoldBackgroundColor: AppColors.white,

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.white),
      centerTitle: false,
      titleTextStyle: AppTextTheme.headingText.copyWith(
        fontSize: font24,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          AppColors.primaryColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    fontFamily: GoogleFonts.poppins().fontFamily,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.color888888),
      hintStyle: AppTextTheme.subTitleText.copyWith(
        color: AppColors.color888888,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.primaryColor),
      errorBorder: _border(AppColors.redColor),
      focusedErrorBorder: _border(AppColors.primaryColor),
    ),
    useMaterial3: false,
  );
}
