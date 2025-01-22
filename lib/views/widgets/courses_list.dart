import 'package:flutter/material.dart';
import 'course_card.dart';
import 'course.dart';

class CoursesList extends StatelessWidget {
  final String selectedCategory;

  const CoursesList({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Пример данных
    final List<Course> allCourses = [
      Course(
        title: 'Graphic Design',
        category: 'Art',
        duration: '3 hours',
        likes: 23,
        instructor: 'Andrew Jhonson',
      ),
      Course(
        title: 'Physics 101',
        category: 'Physics',
        duration: '5 hours',
        likes: 15,
        instructor: 'Dr. Smith',
      ),
      Course(
        title: 'Music Theory',
        category: 'Music',
        duration: '4 hours',
        likes: 30,
        instructor: 'Lisa Brown',
      ),
      Course(
        title: 'Mathematics for Beginners',
        category: 'Math',
        duration: '2 hours',
        likes: 10,
        instructor: 'John Doe',
      ),
      Course(
        title: 'Mathematics for Beginners',
        category: 'Math',
        duration: '2 hours',
        likes: 10,
        instructor: 'John Doe',
      ),
    ];

    final filteredCourses = selectedCategory == 'All'
        ? allCourses
        : allCourses
            .where((course) => course.category == selectedCategory)
            .toList();

    print("Filtered Courses: ${filteredCourses.length}");

    return SizedBox(
      height: 500,
      child: ListView.builder(
        key: ValueKey(selectedCategory),
        itemCount: filteredCourses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: filteredCourses[index]);
        },
      ),
    );
  }
}
