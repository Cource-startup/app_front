import 'package:flutter/material.dart';

class CustomFooter extends StatefulWidget {
  final Function(int) onItemSelected;
  final int currentIndex;

  const CustomFooter({
    super.key,
    required this.onItemSelected,
    required this.currentIndex,
  });

  @override
  _CustomFooterState createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  final List<Map<String, String>> _navigationItems = [
    {'image': 'assets/images/icons/home-footer.png', 'label': 'Home'},
    {'image': 'assets/images/icons/study-footer.png', 'label': 'Course'},
    {'image': 'assets/images/icons/like-footer.png', 'label': 'Favorites'},
    {'image': 'assets/images/icons/user-footer.png', 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _navigationItems.map((item) {
        final index = _navigationItems.indexOf(item);
        final isSelected = widget.currentIndex == index;

        return BottomNavigationBarItem(
          icon: Image.asset(
            item['image']!,
            height: 30,
            width: 30,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          label: item['label'],
        );
      }).toList(),
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: widget.onItemSelected,
      type: BottomNavigationBarType.fixed,
    );
  }
}
