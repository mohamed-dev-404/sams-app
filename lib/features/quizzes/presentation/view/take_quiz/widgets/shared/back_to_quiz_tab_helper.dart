import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';

void backToQuizTab({
  required BuildContext context,
}) {
  kIsWeb
      ? context.goNamed(
          RoutesName.quizzes,
          pathParameters: {
            'courseId': getCourseId(
              context,
            ), // Required by the parent ShellRoute/Tab
            
          },
        )
      : context.pushReplacementNamed(
          RoutesName.quizzes,
          pathParameters: {
            'courseId': getCourseId(
              context,
            ), // Required by the parent ShellRoute/Tab
          },
        );
}

String getCourseId(BuildContext context) =>
    GoRouterState.of(context).pathParameters['courseId'] ?? '';
