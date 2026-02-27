import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';

part 'course_navigation_state.dart';

class CourseNavigationCubit extends Cubit<int> {
  final UserRole userRole;
  CourseNavigationCubit({required this.userRole}) : super(0);

  final List<String> _allTabs = [
    'Materials',
    'Assignments',
    'Announcements',
    'Grades',
    'Quizzes',
    'Live Sessions',
    'Course Code',
    'Members List',
  ];

  List<String> get tabs {
    if (userRole == UserRole.student) {
      return _allTabs.where((tab) => tab != 'Members List').toList();
    }
    return _allTabs;
  }
}
