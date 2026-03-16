import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/quizzes/data/model/quiz_model.dart';

class QuizCardStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;

  const QuizCardStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
  });

  factory QuizCardStyle.fromState(QuizState state) {
    switch (state) {
      case QuizState.active:
        return const QuizCardStyle(
          backgroundColor: AppColors.primaryLight,
          borderColor: AppColors.primaryLightActive,
          titleColor: AppColors.primaryDarkActive,
          descriptionColor: AppColors.primaryDark,
        );
      case QuizState.upcoming:
        return QuizCardStyle(
          backgroundColor: StatusColors.orangeLight,
          borderColor: StatusColors.orange.withValues(alpha: 0.3),
          titleColor: AppColors.primaryDarkActive,
          descriptionColor: AppColors.primaryDark,
        );
      case QuizState.ended:
        return const QuizCardStyle(
          backgroundColor: AppColors.white,
          borderColor: AppColors.whiteHover,
          titleColor: AppColors.whiteDarkActive,
          descriptionColor: AppColors.whiteDark,
        );
    }
  }
}
