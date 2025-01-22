import 'package:flutter/material.dart';
import 'package:app_front/views/widgets/greeting_section.dart';
import 'package:app_front/views/widgets/category_filter.dart';
import 'package:app_front/views/widgets/courses_list.dart';
import 'package:app_front/views/widgets/search_bar.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = 'All'; // Начальная категория

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingSection(),
              const SizedBox(height: 20),
              const CustomSearchBar(),
              const SizedBox(height: 20),
              CategoryFilter(
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory =
                        category; // Обновляем выбранную категорию
                    print(
                        "Selected Category: $selectedCategory"); // Выводим отладочную информацию
                  });
                },
              ),
              const SizedBox(height: 20),
              CoursesList(
                  selectedCategory:
                      selectedCategory), // Передаем выбранную категорию
            ],
          ),
        ),
      ),
    );
  }
}
