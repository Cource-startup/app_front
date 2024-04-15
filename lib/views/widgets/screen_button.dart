import 'package:app_front/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? iconPath;
  final Color color;
  final Color textColor;
  final double? border;

  const ScreenButton(
    this.text,
    this.onPressed, {
    super.key,
    this.iconPath,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => color,
        ),
        shape: MaterialStateProperty.all(
          border != null ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.black26,
              width: border ?? 0.0,
            ),
          ) : null,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            iconPath != null ? Padding(
              padding: const EdgeInsets.only(right: 10, left: 12),
              child: SvgPicture.asset(width: 40, height: 40, iconPath ?? ''),
            ) : Container(),
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
