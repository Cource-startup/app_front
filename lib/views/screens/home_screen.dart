import 'package:app_front/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/images/icons/avatar.jpg', width: 44),
            ),
            SizedBox(width: 8),
            Text(
              'Username',
              style: AppFonts.h3,
              textAlign: TextAlign.center,
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Image.asset('assets/images/icons/notifications_icon.jpg',
                width: 44),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Первый контейнер
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 240,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF0F5FA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming',
                            style: AppFonts.courseh3,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'UI Prototyping',
                            style: AppFonts.titleCourses,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                  'assets/images/icons/course_avatar.png',
                                  width: 24),
                              Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text(
                                  "Andrew Jhonson",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mentors',
                                  style: AppFonts.courseh3,
                                ),
                                SizedBox(height: 18),
                                Row(
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0, 0),
                                      child: Image.asset(
                                        'assets/images/icons/mentors_icon.png',
                                        width: 42,
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset(-16, 0),
                                      child: Image.asset(
                                        'assets/images/icons/mentor_icon2.png',
                                        width: 42,
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset(-32, 0),
                                      child: Image.asset(
                                        'assets/images/icons/mentors_icon3.png',
                                        width: 42,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        size: 24, color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Active courses',
                                    style: AppFonts.courseh3),
                                SizedBox(height: 24),
                                Row(children: [
                                  Text(
                                    '12',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 24,
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Latest courses', style: AppFonts.titleCourses),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3, // замените на количество курсов
                      itemBuilder: (context, index) {
                        return CourseCard();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        ));
  }
}
