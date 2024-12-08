import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Courses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Icon(
                      Icons.school,
                      size: 40,
                      color: Colors.blue,
                    ),
                    title: Text('Course ${index + 1}',
                        style: TextStyle(fontSize: 18)),
                    subtitle: Text(
                        'Course description goes here. This is a placeholder text for the course detail.'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Можете добавить действие при клике
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
