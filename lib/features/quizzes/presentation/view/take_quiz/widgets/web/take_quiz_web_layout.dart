// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/presentation/view/take_quiz/widgets/shared/quiz_question_card.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/take_quiz_cubit/take_quiz_cubit.dart';

class TakeQuizWebLayout extends StatefulWidget {
  const TakeQuizWebLayout({super.key});

  @override
  State<TakeQuizWebLayout> createState() => _TakeQuizWebLayoutState();
}

class _TakeQuizWebLayoutState extends State<TakeQuizWebLayout> {
  html.EventListener? _beforeUnloadListener;

  // Tracks the student's currently displayed answer for the ACTIVE question.
  // Lives here in the StatefulWidget — survives timer-driven rebuilds because
  // we only reset it when the question index actually changes (not every second).
  String? _currentAnswer;

  // Tracks the last question index we rendered, so we know when to wipe _currentAnswer.
  int _lastRenderedQuestionIndex = 0;

  @override
  void initState() {
    super.initState();

    // Quiz questions are already fetched from the router via fetchQuestionsAndStart

    // Prevent Default Warning (web only)
    _beforeUnloadListener = (html.Event event) {
      final beforeUnloadEvent = event as html.BeforeUnloadEvent;
      beforeUnloadEvent.returnValue =
          'Are you sure you want to leave? Your quiz progress will be lost.';
    };
    html.window.addEventListener('beforeunload', _beforeUnloadListener!);
  }

  @override
  void dispose() {
    if (_beforeUnloadListener != null) {
      html.window.removeEventListener('beforeunload', _beforeUnloadListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        // Toast errors are handled once in TakeQuizView's BlocListener.
        // This layout only needs its own BlocBuilders for rendering.
        child: BlocBuilder<TakeQuizCubit, TakeQuizState>(
            builder: (context, state) {
              if (state is TakeQuizLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TakeQuizInProgress) {
                final currentQuestion =
                    state.questions[state.currentQuestionIndex];

                // Reset the displayed answer ONLY when the question actually changes.
                if (_lastRenderedQuestionIndex != state.currentQuestionIndex) {
                  _lastRenderedQuestionIndex = state.currentQuestionIndex;
                  _currentAnswer = null;
                }

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // * HEADER: has its own BlocBuilder that ONLY rebuilds
                          // * on timer ticks. Completely isolated from the question card.
                          _QuizTimerHeader(questions: state.questions),
                          const SizedBox(height: 32),

                          // * QUESTION BODY: only rebuilds on question navigation
                          // * or submission state changes, NOT on timer ticks.
                          Expanded(
                            child: BlocBuilder<TakeQuizCubit, TakeQuizState>(
                              buildWhen: (prev, curr) {
                                if (prev is! TakeQuizInProgress ||
                                    curr is! TakeQuizInProgress)
                                  return true;
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
                                      setState(() => _currentAnswer = answer);

                                      final cubit = context
                                          .read<TakeQuizCubit>();
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

                          const SizedBox(height: 24),
                          _buildNavigationControls(context, state),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is TakeQuizSuccessSubmit) {
                return Center(
                  child: Text(
                    'Your Exam Has Been Successfully Submitted',
                    style: AppStyles.mobileTitleMediumSb.copyWith(
                      color: AppColors.primary,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (state is TakeQuizFetchFailure) {
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 80,
                            color: AppColors.red,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            state.message,
                            style: AppStyles.mobileTitleMediumSb.copyWith(
                              color: AppColors.primaryDark,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 20,
                              ),
                            ),
                            child: const Text(
                              'Go Back',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
        ),
        child: state.isSubmitting && state.isLastQuestion
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                state.isLastQuestion ? 'Submit' : 'Next',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

// * ---------------------------------------------------------------------------
// * Separate widget for the timer header — only rebuilds on timer ticks.
// * The question card is completely unaffected by this widget's rebuilds.
// * ---------------------------------------------------------------------------
class _QuizTimerHeader extends StatelessWidget {
  final List questions;

  const _QuizTimerHeader({required this.questions});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TakeQuizCubit, TakeQuizState>(
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
                const SizedBox(width: 32),
                Text(
                  'Database Quiz',
                  style: AppStyles.mobileTitleMediumSb.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentQuestionNum.toString().padLeft(2, '0')} of ${totalQuestions.toString().padLeft(2, '0')}',
                  style: AppStyles.mobileBodyMediumRg.copyWith(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: timerColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: AppColors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$minutes:$seconds',
                        style: AppStyles.mobileBodySmallSb.copyWith(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: StatusColors.greyLight,
                valueColor: AlwaysStoppedAnimation<Color>(timerColor),
                minHeight: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}
