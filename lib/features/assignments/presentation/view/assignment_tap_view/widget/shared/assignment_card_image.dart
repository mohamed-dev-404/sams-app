import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';

class AssignmentCardImage extends StatelessWidget {
  final AssignmentState state;

  const AssignmentCardImage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final (Color bgColor, Color borderColor) = switch (state) {
      AssignmentState.available => (
        AppColors.primaryLightActive.withValues(alpha: 0.4),
        AppColors.primary.withValues(alpha: 0.2),
      ),
      AssignmentState.submitted => (
        StatusColors.green.withValues(alpha: 0.1),
        StatusColors.green.withValues(alpha: 0.2),
      ),
      AssignmentState.missed => (
        AppColors.redLightHover.withValues(alpha: 0.6),
        StatusColors.red.withValues(alpha: 0.2),
      ),
      AssignmentState.onGoing => (
        StatusColors.green.withValues(alpha: 0.1),
        StatusColors.green.withValues(alpha: 0.2),
      ),
      AssignmentState.closed => (
        AppColors.whiteHover.withValues(alpha: 0.5),
        Colors.transparent,
      ),
      AssignmentState.unknown => (
        AppColors.whiteHover.withValues(alpha: 0.5),
        Colors.transparent,
      ),
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
        border: Border.all(color: borderColor),
      ),
      child: SvgPicture.asset(
        AppImages.imagesQuizCard,
        height: 55,
        width: 55,
      ),
    );
  }
}
