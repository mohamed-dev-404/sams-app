import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/widgets/mobile/create_quiz_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/widgets/web/create_quiz_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/manage_quiz_cubit/manage_quiz_cubit.dart';

class CreateQuizView extends StatelessWidget {
  const CreateQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageQuizCubit, ManageQuizState>(
      listener: (context, state) {
        // TODO: Implement listener logic for ManageQuizFailure and ManageQuizSuccess later
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const CreateQuizMobileLayout(),
          webLayout: (context) => const CreateQuizWebLayout(),
        );
      },
    );
  }
}
