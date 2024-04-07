import 'package:app_front/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onPressed;


  const AuthButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => AppColors.white,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Colors.black26,
              width: 1,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 12),
              child: SvgPicture.asset(width: 40, height: 40, iconPath),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(text, style: AppFonts.buttonLabel,),
            ),
          ],
        ),
      ),
    );
  }
}
