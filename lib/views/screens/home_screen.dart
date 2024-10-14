import 'package:app_front/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset('assets/images/icons/avatar.svg', width: 24),
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
          IconButton(
            onPressed: () {
              print("Notifications clicked");
            },
            icon: Icon(Icons.notifications_none_outlined),
            iconSize: 34,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 220,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 24,
                        ),
                        Text(
                          "Andrew Jhonson",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[400]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Mentors',
                                style: AppFonts.courseh3,
                              ),
                              Row(children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ])
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
