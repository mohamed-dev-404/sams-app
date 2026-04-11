import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

/// Dialog helper for confirming the deletion of a quiz question.
///
/// Prompts the user with a destructive warning. Triggers [onConfirm] if the
/// user proceeds. The UI state and server logic should be handled within [onConfirm].
class DeleteQuestionDialog {
  /// Displays the confirmation dialog.
  static void show(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Delete Question?',
          style: AppStyles.mobileTitleXsmallMd.copyWith(
            color: AppColors.redDark,
          ),
        ),
        content: Text(
          'This will permanently remove the question from the quiz. This action cannot be undone.',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.whiteDarker,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppStyles.mobileBodySmallMd.copyWith(
                color: AppColors.whiteDarkActive,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              'Delete',
              style: AppStyles.mobileBodySmallMd.copyWith(
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
