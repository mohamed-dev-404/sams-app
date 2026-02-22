import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/widget/quiz_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/widget/quiz_web_layout.dart';

class QuizzesTabView extends StatelessWidget {
  const QuizzesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const QuizMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const QuizsWebLayout();
      },
    );
  }
}
