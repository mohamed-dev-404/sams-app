import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/router/build_route.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/general_error_page.dart';
import 'package:sams_app/features/Grades/presentation/view/grades_tab_view.dart';
import 'package:sams_app/features/announcements/presentation/view/announcements_tab_view.dart';
import 'package:sams_app/features/assignments/presentation/view/assignments_tab_view.dart';
import 'package:sams_app/features/course_code/presentation/view/course_code_tab_view.dart';
import 'package:sams_app/features/course_details/presentation/view/course_details_view.dart';
import 'package:sams_app/features/home/presentation/views/home_view.dart';
import 'package:sams_app/features/live_sessions/presentation/view/live_sessions_tab_view.dart';
import 'package:sams_app/features/materials/presentation/view/materials_tab_view.dart';
import 'package:sams_app/features/members_list/presentation/view/members_list_tab_view.dart';
import 'package:sams_app/features/quizzes/presentation/view/quizzes_tab_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final appRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutesName.courses,
    errorBuilder: (context, state) => const GeneralErrorPage(),
    routes: [
      buildRoute(
        name: RoutesName.courses,
        path: RoutesName.courses,
        builder: (context, state) => const HomeView(),
      ),

      // The ShellRoute wraps the layout around the changing tabs
      ShellRoute(
        builder: (context, state, child) {
          final courseId = state.pathParameters['courseId'] ?? '';
          final headerModel =
              state.extra as CourseHeaderCardModel? ??
              CourseHeaderCardModel(title: 'Course');

          return CourseDetailsView(
            courseId: courseId,
            headerModel: headerModel,
            child: child, // This is the tab content
          );
        },
        routes: [
          _buildTabRoute(
            RoutesName.materials,
            (id) => MaterialsTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.assignments,
            (id) => AssignmentsTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.announcements,
            (id) => AnnouncementsTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.grades,
            (id) => GradesTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.quizzes,
            (id) => QuizzesTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.liveSessions,
            (id) => LiveSessionsTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.courseCode,
            (id) => CourseCodeTabView(courseId: id),
          ),
          _buildTabRoute(
            RoutesName.membersList,
            (id) => MembersListTabView(courseId: id),
          ),
        ],
      ),
    ],
  );

  static GoRoute _buildTabRoute(
    String path,
    Widget Function(String courseId) viewBuilder,
  ) {
    return GoRoute(
      path: '/course/:courseId/$path',
      builder: (context, state) =>
          viewBuilder(state.pathParameters['courseId'] ?? ''),
    );
  }
}
