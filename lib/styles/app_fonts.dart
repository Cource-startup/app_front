import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFonts {
  static TextStyle h1 = TextStyle(
      fontFamily: 'Baloo2',
      fontSize: 72,
      color: AppColors.white,
      fontWeight: FontWeight.w900);

  static TextStyle buttonLabel = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      color: AppColors.back,
      fontWeight: FontWeight.w600);

  static TextStyle strong = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      color: AppColors.back,
      fontWeight: FontWeight.w800);

  static TextStyle h2TextStyle = TextStyle(
      fontSize: 21, color: AppColors.back, fontWeight: FontWeight.bold);

  static TextStyle textStyle = TextStyle(
      fontSize: 17, color: AppColors.back, fontWeight: FontWeight.w500);
}
