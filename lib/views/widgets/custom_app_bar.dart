import 'package:app_front/styles/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
