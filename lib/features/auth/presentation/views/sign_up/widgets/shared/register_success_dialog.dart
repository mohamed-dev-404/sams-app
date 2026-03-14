import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';

//* helper function to show register success dialog
void showRegisterSuccessDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String buttonLabel,
  required VoidCallback onButtonPressed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return _RegisterSuccessDialog(
        title: title,
        message: message,
        buttonLabel: buttonLabel,
        onButtonPressed: onButtonPressed,
      );
    },
  );
}

class _RegisterSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onButtonPressed;

  const _RegisterSuccessDialog({
    required this.title,
    required this.message,
    required this.onButtonPressed,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppImages.imagesSuccessDialog,
                height: 120,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: AppStyles.mobileBodyLargeSb.copyWith(
                  color: AppColors.primaryDarkHover,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomAppButton(
                  label: buttonLabel,
                  onPressed: onButtonPressed,
                  textColor: AppColors.whiteLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
