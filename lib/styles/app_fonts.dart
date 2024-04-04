import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFonts {
  static TextStyle h1TextStyle = TextStyle(
    fontFamily: 'Baloo2',
    fontSize: 26, 
    color: AppColors.back, 
    fontWeight: FontWeight.bold
  );

  static TextStyle h2TextStyle = TextStyle(
      fontSize: 21, color: AppColors.back, fontWeight: FontWeight.bold);

  static TextStyle textStyle = TextStyle(
      fontSize: 17, color: AppColors.back, fontWeight: FontWeight.w500);
}
