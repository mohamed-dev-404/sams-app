import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';

class AssignmentCardStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;

  const AssignmentCardStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
  });

  factory AssignmentCardStyle.fromState(AssignmentState state) {
    return switch (state) {
      AssignmentState.available => const AssignmentCardStyle(
        backgroundColor: AppColors.primaryLight,
        borderColor: AppColors.primaryLightActive,
        titleColor: AppColors.primaryDarkActive,
        descriptionColor: AppColors.primaryDark,
      ),
      AssignmentState.submitted => AssignmentCardStyle(
        backgroundColor: StatusColors.green.withValues(alpha: 0.08),
        borderColor: StatusColors.green.withValues(alpha: 0.3),
        titleColor: StatusColors.greenDark,
        descriptionColor: StatusColors.greenDark.withValues(alpha: 0.8),
      ),
      AssignmentState.missed => AssignmentCardStyle(
        backgroundColor: AppColors.redLightHover.withValues(alpha: 0.5),
        borderColor: StatusColors.red.withValues(alpha: 0.2),
        titleColor: StatusColors.redDark,
        descriptionColor: AppColors.primaryDark,
      ),
      AssignmentState.onGoing => AssignmentCardStyle(
        backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
        borderColor: StatusColors.green.withValues(alpha: 0.3),
        titleColor: StatusColors.greenDark,
        descriptionColor: StatusColors.greenDark.withValues(alpha: 0.8),
      ),
      AssignmentState.closed => const AssignmentCardStyle(
        backgroundColor: AppColors.white,
        borderColor: AppColors.whiteHover,
        titleColor: AppColors.whiteDarkActive,
        descriptionColor: AppColors.whiteDark,
      ),
      AssignmentState.unknown => const AssignmentCardStyle(
        backgroundColor: AppColors.white,
        borderColor: AppColors.whiteHover,
        titleColor: AppColors.whiteDarkActive,
        descriptionColor: AppColors.whiteDark,
      ),
    };
  }
}
