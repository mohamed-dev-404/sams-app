import 'package:flutter/material.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/shared/common/quiz_details_header.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/shared/common/stats_row.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/shared/common/quiz_details_schedule_card.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/shared/student/instructions_section.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/shared/student/quiz_deadline_timer.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/shared/student/student_action_card.dart';

class QuizDetailsMobileStudentLayout extends StatelessWidget {
  final QuizModel quiz;

  const QuizDetailsMobileStudentLayout({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            QuizDetailsHeader(quiz: quiz),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (quiz.state == QuizState.available) ...[
                    QuizDeadlineTimer(endTime: quiz.endTime),
                    const SizedBox(height: 24),
                  ],

                  if (quiz.state == QuizState.upcoming) ...[
                    QuizDetailsScheduleCard(quiz: quiz),
                    const SizedBox(height: 24),
                  ],

                  StatsRow(quiz: quiz),
                  const SizedBox(height: 24),

                  StudentActionCard(
                    onPressed: () {
                      // TODO: nav to quiz
                    },
                    quiz: quiz,
                  ),

                  const SizedBox(height: 24),

                  if (quiz.state != QuizState.closed) ...[
                    const InstructionsSection(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
