import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';

class AssignmentTrailingIcon extends StatelessWidget {
  final AssignmentState state;

  const AssignmentTrailingIcon({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.bounceIn,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) => ScaleTransition(
          scale: anim,
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: _buildIcon(),
      ),
    );
  }

  Widget _buildIcon() {
    return switch (state) {
      //! Student States
      AssignmentState.available => Container(
        key: const ValueKey('available'),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.whiteLight,
              AppColors.primaryLightActive.withValues(alpha: 0.5),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryActive.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.primaryActive,
            size: 14,
          ),
        ),
      ),

      AssignmentState.submitted => Container(
        key: const ValueKey('submitted'),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: StatusColors.green.withValues(alpha: 0.1),
          border: Border.all(color: StatusColors.green, width: 1),
        ),
        child: const Center(
          child: Icon(
            Icons.check_circle_rounded,
            color: StatusColors.green,
            size: 16,
          ),
        ),
      ),

      AssignmentState.missed => Container(
        key: const ValueKey('missed'),
        decoration: const BoxDecoration(
          color: AppColors.redLightHover,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.cancel_rounded,
            color: StatusColors.red,
            size: 16,
          ),
        ),
      ),

      //! Instructor States
      AssignmentState.onGoing => Container(
        key: const ValueKey('ongoing'),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary.withValues(alpha: 0.1),
          border: Border.all(color: AppColors.secondary, width: 1),
        ),
        child: const Center(
          child: Icon(
            Icons.podcasts_rounded,
            color: AppColors.secondary,
            size: 16,
          ),
        ),
      ),

      AssignmentState.closed => Container(
        key: const ValueKey('closed'),
        decoration: BoxDecoration(
          color: AppColors.whiteHover.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.lock_rounded,
            color: AppColors.whiteDark.withValues(alpha: 0.8),
            size: 16,
          ),
        ),
      ),

      AssignmentState.unknown => Container(
        key: const ValueKey('unknown'),
        decoration: const BoxDecoration(
          color: AppColors.whiteHover,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.help_outline_rounded,
            color: AppColors.whiteDark,
            size: 16,
          ),
        ),
      ),
    };
  }
}
