import 'package:app_front/styles/app_fonts.dart';
import 'package:app_front/views/widgets/course-info.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 16),
      width: double.infinity, // Ширина как на макете
      decoration: BoxDecoration(
        color: Color(0xFFF0F5FA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/icons/course_avatar.png',
                width: 47.53,
                height: 59.23,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Graphic Design',
                    style: AppFonts.titleCourses,
                  ),
                  Text(
                    'Andrew Jhonson',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.favorite_border,
                color: Colors.pink,
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter course details...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CourseInfo('3 Chapters'),
              CourseInfo('30 Lessons'),
              CourseInfo('3h'),
            ],
          ),
        ],
      ),
    );
  }
}
