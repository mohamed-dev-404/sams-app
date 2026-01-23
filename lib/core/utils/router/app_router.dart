import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/general_error_page.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutesName.splash,
    errorBuilder: (context, state) => const GeneralErrorPage(),
    routes: [
      /// buildRoute(
      ///   name: RoutesName.splash,
      ///   path: RoutesName.splash,
      ///   builder: (context, state) => const SplashView(),
      /// ),
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
}
