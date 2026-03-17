import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/grade_submission_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/web/grade_submission_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/grading_cubit/grading_cubit.dart';

class GradeSubmissionView extends StatelessWidget {
  const GradeSubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GradingCubit, GradingState>(
      listener: (context, state) {
        // TODO: Implement listener logic for GradingFailure and GradingSuccess later
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const GradeSubmissionMobileLayout(),
          webLayout: (context) => const GradeSubmissionWebLayout(),
        );
      },
    );
  }
}
