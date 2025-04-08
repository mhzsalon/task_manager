import 'package:flutter/material.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/utils/dimens.dart';

class AppTextTheme {
  static TextStyle labelText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: font10,
    color: AppColors.primaryColor,
  );
  static TextStyle subTitleText = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: font12,
    color: AppColors.primaryColor,
  );
  static TextStyle bodyText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: font14,
    color: AppColors.primaryColor,
  );

  static TextStyle titleText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: font16,
    color: AppColors.primaryColor,
  );

  static TextStyle headingText = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: font20,
    color: AppColors.primaryColor,
  );
}
