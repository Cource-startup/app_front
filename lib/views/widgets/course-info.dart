import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  final String text;

  CourseInfo(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFEBECF2),
          width: 1.0,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
