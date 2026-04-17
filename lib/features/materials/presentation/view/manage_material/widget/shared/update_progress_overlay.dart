import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sams_app/core/utils/assets/app_lottie.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

/// A full-screen blocking overlay used to communicate progress during background operations.
/// It dynamically changes its visual feedback (Lottie animation) based on the [message] provided.
class UpdateProgressOverlay extends StatelessWidget {
  final String message;

  const UpdateProgressOverlay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String lottieAsset;

    //* Logic: Match the Lottie animation to the current CRUD operation.
    //? We use string matching on the message to avoid passing extra enum flags.
    if (message.contains('Deleting')) {
      lottieAsset = AppLottie.delete;
    } else if (message.contains('Uploading')) {
      lottieAsset = AppLottie.uploadFiles;
    } else {
      //! Fallback animation for general 'Editing' or 'Saving' states.
      lottieAsset = AppLottie.edit;
    }

    return Container(
      //* Backdrop: High-opacity dark overlay to focus user attention and block interactions.
      color: AppColors.primaryDarker.withAlpha(230),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              lottieAsset,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppStyles.mobileBodyLargeSb.copyWith(
                color: AppColors.whiteLight,
              ),
            ),
            const SizedBox(height: 10),
            //* Critical Warning: Advising the user against interrupting the process.
            const Text(
              'Please stay on this screen until completion.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.whiteDark,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
