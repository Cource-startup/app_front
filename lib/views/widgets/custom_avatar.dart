import 'dart:io';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? avatar; // Optional avatar parameter
  final double radius;

  const CustomAvatar({
    super.key,
    this.avatar, // Optional now
    this.radius = 50.0, // Default radius
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: avatar != null && avatar!.isNotEmpty
          ? (avatar!.startsWith('http')
              ? NetworkImage(avatar!)
              : (File(avatar!).existsSync()
                  ? FileImage(File(avatar!))
                  : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider))
          : const AssetImage('assets/images/default_avatar.png'),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
