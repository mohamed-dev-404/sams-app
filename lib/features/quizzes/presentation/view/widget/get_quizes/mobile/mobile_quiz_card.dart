import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/widget/get_quizes/shared/quiz_card_image.dart';
import 'package:sams_app/features/quizzes/presentation/view/widget/get_quizes/shared/quiz_card_style.dart';
import 'package:sams_app/features/quizzes/presentation/view/widget/get_quizes/shared/quiz_status_badge.dart';
import 'package:sams_app/features/quizzes/presentation/view/widget/get_quizes/shared/quiz_trailing_icon.dart';

class MobileQuizCard extends StatelessWidget {
  final QuizModel quizModel;
  final VoidCallback onTap;

  const MobileQuizCard({
    super.key,
    required this.quizModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = QuizCardStyle.fromState(quizModel.state);

    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: style.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: style.borderColor,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: quizModel.isEnded ? null : onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainContent(style),
              const SizedBox(width: 12),
              QuizTrailingIcon(
                state: quizModel.state,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(
    QuizCardStyle style,
  ) {
    return Expanded(
      child: Row(
        children: [
          QuizCardImage(state: quizModel.state),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  quizModel.title,
                  style: AppStyles.mobileTitleSmallSb.copyWith(
                    color: style.titleColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  quizModel.description ?? 'No description available',
                  style: AppStyles.mobileBodySmallRg.copyWith(
                    color: style.descriptionColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                QuizStatusBadge(
                  state: quizModel.state,
                  formattedTime: quizModel.formattedStartTime,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
