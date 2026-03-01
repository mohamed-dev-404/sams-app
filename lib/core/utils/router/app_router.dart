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
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';
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

      GoRoute(
        path: '/course/:courseId',
        redirect: (context, state) {
          final courseId = state.pathParameters['courseId'];
          if (state.uri.path == '/course/$courseId') {
            return '/course/$courseId/${RoutesName.materials}';
          }
          return null;
        },
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              final courseId = state.pathParameters['courseId'] ?? '';
              final headerModel =
                  state.extra as CourseHeaderCardModel? ??
                  CourseHeaderCardModel(title: 'eee ee');

              return CourseDetailsView(
                navigationShell: navigationShell,
                headerModel: headerModel,
                courseId: courseId,
              );
            },
            branches: [
              _buildBranch(
                RoutesName.materials,
                (courseId) => MaterialsTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.assignments,
                (courseId) => AssignmentsTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.announcements,
                (courseId) => AnnouncementsTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.grades,
                (courseId) => GradesTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.quizzes,
                (courseId) => QuizzesTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.liveSessions,
                (courseId) => LiveSessionsTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.courseCode,
                (courseId) => CourseCodeTabView(courseId: courseId),
              ),
              _buildBranch(
                RoutesName.membersList,
                (courseId) => MembersListTabView(courseId: courseId),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static StatefulShellBranch _buildBranch(
    String path,
    Widget Function(String courseId) viewBuilder, {
    bool instructorOnly = false,
  }) {
    return StatefulShellBranch(
      routes: [
        GoRoute(
          name: path,
          path: path,
          builder: (context, state) {
            final courseId = state.pathParameters['courseId'] ?? '';
            return viewBuilder(courseId);
          },
          redirect: (context, state) {
            if (instructorOnly) {
              // TODO: Get actual role from Auth Cache
              const role = UserRole.instructor;
              return role == UserRole.student ? RoutesName.courses : null;
            }
            return null;
          },
        ),
      ],
    );
  }
}
