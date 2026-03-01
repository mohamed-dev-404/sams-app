import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';

part 'course_navigation_state.dart';

class CourseTabItem {
  final String title;
  final int branchIndex;

  CourseTabItem({required this.title, required this.branchIndex});
}

class CourseNavigationCubit extends Cubit<int> {
  final UserRole userRole;
  CourseNavigationCubit({required this.userRole}) : super(0);
  final List<CourseTabItem> _allTabs = [
    CourseTabItem(title: 'Materials', branchIndex: 0),
    CourseTabItem(title: 'Assignments', branchIndex: 1),
    CourseTabItem(title: 'Announcements', branchIndex: 2),
    CourseTabItem(title: 'Grades', branchIndex: 3),
    CourseTabItem(title: 'Quizzes', branchIndex: 4),
    CourseTabItem(title: 'Live Sessions', branchIndex: 5),
    CourseTabItem(title: 'Course Code', branchIndex: 6),
    CourseTabItem(title: 'Members List', branchIndex: 7),
  ];

  List<CourseTabItem> get visibleTabs {
    if (userRole == UserRole.student) {
      return _allTabs.where((tab) => tab.title != 'Members List').toList();
    }
    return _allTabs;
  }

  int getUiIndexFromBranch(int branchIndex) {
    final index = visibleTabs.indexWhere(
      (tab) => tab.branchIndex == branchIndex,
    );
    return index == -1 ? 0 : index;
  }
}
