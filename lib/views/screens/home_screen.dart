import 'package:app_front/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/icons/notifications.svg',
              width: 44,
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
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
