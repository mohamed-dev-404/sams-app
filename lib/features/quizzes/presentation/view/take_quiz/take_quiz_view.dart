import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/take_quiz/widgets/mobile/take_quiz_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/take_quiz/widgets/web/take_quiz_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/take_quiz_cubit/take_quiz_cubit.dart';

class TakeQuizView extends StatelessWidget {
  const TakeQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TakeQuizCubit, TakeQuizState>(
      listener: (context, state) {
        // TODO: Handle TakeQuizFailure (AppSnackBar) and TakeQuizSuccess
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const TakeQuizMobileLayout(),
          webLayout: (context) => const TakeQuizWebLayout(),
        );
      },
    );
  }
}
