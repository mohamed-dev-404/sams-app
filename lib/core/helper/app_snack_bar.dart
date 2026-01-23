import 'package:flutter/material.dart';

/// Available SnackBar message types.
/// Each type controls the color and icon.
enum SnackBarType { success, error, warning, info }

/// AppSnackBar
///
/// Utility class for showing styled SnackBars consistently
/// across the application.
class AppSnackBar {
  /// Shows a SnackBar with a given message and type.
  ///
  /// - [context]: Required BuildContext
  /// - [text]: Message to display
  /// - [type]: Visual style (default: success)
  /// - [duration]: Display duration
  static Future<void> show(
    BuildContext context,
    String text, {
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 2),
  }) {
    Color color;
    IconData icon;

    // Resolve style based on SnackBar type
    switch (type) {
      case SnackBarType.error:
        color = Colors.redAccent;
        icon = Icons.error_outline;
        break;
      case SnackBarType.warning:
        color = Colors.orange;
        icon = Icons.warning_amber_rounded;
        break;
      case SnackBarType.info:
        color = Colors.blueAccent;
        icon = Icons.info_outline;
        break;
      case SnackBarType.success:
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
    }

    // Remove any currently visible SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Show the SnackBar
    return ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: duration,
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .closed;
  }

  /// Shows a success SnackBar
  static Future<void> success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      show(context, message, type: SnackBarType.success, duration: duration);

  /// Shows an error SnackBar
  static Future<void> error(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      show(context, message, type: SnackBarType.error, duration: duration);

  /// Shows a warning SnackBar
  static Future<void> warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      show(context, message, type: SnackBarType.warning, duration: duration);

  /// Shows an info SnackBar
  static Future<void> info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      show(context, message, type: SnackBarType.info, duration: duration);
}

/*
Usage:

AppSnackBar.success(context, "your Success message");
AppSnackBar.error(context, "your Error message");
AppSnackBar.warning(context, "your Warning message");
AppSnackBar.info(context, "your Info message");

Or
AppSnackBar.show(context, "Custom message", type: SnackBarType.info);
*/
