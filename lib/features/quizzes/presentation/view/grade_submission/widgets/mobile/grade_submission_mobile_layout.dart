import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/question_card.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/grading_cubit/grading_cubit.dart';

class GradeSubmissionMobileLayout extends StatelessWidget {
  final String submissionId;

  const GradeSubmissionMobileLayout({
    super.key,
    required this.submissionId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradingCubit, GradingState>(
      builder: (context, state) {
        // ── Loading ───────────────────────────────────────────────────────
        if (state is GradingLoading) {
          return const Scaffold(
            body: Center(child: AppAnimatedLoadingIndicator()),
          );
        }

        // ── Data ready (or a question is being saved) ─────────────────────
        if (state is GradingLoaded || state is GradingQuestionSaving) {
          final questions = state is GradingLoaded
              ? state.questions
              : (state as GradingQuestionSaving).questions;

          return Scaffold(
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: questions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return QuestionCard(
                  question: questions[index],
                  index: index,
                  submissionId: submissionId,
                );
              },
            ),
          );
        }

        // ── Failure ───────────────────────────────────────────────────────
        if (state is GradingFailure) {
          //TODO display the error screen
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
        }

        // ── Initial (before first load) ───────────────────────────────────
        return const SizedBox.shrink();
      },
    );
  }
}
