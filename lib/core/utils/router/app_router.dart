import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/router/build_route.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/general_error_page.dart';
import 'package:sams_app/features/Grades/presentation/view/grades_tab_view.dart';
import 'package:sams_app/features/announcements/presentation/view/announcements_tab_view.dart';
import 'package:sams_app/features/assignments/presentation/view/assignments_tab_view.dart';
import 'package:sams_app/features/course_code/presentation/view/course_code_tab_view.dart';
import 'package:sams_app/features/course_details/presentation/view/course_details_view.dart';
import 'package:sams_app/features/live_sessions/presentation/view/live_sessions_tab_view.dart';
import 'package:sams_app/features/materials/presentation/view/materials_tab_view.dart';
import 'package:sams_app/features/members_list/presentation/view/members_list_tab_view.dart';
import 'package:sams_app/features/quizzes/presentation/view/quizzes_tab_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '${RoutesName.courseDetails}/${RoutesName.materials}',
    errorBuilder: (context, state) => const GeneralErrorPage(),
    routes: [
      //* COURSE DETAILS (Nested Routing)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CourseDetailsView(navigationShell: navigationShell);
        },
        branches: [
          _buildBranch(RoutesName.materials, const MaterialsTabView()),
          _buildBranch(RoutesName.assignments, const AssignmentsTabView()),
          _buildBranch(RoutesName.announcements, const AnnouncementsTabView()),
          _buildBranch(RoutesName.grades, const GradesTabView()),
          _buildBranch(RoutesName.quizzes, const QuizzesTabView()),
          _buildBranch(RoutesName.liveSessions, const LiveSessionsTabView()),
          _buildBranch(RoutesName.courseCode, const CourseCodeTabView()),
          _buildBranch(RoutesName.membersList, const MembersListTabView()),
        ],
      ),

      /// buildRoute(
      ///   name: RoutesName.homeView,
      ///   path: RoutesName.homeView,
      ///   builder: (context, state) {
      ///     final args = state.extra as UserModel;
      ///    return BlocProvider(
      ///       create: (context) => sl<HomeCubit>(),
      ///       child: Homeview(args: args),
      ///     );
      ///   },
      ///),
      //... more buildRoute calls
    ],
  );
  static StatefulShellBranch _buildBranch(String path, Widget view) {
    return StatefulShellBranch(
      routes: [
        buildRoute(
          name: path,
          path: '${RoutesName.courseDetails}/$path',
          builder: (context, state) => view,
        ),
      ],
    );
  }
}
