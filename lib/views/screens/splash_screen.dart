import 'package:app_front/styles/styles.dart';
import 'package:app_front/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.firstBrand,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(padding: EdgeInsets.only(bottom: 20), 
            child: SvgPicture.asset('assets/images/logo__full_color_white_eyes.svg'),
          ),
          Text("FURELY", style: AppFonts.h1TextStyle,)
        ]),
      ),
    );
  }
}