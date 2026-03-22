import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/mobile/instructor/quiz_details_mobile_instructor_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/mobile/student/quiz_details_mobile_student_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/web/instructor/quiz_details_web_instructor_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/web/student/quiz_details_web_student_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/quiz_details_cubit/quiz_details_cubit.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/quiz_details_cubit/quiz_details_state.dart';

class QuizDetailsView extends StatelessWidget {
  final String quizId;
  const QuizDetailsView({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    context.read<QuizDetailsCubit>().getQuizDetails(quizId);

    return BlocBuilder<QuizDetailsCubit, QuizDetailsState>(
      builder: (context, state) {
        if (state is QuizDetailsLoading) {
          return const Scaffold(
            body: Center(child: AppAnimatedLoadingIndicator()),
          );
        }

        if (state is QuizDetailsSuccess) {
          final quiz = state.quiz;

          return AdaptiveLayout(
            mobileLayout: (context) => CurrentRole.role == UserRole.instructor
                ? QuizDetailsMobileInstructorLayout(quiz: quiz)
                : QuizDetailsMobileStudentLayout(quiz: quiz),
            webLayout: (context) => CurrentRole.role == UserRole.instructor
                ? QuizDetailsWebInstructorLayout(quiz: quiz)
                : QuizDetailsWebStudentLayout(quiz: quiz),
          );
        }

        if (state is QuizDetailsFailure) {
          return Scaffold(body: Center(child: Text(state.errorMessage)));
        }

        return const SizedBox();
      },
    );
  }
}
