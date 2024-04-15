import 'package:app_front/styles/styles.dart';
import 'package:app_front/views/widgets/screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0), 
              child: Text('Create your account', style: AppFonts.h2) ,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SvgPicture.asset(
                      'assets/images/logo__white_on_blue_square.svg',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
              child: ScreenButton(
                "Create account",
                () {
                  print("Create account for ${_usernameController.text}");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Alert"),
                        content: Text(
                            "Create account for ${_usernameController.text}"),
                        actions: [
                          TextButton(
                            child: Text("ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                color: AppColors.firstBrand,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
