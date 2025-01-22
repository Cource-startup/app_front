import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome John',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Latest courses',
              style: TextStyle(fontSize: 16, color: Colors.black,  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ],
    );
  }
}
