import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/app_error_dialog.dart';
import 'package:sams_app/core/widgets/app_success_dialog.dart';

class AppDialog {
  AppDialog._();

  //* Show Success Dialog
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppSuccessDialog(
        title: title,
        message: message,
        onTapped: onTap,
      ),
    );
  }

  //* Show Failure Dialog
  static Future<void> showFailure(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onTap,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppFailureDialog(
        title: title,
        message: message,
        onTapped: onTap,
      ),
    );
  }
}
