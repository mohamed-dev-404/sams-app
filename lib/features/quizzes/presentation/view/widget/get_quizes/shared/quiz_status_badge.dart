import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
//import 'package:lottie/lottie.dart';

class QuizStatusBadge extends StatelessWidget {
  final QuizState state;
  final String formattedTime;

  const QuizStatusBadge({
    super.key,
    required this.state,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    final (IconData icon, String text, Color color) = switch (state) {
      QuizState.active => (
        Icons.sensors_rounded,
        'Available Now',
        AppColors.secondary,
      ),
      QuizState.upcoming => (
        Icons.calendar_today_rounded,
        'Starts: $formattedTime',
        StatusColors.orange,
      ),
      QuizState.ended => (
        Icons.lock_outline_rounded,
        'Quiz Closed',
        AppColors.whiteDarkActive,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (state == QuizState.active)
            //   Lottie.asset(
            //     'assets/StatusGreen.json',
            //     height: 14,

            //   )
            // else
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              text,
              style: AppStyles.mobileBodyXsmallMd.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
