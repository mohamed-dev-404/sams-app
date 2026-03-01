import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';

part 'course_navigation_state.dart';

class CourseTabItem {
  final String title;
  final String path;

  CourseTabItem({required this.title, required this.path});
}

class CourseNavigationCubit extends Cubit<int> {
  final UserRole userRole;
  CourseNavigationCubit({required this.userRole}) : super(0);

  final List<CourseTabItem> _allTabs = [
    CourseTabItem(title: 'Materials', path: 'materials'),
    CourseTabItem(title: 'Assignments', path: 'assignments'),
    CourseTabItem(title: 'Announcements', path: 'announcements'),
    CourseTabItem(title: 'Grades', path: 'grades'),
    CourseTabItem(title: 'Quizzes', path: 'quizzes'),
    CourseTabItem(title: 'Live Sessions', path: 'liveSessions'),
    CourseTabItem(title: 'Course Code', path: 'courseCode'),
    CourseTabItem(title: 'Members List', path: 'membersList'),
  ];

  List<CourseTabItem> get visibleTabs {
    if (userRole == UserRole.student) {
      return _allTabs.where((tab) => tab.title != 'Members List').toList();
    }
    return _allTabs;
  }
}
