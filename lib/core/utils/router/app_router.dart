import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/router/build_route.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/features/home/data/repos/home_repo.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/views/create_course_view.dart';
import 'package:sams_app/features/home/presentation/views/home_view.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/views/profile_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/authTOHome',
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
    routes: [
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      buildRoute(
        name: 'authTOHome',
        path: '/authTOHome',
        builder: (context, state) => Scaffold(
          body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.goNamed(RoutesName.home);
              },
              child: const Text('Auth to Home'),
            ),
          ),
        ),
      ),
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      //* HOME ROUTES
      // Home view
      buildRoute(
        name: RoutesName.home,
        path: RoutesName.home,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              HomeCubit(getIt.get<HomeRepo>(), role: UserRole.teacher)
                ..fetchMyCourses(role: UserRole.teacher),
          child: const HomeView(),
        ),
      ),
      // Create course view
      buildRoute(
        name: RoutesName.createCourse,
        path: RoutesName.createCourse,
        builder: (context, state) {
          final homeCubit = state.extra as HomeCubit;

          return BlocProvider.value(
            value: homeCubit,
            child: const CreateCourseView(),
          );
        },
      ),

      //*PROFILE ROUTES
      // Profile view
      buildRoute(
        name: RoutesName.profile,
        path: RoutesName.profile,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              ProfileCubit(getIt.get<ProfileRepo>())..getUserProfile(),
          child: const ProfileView(),
        ),
      ),
    ],
  );
}
