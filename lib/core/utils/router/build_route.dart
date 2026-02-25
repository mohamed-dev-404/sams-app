import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_logger.dart';

GoRoute buildRoute({
  required String name,
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    name: name,
    path: path,
    pageBuilder: (context, state) {
      AppLogger.info('Navigating to: $name, tag: "ROUTER');

      return MaterialPage(child: builder(context, state));
    },
  );
}
