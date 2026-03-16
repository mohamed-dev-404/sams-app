import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/quizzes/data/model/quiz_model.dart';

class QuizCardImage extends StatelessWidget {
  final QuizState state;

  const QuizCardImage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = state == QuizState.active;
    final bool isUpcoming = state == QuizState.upcoming;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isActive
            ? AppColors.primaryLightActive.withValues(alpha: 0.4)
            : isUpcoming
            ? StatusColors.orangeTransparent
            : AppColors.whiteHover.withValues(alpha: 0.5),
        border: Border.all(
          color: isActive
              ? AppColors.primaryActive.withValues(alpha: 0.1)
              : isUpcoming
              ? StatusColors.orange.withValues(alpha: 0.2)
              : Colors.transparent,
        ),
      ),
      child: SvgPicture.asset(
        AppImages.imagesQuizCard,
        height: 55,
        width: 55,
      ),
    );
  }
}
