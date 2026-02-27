import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'course_navigation_state.dart';

class CourseNavigationCubit extends Cubit<int> {
  CourseNavigationCubit() : super(0);

  final List<String> tabs = [
    'Materials',
    'Assignments',
    'Announcements',
    'Grades',
    'Quizzes',
    'Live Sessions',
    'Course Code',
    'Members List',
  ];

  void changeTab(int index) => emit(index);
}
