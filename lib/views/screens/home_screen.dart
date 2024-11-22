import 'package:app_front/styles/styles.dart';
import 'package:app_front/views/widgets/course-card.dart';
import 'package:app_front/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                                    Image.asset(
                                      'assets/images/icons/mentors_icon.png',
                                      width: 42,
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
                        SizedBox(height: 17),
                        Container(
                          width: double.infinity,
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
                                Row(
                                  children: [
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
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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
                      itemCount: 3,
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
