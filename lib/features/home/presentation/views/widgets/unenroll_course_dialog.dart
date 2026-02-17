import 'package:flutter/material.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_button.dart';

class UnenrollCourseDialog extends StatelessWidget {
  const UnenrollCourseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      actionsPadding: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Center(
        child: Text(
          'Unenrol from Database?',
        ),
      ),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Text(
        '''You will be removed from this class.

All your files will remain in Google Drive.
''',
        style: AppStyles.mobileBodyMediumRg.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              model: AppButtonStyleModel(
                height: 55,
                width: 150,
                textColor: AppColors.primaryDark,
                backgroundColor: AppColors.secondaryLight,
                label: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            AppButton(
              model: AppButtonStyleModel(
                height: 55,
                width: 150,
                textColor: AppColors.primaryDark,
                backgroundColor: AppColors.secondaryLight,
                label: 'Unenroll',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
