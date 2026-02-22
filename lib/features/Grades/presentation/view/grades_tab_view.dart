import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/Grades/presentation/view/widget/grades_mobile_layout.dart';
import 'package:sams_app/features/Grades/presentation/view/widget/grades_web_layout.dart';

class GradesTabView extends StatelessWidget {
  const GradesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const GradesMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const GradesWebLayout();
      },
    );
  }
}
