import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/profile_picture.png'), // Пример изображения профиля
            ),
            SizedBox(height: 16),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.green),
              title: Text('Edit Profile'),
              onTap: () {
                // Логика для редактирования профиля
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.green),
              title: Text('Notifications'),
              onTap: () {
                // Логика для перехода к уведомлениям
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.green),
              title: Text('Settings'),
              onTap: () {
                // Логика для перехода в настройки
              },
            ),
            Divider(),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Log Out'),
              onTap: () {
                // Логика для выхода из аккаунта
              },
            ),
          ],
        ),
      ),
    );
  }
}
