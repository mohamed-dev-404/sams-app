import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRoute buildRoute({
  required String name,
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
}) {
  return GoRoute(
    name: name,
    path: path,
    pageBuilder: (context, state) =>
        MaterialPage(child: builder(context, state)),
  );
}
