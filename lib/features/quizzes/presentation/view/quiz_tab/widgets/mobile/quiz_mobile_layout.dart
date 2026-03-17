import 'package:flutter/material.dart';
import 'package:sams_app/core/helper/app_toast.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/component/widget/get_quizes/mobile/mobile_quiz_card.dart';

class QuizMobileLayout extends StatelessWidget {
  const QuizMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //! Title Section
          Text(
            'Quizzes',
            style: AppStyles.mobileTitleSmallSb.copyWith(fontSize: 24),
          ),

          const SizedBox(height: 24),

          //! all quizes Section
          Column(
            children: mockQuizzes
                .map(
                  (quiz) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: MobileQuizCard(
                      quizModel: quiz,
                      onTap: () {
                        if (quiz.state == QuizState.active) {
                          //TODO Navigate to Quiz Screen
                        } else if (quiz.state == QuizState.upcoming) {
                          AppToast.warning(
                            context,
                            'This quiz starts on ${quiz.formattedStartTime}',
                          );
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
