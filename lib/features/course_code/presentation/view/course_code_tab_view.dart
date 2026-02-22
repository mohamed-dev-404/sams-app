import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/course_code/presentation/view/widget/course_code_mobile_layout.dart';
import 'package:sams_app/features/course_code/presentation/view/widget/course_code_web_layout.dart';

class CourseCodeTabView extends StatelessWidget {
  const CourseCodeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const CourseCodeMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const CourseCodeWebLayout();
      },
    );
  }
}
