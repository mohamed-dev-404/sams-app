import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';

class AssignmentStatusBadge extends StatelessWidget {
  final AssignmentState state;
  final String formattedDueDate;

  const AssignmentStatusBadge({
    super.key,
    required this.state,
    required this.formattedDueDate,
  });

  @override
  Widget build(BuildContext context) {
    final (IconData icon, String text, Color color) = switch (state) {
      AssignmentState.available => (
        Icons.assignment_rounded,
        'Due: $formattedDueDate',
        AppColors.primary,
      ),
      AssignmentState.submitted => (
        Icons.check_circle_rounded,
        'Submitted',
        StatusColors.green,
      ),
      AssignmentState.missed => (
        Icons.cancel_rounded,
        'Missed',
        StatusColors.red,
      ),
      AssignmentState.onGoing => (
        Icons.podcasts_rounded,
        'Ongoing',
        StatusColors.green,
      ),
      AssignmentState.closed => (
        Icons.lock_rounded,
        'Closed',
        AppColors.whiteDarkActive,
      ),
      AssignmentState.unknown => (
        Icons.help_outline_rounded,
        'Unknown',
        AppColors.whiteDark,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
