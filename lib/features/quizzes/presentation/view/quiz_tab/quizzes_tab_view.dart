import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_tab/widgets/mobile/quiz_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_tab/widgets/web/quiz_web_layout.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';

class QuizzesTabView extends StatelessWidget {
  final String courseId;
  const QuizzesTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    // TODO: Wrap with BlocBuilder<QuizCubit, QuizState> when ready
    // This is where you handle Loading, Success, and Error states.
    // Example:
    // return BlocBuilder<QuizCubit, QuizState>(
    //   builder: (context, state) {
    //     if (state is QuizLoading) return const Center(child: CircularProgressIndicator());
    //     if (state is QuizError) return Center(child: Text(state.message));
    //     if (state is QuizSuccess) {
    //        final quizzes = state.quizzes;

    // Temporary mock data for UI building
    final quizzes = mockQuizzes;
    final role = CurrentRole.role;

    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (BuildContext context) {
          return QuizMobileLayout(
            courseId: courseId,
            quizzes: quizzes,
            userRole: role,
          );
        },
        webLayout: (BuildContext context) {
          return QuizsWebLayout(
            courseId: courseId,
            quizzes: quizzes,
            userRole: role,
          );
        },
      ),
    );
    //     }
    //     return const SizedBox(); // Fallback empty state
    //   },
    // );
  }
}
