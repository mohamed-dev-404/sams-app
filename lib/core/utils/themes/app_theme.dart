import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class AppTheme {
  AppTheme._();
  static final _borderRadius = BorderRadius.circular(15.r);
  static ThemeData getAppTheme() {
    return ThemeData(
      useMaterial3: true, 
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.whiteLight,
      colorSchemeSeed: AppColors.primary,

      textTheme: _buildTextTheme(),
      appBarTheme: _buildAppBarTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      floatingActionButtonTheme: _buildFABTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: AppStyles.mobileTitleLargeMd.copyWith(
        color: AppColors.primaryDark,
      ),
      bodyMedium: AppStyles.mobileLabelMediumRg.copyWith(
        color: AppColors.primaryDarkHover,
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme() {
    return AppBarTheme(
      backgroundColor: AppColors.whiteLight,
      foregroundColor: AppColors.primaryDarkHover,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryDark, size: 28.w),
      titleTextStyle: AppStyles.mobileTitleLargeMd.copyWith(
        color: AppColors.primaryDark,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.whiteLight,
            disabledBackgroundColor: AppColors.primaryLight,
            shape: RoundedRectangleBorder(borderRadius: _borderRadius),
            textStyle: AppStyles.mobileButtonMediumSb,
          ).copyWith(
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: states.contains(WidgetState.disabled)
                    ? AppColors.secondaryLightActive
                    : AppColors.secondary,
              ),
            ),
          ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      prefixIconColor: AppColors.whiteDarkHover,
      suffixIconColor: AppColors.primaryDark,
      errorStyle: AppStyles.mobileLabelMediumRg.copyWith(
        color: AppColors.red,
      ),
      errorMaxLines: 7,
      hintStyle: AppStyles.mobileLabelMediumRg.copyWith(
        color: AppColors.whiteDarkHover,
      ),
      border: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(color: AppColors.secondaryLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(color: AppColors.greenLightActive),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: const BorderSide(color: AppColors.secondary),
      ),
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.secondaryLightHover;
        }
        if (states.contains(WidgetState.error)) return AppColors.redLightHover;
        return AppColors.secondaryLight;
      }),
    );
  }

  static FloatingActionButtonThemeData _buildFABTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.whiteLight,
      elevation: 6,
      shape: CircleBorder(),
    );
  }
}
