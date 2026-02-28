import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class AppButtonWidget extends StatelessWidget {
  AppButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.borderColor,
  });
  VoidCallback onPressed;
  Color? textColor;
  Color? backgroundColor;
  Color? borderColor;
  String label;
  double? fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero, // 👈 الحل لمشكلة المسافات الداخلية
        minimumSize: Size.zero,   // 👈 يمنع الزر من فرض حجم أدنى
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 👈 لتقليص مساحة اللمس الزائدة
        side: BorderSide(
          width: 1, // خليها أوضح
          color: borderColor ?? AppColors.secondaryLightActive,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 12),
        ),
        elevation: 4,
        backgroundColor: backgroundColor ?? AppColors.secondaryHover,
      ),
      child: Text(
        label,
        style: AppStyles.mobileButtonMediumSb.copyWith(
          color: textColor ?? AppColors.primaryLight,
          fontSize: fontSize ?? 22.sp,
        ),
      ),
    );
  }
}
