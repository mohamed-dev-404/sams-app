import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/mobile/mobile_create_course_view.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/web/web_create_course_view.dart';

//* The main screen for instructors to create new courses
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
