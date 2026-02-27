import 'package:flutter/material.dart';
import 'package:sams_app/features/Grades/presentation/view/grades_tab_view.dart';
import 'package:sams_app/features/announcements/presentation/view/announcements_tab_view.dart';
import 'package:sams_app/features/assignments/presentation/view/assignments_tab_view.dart';
import 'package:sams_app/features/course_code/presentation/view/course_code_tab_view.dart';
import 'package:sams_app/features/live_sessions/presentation/view/live_sessions_tab_view.dart';
import 'package:sams_app/features/materials/presentation/view/materials_tab_view.dart';
import 'package:sams_app/features/members_list/presentation/view/members_list_tab_view.dart';
import 'package:sams_app/features/quizzes/presentation/view/quizzes_tab_view.dart';

List<Widget> getCourseTabsContent() {
  return const [
    MaterialsTabView(),
    AssignmentsTabView(),
    AnnouncementsTabView(),
    GradesTabView(),
    QuizzesTabView(),
    LiveSessionsTabView(),
    CourseCodeTabView(),
    MembersListTabView(),
  ];
}
