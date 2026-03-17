import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/component/widget/get_quizes/mobile/quiz_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/component/widget/get_quizes/web/quiz_web_layout.dart';

class QuizzesTabView extends StatelessWidget {
  final String courseId;
  const QuizzesTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (BuildContext context) {
          return const QuizMobileLayout();
        },
        webLayout: (BuildContext context) {
          return const QuizsWebLayout();
        },
      ),
    );
  }
}
