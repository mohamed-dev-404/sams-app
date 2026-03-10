import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';

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
    CourseTabItem(title: 'Materials', path: RoutesName.materials),
    CourseTabItem(title: 'Assignments', path: RoutesName.assignments),
    CourseTabItem(title: 'Announcements', path: RoutesName.announcements),
    CourseTabItem(title: 'Grades', path: RoutesName.grades),
    CourseTabItem(title: 'Quizzes', path: RoutesName.quizzes),
    CourseTabItem(title: 'Live Sessions', path: RoutesName.liveSessions),
    CourseTabItem(title: 'Course Code', path: RoutesName.courseCode),
    CourseTabItem(title: 'Members List', path: RoutesName.membersList),
  ];

  List<CourseTabItem> get visibleTabs {
    if (userRole == UserRole.student) {
      return _allTabs.where((tab) => tab.title != 'Members List').toList();
    }
    return _allTabs;
  }
}
