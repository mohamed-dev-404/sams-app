import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.whiteLight,
      brightness: Brightness.light,
      //! fontFamily: AppFonts.manrope,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: AppColors.primaryDarkHover,
        displayColor: AppColors.primaryDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.whiteLight,
              disabledBackgroundColor: AppColors.primaryLight,
              disabledForegroundColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              textStyle: AppStyles.mobileButtonMediumSb,
            ).copyWith(
              side: WidgetStateProperty.resolveWith<BorderSide>(
                (states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const BorderSide(
                      color: AppColors.secondaryLightActive,
                      width: 1,
                    );
                  }
                  return const BorderSide(
                    color: AppColors.secondary,
                  );
                },
              ),
            ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: AppColors.whiteDarkHover,
        suffixIconColor: AppColors.primaryDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.secondaryLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.greenLightActive,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.secondary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.red,
          ),
        ),
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.secondaryLightHover;
          } else if (states.contains(WidgetState.error)) {
            return AppColors.redLightHover;
          }
          return AppColors.secondaryLight;
        }),
        filled: true,
        hintStyle: AppStyles.mobileLabelMediumRg.copyWith(
          color: AppColors.whiteDarkHover,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.whiteLight,
        elevation: 6,
        shape: CircleBorder(),
      ),

      //? <-- Add AppBarTheme here
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.whiteLight,
        foregroundColor: AppColors.primaryDarkHover,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: AppColors.primaryDark,
          size: 28,
        ),
        titleTextStyle: AppStyles.mobileTitleLargeMd.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
