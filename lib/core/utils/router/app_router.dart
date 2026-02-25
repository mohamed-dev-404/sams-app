import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/router/build_route.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'package:sams_app/core/widgets/general_error_page.dart';

// Repos & Cubits
import 'package:sams_app/features/auth/data/repos/auth_repo.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_cubit.dart';

// Views
import 'package:sams_app/features/auth/presentation/views/sign_up/activate_account_view.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:sams_app/features/auth/presentation/views/login/login_view.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/forgot_password_view.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/reset_password_view.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/verify_otp_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutesName.login,
    errorBuilder: (context, state) => const GeneralErrorPage(),
    routes: [
      //* 1. LOGIN ROUTE
      buildRoute(
        name: RoutesName.login,
        path: RoutesName.login,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getIt<AuthRepo>()),
          child: const LoginView(),
        ),
      ),

      //* 2. SIGN UP FLOW SHELL
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => SignUpCubit(getIt<AuthRepo>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: RoutesName.signUp,
            path: RoutesName.signUp,
            builder: (context, state) => const SignUpView(),
          ),
          GoRoute(
            name: RoutesName.activateAccount,
            path: RoutesName.activateAccount, // The OTP screen for Sign Up
            builder: (context, state) => const ActivateAccountView(),
          ),
        ],
      ),

      //* 3. PASSWORD RESET FLOW SHELL
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => PasswordResetCubit(getIt<AuthRepo>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: RoutesName.forgotPassword,
            path: RoutesName.forgotPassword,
            builder: (context, state) => const ForgotPasswordView(),
          ),
          GoRoute(
            name: RoutesName.verifyOtp,
            path: RoutesName.verifyOtp, // The OTP screen for Password Reset
            builder: (context, state) => const VerifyOtpView(),
          ),
          GoRoute(
            name: RoutesName.resetPassword,
            path: RoutesName.resetPassword,
            builder: (context, state) => const ResetPasswordView(),
          ),
        ],
      ),
    ],
  );
}
