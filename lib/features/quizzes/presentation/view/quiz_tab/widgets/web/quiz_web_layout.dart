import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/helper/app_toast.dart';
import 'package:sams_app/core/utils/assets/app_lottie.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_tab/widgets/web/web_quiz_card.dart';

class QuizsWebLayout extends StatelessWidget {
  final String courseId;
  final List<QuizModel> quizzes;
  final UserRole userRole;

  const QuizsWebLayout({
    super.key,
    required this.courseId,
    required this.quizzes,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInstructor = userRole == UserRole.instructor;

    // In Web, if it's an instructor, we add 1 to the count for the "Add New Quiz" card
    final int itemCount = isInstructor ? quizzes.length + 1 : quizzes.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(
            'Quizzes',
            style: AppStyles.mobileTitleSmallSb.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),

          // Handling Empty State for Students
          if (quizzes.isEmpty && !isInstructor)
            Center(
              child: Column(
                children: [
                  Lottie.asset(AppLottie.empty, height: 300),
                  const SizedBox(height: 16),
                  const Text('No quizzes available yet.'),
                ],
              ),
            )
          else
            // Unified Grid for Quizzes and Instructor Add Card
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 400 / 440,
              ),
              itemBuilder: (context, index) {
                // 1. If Instructor, the first item (index 0) is always the AddNewCard
                if (isInstructor && index == 0) {
                  return AddNewCard(
                    title: 'Create Quiz',
                    hight: double.infinity,
                    onTap: () => _navigateToCreateQuiz(context),
                  );
                }

                // 2. Adjust data index if instructor (because index 0 was the Add card)
                final int dataIndex = isInstructor ? index - 1 : index;
                final quiz = quizzes[dataIndex];

                return WebQuizCard(
                  quizModel: quiz,
                  onTap: () => _handleQuizNavigation(context, quiz),
                );
              },
            ),
        ],
      ),
    );
  }

  /// Navigation logic to create quiz screen
  void _navigateToCreateQuiz(BuildContext context) {
    context.pushNamed(
      RoutesName.createQuiz,
      pathParameters: {'courseId': courseId},
    );
  }

  /// Centralized navigation logic with role-based permissions
  void _handleQuizNavigation(BuildContext context, QuizModel quiz) {
    final bool isInstructor = userRole == UserRole.instructor;

    if (quiz.state != QuizState.closed || isInstructor) {
      context.goNamed(
        RoutesName.quizDetails,
        pathParameters: {
          'courseId': courseId,
          'quizId': quiz.id.toString(),
        },
      );
    } else if (quiz.state == QuizState.upcoming) {
      AppToast.warning(
        context,
        'This quiz starts on ${quiz.formattedStartTime}',
      );
    }
  }
}
