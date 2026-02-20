import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/router/build_route.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/views/create_course_view.dart';
import 'package:sams_app/features/home/presentation/views/home_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutesName.splash,
    errorBuilder: (context, state) => const HomeView(),
    routes: [
      //* HOME ROUTES
      // Home view
      buildRoute(
        name: RoutesName.homeView,
        path: RoutesName.homeView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                getIt<HomeCubit>()..fetchMyCourses(role: UserRole.teacher),
            child: const HomeView(),
          );
        },
      ),
      // Create course view
      buildRoute(
        name: RoutesName.createCourseView,
        path: RoutesName.createCourseView,
        builder: (context, state) => const CreateCourseView(),
      ),
    ],
  );
}
