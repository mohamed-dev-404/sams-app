import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

enum ToastType { success, error, warning, info }

class AppToast {
  static final FToast _fToast = FToast();

  static void show(
    BuildContext context,
    String text, {
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 2),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    _fToast.init(context);

    Color color;
    IconData icon;

    switch (type) {
      case ToastType.error:
        color = AppColors.redActive;
        icon = Icons.error_outline;
        break;
      case ToastType.warning:
        color = Colors.orange;
        icon = Icons.warning_amber_rounded;
        break;
      case ToastType.info:
        color = Colors.blueAccent;
        icon = Icons.info_outline;
        break;
      case ToastType.success:
        color = AppColors.greenActive;
        icon = Icons.check_circle_outline;
        break;
    }

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );

    _fToast.removeCustomToast();

    _fToast.showToast(
      child: toast,
      gravity: gravity,
      toastDuration: duration,
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, type: ToastType.success);

  static void error(BuildContext context, String message) =>
      show(context, message, type: ToastType.error);

  static void warning(BuildContext context, String message) =>
      show(context, message, type: ToastType.warning);

  static void info(BuildContext context, String message) =>
      show(context, message, type: ToastType.info);
}
