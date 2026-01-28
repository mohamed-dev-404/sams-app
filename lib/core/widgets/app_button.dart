//todo shared button widget used in the app
import 'package:flutter/material.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.model});
  final AppButtonStyleModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: model.width ?? 50,
      height: model.height ?? 135,
      child: ElevatedButton(
        onPressed: model.onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(14),
          ),
          elevation: 4,
          backgroundColor: model.backgroundColor ?? AppColors.secondaryHover,
        ),
        child: Text(
          model.label,
          style: AppStyles.mobileButtonMediumSb.copyWith(
            color: model.textColor ?? AppColors.primaryLight,
          ),
        ),
      ),
    );
  }
}
