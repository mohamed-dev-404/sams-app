import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

/// Reusable grade cell widget used in both table and card views.
/// Handles null scores gracefully with "—" placeholder.
class GradeCell extends StatelessWidget {
  const GradeCell({
    super.key,
    required this.score,
    this.maxScore,
    this.showMax = false,
  });

  /// The student's score. Null means "Not graded yet".
  final num? score;

  /// Maximum possible score for reference.
  final num? maxScore;

  /// Whether to show the max score alongside (e.g. "8/10").
  final bool showMax;

  @override
  Widget build(BuildContext context) {
    if (score == null) {
      return Text(
        '—',
        style: AppStyles.mobileBodySmallRg.copyWith(
          color: StatusColors.grey,
        ),
        textAlign: TextAlign.center,
      );
    }

    final scoreText = showMax && maxScore != null
        ? '${_formatScore(score!)}/${_formatScore(maxScore!)}'
        : _formatScore(score!);

    return Text(
      scoreText,
      style: AppStyles.mobileBodySmallMd.copyWith(
        color: _getScoreColor(),
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Format score: show integer if whole number, otherwise 1 decimal.
  String _formatScore(num value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }

  /// Color-code scores based on percentage of max.
  Color _getScoreColor() {
    if (score == null || maxScore == null || maxScore == 0) {
      return AppColors.primaryDark;
    }
    final percentage = (score! / maxScore!) * 100;
    if (percentage >= 80) return AppColors.secondary;
    if (percentage >= 50) return AppColors.primaryDark;
    return AppColors.red;
  }
}
