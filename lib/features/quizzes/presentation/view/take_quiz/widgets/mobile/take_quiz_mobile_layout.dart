import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/presentation/view/take_quiz/widgets/shared/quiz_question_card.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/take_quiz_cubit/take_quiz_cubit.dart';

class TakeQuizMobileLayout extends StatefulWidget {
  const TakeQuizMobileLayout({super.key});

  @override
  State<TakeQuizMobileLayout> createState() => _TakeQuizMobileLayoutState();
}

class _TakeQuizMobileLayoutState extends State<TakeQuizMobileLayout> {
  @override
  void initState() {
    super.initState();
    // Start quiz with mock questions when layout initializes
    context.read<TakeQuizCubit>().startQuiz(mockQuestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TakeQuizCubit, TakeQuizState>(
          builder: (context, state) {
            if (state is TakeQuizInitial || state is TakeQuizLoading) {
              // TODO: replace this with a loading screen
              return const Center(child: CircularProgressIndicator());
            } 
            else if (state is TakeQuizInProgress) {
              final currentQuestion =
                  state.questions[state.currentQuestionIndex];
              final savedAnswer = state.selectedAnswers[currentQuestion.id];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    _buildHeader(context, state),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: QuizQuestionCard(
                          questionIndex: state.currentQuestionIndex + 1,
                          question: currentQuestion,
                          selectedAnswerId: savedAnswer,
                          writtenAnswer: savedAnswer,
                          onAnswerSelected: (answer) {
                            context.read<TakeQuizCubit>().saveAnswer(
                              currentQuestion.id,
                              answer,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildNavigationControls(context, state),
                  ],
                ),
              );
            } 
            else if (state is TakeQuizSuccess) {
              // TODO: replace this with a Submit Success screen
              return Center(
                child: Text(
                  'Your Exam Has Been Successfully Submitted',
                  style: AppStyles.mobileTitleMediumSb.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TakeQuizInProgress state) {
    final currentQuestionNum = state.currentQuestionIndex + 1;
    final totalQuestions = state.questions.length;
    final progress = state.timeProgress;

    final minutes = (state.remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (state.remainingSeconds % 60).toString().padLeft(2, '0');

    final timerColor = state.isLast10Seconds ? AppColors.red : AppColors.green;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            Text(
              'Database Quiz',
              style: AppStyles.mobileTitleMediumSb.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 28), // balance the back button
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 1000,
            ), // Smooth progress transition
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: StatusColors.greyLight,
              valueColor: AlwaysStoppedAnimation<Color>(timerColor),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationControls(
    BuildContext context,
    TakeQuizInProgress state,
  ) {
    final isLastQuestion =
        state.currentQuestionIndex == state.questions.length - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous Button or Empty Space
        state.currentQuestionIndex > 0
            ? ElevatedButton(
                onPressed: () =>
                    context.read<TakeQuizCubit>().goToPreviousQuestion(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Previous'),
              )
            : const SizedBox.shrink(),

        // Next or Submit Button
        ElevatedButton(
          onPressed: () {
            if (isLastQuestion) {
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
          child: Text(isLastQuestion ? 'Submit' : 'Next'),
        ),
      ],
    );
  }
}
