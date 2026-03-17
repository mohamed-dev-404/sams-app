import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/mobile/manage_questions_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/manage_questions/widgets/web/manage_questions_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/manage_quiz_cubit/manage_quiz_cubit.dart';
class ManageQuestionsView extends StatelessWidget {
  const ManageQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageQuizCubit, ManageQuizState>(
      listener: (context, state) {
        // TODO: Implement listener logic for ManageQuizFailure and ManageQuizSuccess later
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const ManageQuestionsMobileLayout(),
          webLayout: (context) => const ManageQuestionsWebLayout(),
        );
      },
    );
  }
}
