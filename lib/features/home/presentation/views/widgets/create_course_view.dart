import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/home/presentation/views/layouts/mobile_create_course_view.dart';
import 'package:sams_app/features/home/presentation/views/layouts/web_create_course_view.dart';

class CreateCourseView extends StatelessWidget {
  const CreateCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileCreateCourseView(),
      webLayout: (context) => const WebCreateCourseView(),
    );
  }
}
