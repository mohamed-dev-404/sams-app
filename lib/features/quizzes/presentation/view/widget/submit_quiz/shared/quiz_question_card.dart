import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/choice_question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/written_question_model.dart';

import 'choice_question_widget.dart';
import 'written_question_widget.dart';

class QuizQuestionCard extends StatelessWidget {
  final int questionIndex;
  final QuestionModel question;
  final String? selectedAnswerId; // For MCQ/TF
  final String? writtenAnswer; // For Written
  final Function(String) onAnswerSelected;

  const QuizQuestionCard({
    super.key,
    required this.questionIndex,
    required this.question,
    this.selectedAnswerId,
    this.writtenAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text with Index
          Text(
            '$questionIndex-${question.text}',
            style: AppStyles.mobileLabelMediumMd.copyWith(
              color: AppColors.primaryDarkActive,
            ),
          ),
          const SizedBox(height: 24),

          // Factory-like rendering based on Question Type
          _buildQuestionContent(),
        ],
      ),
    );
  }

  Widget _buildQuestionContent() {
    if (question is ChoiceQuestionModel) {
      return ChoiceQuestionWidget(
        question: question as ChoiceQuestionModel,
        selectedOptionId: selectedAnswerId,
        onSelect: onAnswerSelected,
      );
    } else if (question is WrittenQuestionModel) {
      return WrittenQuestionWidget(
        // Assuming you have a basic WrittenQuestionModel
        initialText: writtenAnswer,
        onChanged: onAnswerSelected,
      );
    }
    return const SizedBox.shrink();
  }
}
