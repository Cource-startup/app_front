import 'package:app_front/views/widgets/test_login_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(children: [
          Text('Hello World!'),
          TestLoginWidget(),
        ]),
      ),
    );
  }
}