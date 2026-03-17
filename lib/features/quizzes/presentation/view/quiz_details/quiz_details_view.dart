import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/mobile/quiz_details_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/quiz_details/widgets/web/quiz_details_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/browse_quiz_cubit/browse_quiz_cubit.dart';

class QuizDetailsView extends StatelessWidget {
  const QuizDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowseQuizCubit, BrowseQuizState>(
      listener: (context, state) {
        // TODO: Implement listener logic for QuizFailure and QuizSuccess later
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const QuizDetailsMobileLayout(),
          webLayout: (context) => const QuizDetailsWebLayout(),
        );
      },
    );
  }
}
