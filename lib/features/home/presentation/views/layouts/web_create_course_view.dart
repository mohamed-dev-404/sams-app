import 'package:flutter/material.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_create_course_view_body.dart';

class WebCreateCourseView extends StatelessWidget {
  static String routName = 'createCourseView';

  const WebCreateCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebCreateCourseViewBody(),
    );
  }
}
