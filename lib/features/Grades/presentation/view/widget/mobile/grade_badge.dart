import 'package:flutter/widgets.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart' show StatusColors;
import 'package:sams_app/core/utils/styles/app_styles.dart';

/// Compact grade badge used in mobile cards.
/// Shows score with colored background based on performance.
class GradeBadge extends StatelessWidget {
  const GradeBadge({
    super.key,
    required this.score,
    required this.maxScore,
  });

  final num? score;
  final num maxScore;

  @override
  Widget build(BuildContext context) {
    final isGraded = score != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isGraded ? _getBackgroundColor() : StatusColors.greyTransparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isGraded
            ? '${_formatScore(score!)}/${_formatScore(maxScore)}'
            : 'Not graded',
        style: AppStyles.mobileBodyXsmallMd.copyWith(
          color: isGraded ? _getTextColor() : StatusColors.grey,
        ),
      ),
    );
  }

  String _formatScore(num value) {
    if (value == value.toInt()) return value.toInt().toString();
    return value.toStringAsFixed(1);
  }

  Color _getBackgroundColor() {
    if (score == null || maxScore == 0) return StatusColors.greyTransparent;
    final pct = (score! / maxScore) * 100;
    if (pct >= 80) return StatusColors.greenTransparent;
    if (pct >= 50) return StatusColors.blueTransparent;
    return StatusColors.redTransparent;
  }

  Color _getTextColor() {
    if (score == null || maxScore == 0) return StatusColors.grey;
    final pct = (score! / maxScore) * 100;
    if (pct >= 80) return StatusColors.greenDark;
    if (pct >= 50) return StatusColors.blueDark;
    return StatusColors.redDark;
  }
}
