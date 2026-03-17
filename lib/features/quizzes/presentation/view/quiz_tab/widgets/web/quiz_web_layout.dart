import 'package:flutter/material.dart';
import 'package:sams_app/core/helper/app_toast.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_tab/widgets/web/web_quiz_card.dart';

//! Materials_web_layout.dart
class QuizsWebLayout extends StatelessWidget {
  const QuizsWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Title Section
          Text(
            'Quizzes',
            style: AppStyles.mobileTitleSmallSb.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),

          //! Grid Section
          GridView.builder(
            shrinkWrap: true, // Crucial inside SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockQuizzes.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300, // Max width of one card
              mainAxisSpacing: 24, // Vertical spacing
              crossAxisSpacing: 24, // Horizontal spacing
              childAspectRatio: 400 / 440, // Your specific aspect ratio
            ),
            itemBuilder: (context, index) {
              final quiz = mockQuizzes[index];
              return WebQuizCard(
                quizModel: quiz,
                onTap: () {
                  if (quiz.state == QuizState.available) {
                    // TODO: Navigate to Quiz Screen
                  } else if (quiz.state == QuizState.upcoming) {
                    AppToast.warning(
                      context,
                      'This quiz starts on ${quiz.formattedStartTime}',
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
