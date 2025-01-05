import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_front/service/user/user_provider.dart';
import 'package:app_front/views/screen_contents/home_content.dart';
import 'package:app_front/views/screen_contents/setting_content.dart';
import 'package:app_front/views/widgets/custom_avatar.dart';

class MainScreen extends ConsumerStatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0; // Track the selected tab

  // List of screens for each tab
  static final List<Widget> _screens = <Widget>[
    HomeContent(), // Home content widget
    SettingsContent(), // Settings screen widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the user data
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Home' : 'Settings'),
        actions: [
          Row(
            children: [
              Text(
                user.login, // Display user login
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(width: 8),
              CustomAvatar(
                radius: 20,
                avatar: user.avatar,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Display the selected screen content
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
