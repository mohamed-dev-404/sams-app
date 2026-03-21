import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/quizzes/presentation/view/take_quiz/widgets/shared/quiz_question_card.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/take_quiz_cubit/take_quiz_cubit.dart';

class TakeQuizMobileLayout extends StatefulWidget {
  const TakeQuizMobileLayout({super.key});

  @override
  State<TakeQuizMobileLayout> createState() => _TakeQuizMobileLayoutState();
}

class _TakeQuizMobileLayoutState extends State<TakeQuizMobileLayout> {
  // Tracks the student's currently displayed answer for the ACTIVE question.
  // Lives here in the StatefulWidget — survives timer-driven rebuilds because
  // we only reset it when the question index actually changes (not every second).
  String? _currentAnswer;

  // Tracks the last question index we rendered, so we know when to wipe _currentAnswer.
  int _lastRenderedQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Toast errors are handled once in TakeQuizView's BlocListener.
        // This layout only needs its own BlocBuilders for rendering.
        child: BlocBuilder<TakeQuizCubit, TakeQuizState>(
          builder: (context, state) {
            if (state is TakeQuizLoading) {
              return const Center(child: AppAnimatedLoadingIndicator());
            } else if (state is TakeQuizInProgress) {
              final currentQuestion =
                  state.questions[state.currentQuestionIndex];

              // Reset the displayed answer ONLY when the question actually changes.
              // This is the key fix: we do NOT wipe _currentAnswer on every timer tick.
              if (_lastRenderedQuestionIndex != state.currentQuestionIndex) {
                _lastRenderedQuestionIndex = state.currentQuestionIndex;
                _currentAnswer = null;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    // * HEADER: has its own BlocBuilder that ONLY rebuilds on
                    // * timer ticks (remainingSeconds changes). The question card
                    // * below is NOT re-created when the timer ticks.
                    _QuizTimerHeader(questions: state.questions),
                    const SizedBox(height: 24),

                    // * QUESTION BODY: wrapped in a BlocBuilder that ignores
                    // * timer ticks — only rebuilds on question navigation
                    // * or submission state changes.
                    Expanded(
                      child: BlocBuilder<TakeQuizCubit, TakeQuizState>(
                        buildWhen: (prev, curr) {
                          if (prev is! TakeQuizInProgress ||
                              curr is! TakeQuizInProgress)
                            return true;
                          // Only rebuild if the question index or submit state changes.
                          // Ignore pure timer ticks (remainingSeconds changes alone).
                          return prev.currentQuestionIndex !=
                                  curr.currentQuestionIndex ||
                              prev.isSubmitting != curr.isSubmitting ||
                              prev.submitErrorMessage !=
                                  curr.submitErrorMessage;
                        },
                        builder: (context, innerState) {
                          if (innerState is! TakeQuizInProgress) {
                            return const SizedBox.shrink();
                          }
                          return SingleChildScrollView(
                            child: QuizQuestionCard(
                              questionIndex:
                                  innerState.currentQuestionIndex + 1,
                              question: currentQuestion,
                              selectedAnswerId: _currentAnswer,
                              writtenAnswer: _currentAnswer,
                              onAnswerSelected: (answer) {
                                // setState only to update the local highlight —
                                // no BLoC state emission needed here.
                                setState(() => _currentAnswer = answer);

                                final cubit = context.read<TakeQuizCubit>();
                                if (currentQuestion.questionType ==
                                    ApiValues.written) {
                                  cubit.saveWrittenAnswer(answer);
                                } else {
                                  cubit.saveSelectedOption(answer);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                    _buildNavigationControls(context, state),
                  ],
                ),
              );
            } else if (state is TakeQuizSuccessSubmit) {
              return Center(
                child: Text(
                  'Your Exam Has Been Successfully Submitted',
                  style: AppStyles.mobileTitleMediumSb.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is TakeQuizFetchFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: AppColors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: AppStyles.mobileTitleMediumSb.copyWith(
                          color: AppColors.primaryDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildNavigationControls(
    BuildContext context,
    TakeQuizInProgress state,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: state.isSubmitting
            ? null
            : () {
                if (state.isLastQuestion) {
                  context.read<TakeQuizCubit>().submitQuiz();
                } else {
                  context.read<TakeQuizCubit>().goToNextQuestion();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: state.isSubmitting && state.isLastQuestion
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(state.isLastQuestion ? 'Submit' : 'Next'),
      ),
    );
  }
}

// * ---------------------------------------------------------------------------
// * Separate StatelessWidget for the timer header.
// * It has its OWN BlocBuilder with a targeted buildWhen, so it ONLY
// * rebuilds when remainingSeconds, currentQuestionIndex, or isLast10Seconds
// * change — which is exactly what it displays. The question card above is
// * completely unaffected by this widget's rebuilds.
// * ---------------------------------------------------------------------------
class _QuizTimerHeader extends StatelessWidget {
  // We receive questions from the parent so the widget knows total count.
  final List questions;

  const _QuizTimerHeader({required this.questions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TakeQuizCubit, TakeQuizState>(
      // Only rebuild when timer-related data changes
      buildWhen: (prev, curr) {
        if (prev is! TakeQuizInProgress || curr is! TakeQuizInProgress) {
          return true;
        }
        return prev.remainingSeconds != curr.remainingSeconds ||
            prev.currentQuestionIndex != curr.currentQuestionIndex;
      },
      builder: (context, state) {
        if (state is! TakeQuizInProgress) return const SizedBox.shrink();

        final currentQuestionNum = state.currentQuestionIndex + 1;
        final totalQuestions = state.questions.length;
        final progress = state.timeProgress;

        final minutes = (state.remainingSeconds ~/ 60).toString().padLeft(
          2,
          '0',
        );
        final seconds = (state.remainingSeconds % 60).toString().padLeft(
          2,
          '0',
        );

        final timerColor = state.isLast10Seconds
            ? AppColors.red
            : AppColors.green;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 28),
                Text(
                  'Database Quiz',
                  style: AppStyles.mobileTitleMediumSb.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 28),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentQuestionNum.toString().padLeft(2, '0')} of ${totalQuestions.toString().padLeft(2, '0')}',
                  style: AppStyles.mobileBodyMediumRg.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: timerColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$minutes:$seconds',
                        style: AppStyles.mobileBodySmallSb.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: StatusColors.greyLight,
                valueColor: AlwaysStoppedAnimation<Color>(timerColor),
                minHeight: 8,
              ),
            ),
          ],
        );
      },
    );
  }
}
