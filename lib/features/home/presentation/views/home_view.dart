import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final courseId = 'cs1010'; //? ID from API

            final myCourseData = CourseHeaderCardModel(
              title: 'Database',
              instructor: 'Dr. Julie Watson',
              description: 'Advanced DB Course...',
            );

            context.go(
              '/course/$courseId/materials',
              extra: myCourseData,
            );
          },
          child: const Text('COURSE DETAILS'),
        ),
      ),
    );
  }
}
