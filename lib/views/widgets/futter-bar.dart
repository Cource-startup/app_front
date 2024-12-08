import 'package:flutter/material.dart';

class CustomFooter extends StatefulWidget {
  final Function(int)
      onItemSelected; // Коллбек для передачи индекса выбранной вкладки
  final int currentIndex; // Текущий индекс (для подсветки активного элемента)

  const CustomFooter({
    Key? key,
    required this.onItemSelected,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _CustomFooterState createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  final List<Map<String, String>> _navigationItems = [
    {'image': 'assets/images/icons/home-footer.png', 'label': 'Home'},
    {'image': 'assets/images/icons/study-footer.png', 'label': 'Course'},
    {'image': 'assets/images/icons/like-footer.pnh', 'label': 'Favorites'},
    {'image': 'assets/images/icons/user-footer.png', 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _navigationItems
          .map((item) => BottomNavigationBarItem(
                icon: Image.asset(
                  item['image']!,
                  height: 24,
                  width: 24,
                ),
                label: item['label'],
              ))
          .toList(),
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.blue, // Цвет активной вкладки
      unselectedItemColor: Colors.grey, // Цвет неактивных вкладок
      onTap: widget.onItemSelected,
      type: BottomNavigationBarType.fixed, // Для фиксированной ширины
    );
  }
}
