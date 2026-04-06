import 'package:flutter/material.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/question_card.dart';

class GradeSubmissionMobileLayout extends StatelessWidget {
  const GradeSubmissionMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: mockSubmissionDetails.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final question = mockSubmissionDetails[index];
          return QuestionCard(
            question: question,
            index: index,
          );
        },
      ),
    );
  }
}
