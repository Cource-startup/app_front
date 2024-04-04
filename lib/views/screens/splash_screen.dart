import 'package:app_front/styles/app_fonts.dart';
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
    Timer(Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column (children: [
          SvgPicture.asset('assets/images/logo__full_color_white_eyes.svg'),
          const SizedBox(height: 20,),
          Text("FURELY", style: AppFonts.h1TextStyle,),
        ]),
      ),
    );
  }
}