import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/helper/app_toast.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_tab/widgets/mobile/mobile_quiz_card.dart';

class QuizMobileLayout extends StatelessWidget {
  const QuizMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isInstructor = CurrentRole.role == UserRole.instructor;
    final courseId = GoRouterState.of(context).pathParameters['courseId'] ?? '';

    return ListView(
      // Padding around the entire scrollable area
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        // 1. Title Section
        Text(
          'Quizzes',
          style: AppStyles.mobileTitleSmallSb.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 24),

        // 2. Instructor Create Action
        if (isInstructor) ...[
          AddNewCard(
            title: 'Create Quiz',
            isMobile: true,
            onTap: () {
              context.pushNamed(
                RoutesName.createQuiz,
                pathParameters: {'courseId': courseId},
              );
            },
          ),
          const SizedBox(height: 16),
        ],

        // 3. Quiz List Section (Using a loop instead of nested ListView)
        // This ensures the entire page scrolls as one unit
        ...mockQuizzes.map((quiz) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MobileQuizCard(
              quizModel: quiz,
              onTap: () => _handleQuizNavigation(context, quiz, courseId),
            ),
          );
        }),
      ],
    );
  }

  /// Logic to handle navigation based on user role and quiz state
  void _handleQuizNavigation(
    BuildContext context,
    QuizModel quiz,
    String courseId,
  ) {
    bool canEnter =
        quiz.state != QuizState.closed ||
        CurrentRole.role == UserRole.instructor;

    if (canEnter) {
      context.pushNamed(
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
