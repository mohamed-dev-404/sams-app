import 'package:flutter/material.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/app_button.dart';

class CreateCourseButton extends StatelessWidget {
  const CreateCourseButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : AppButton(
              model: AppButtonStyleModel(
                height: 55,
                width: 230,
                backgroundColor: AppColors.secondary,
                textColor: AppColors.whiteLight,
                label: 'Create Course',
                onPressed: isLoading ? () {} : onPressed,
              ),
            ),
    );
  }
}
