import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final myCourseData = CourseHeaderCardModel(
      title: 'Database',
      instructor: 'Dr. Julie Watson',
      description: 'Advanced DB Course...',
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                const courseId = 'cs1010';

                final path = Uri(
                  path:
                      '${RoutesName.courses}/$courseId/${RoutesName.materials}',
                  queryParameters: {
                    'title': myCourseData.title,
                    'instructor': myCourseData.instructor,
                  },
                ).toString();

                context.go(path);
              },
              child: const Text('COURSE web DETAILS'),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                final courseId = 'cs1010'; //? ID from API

                context.push(
                  '${RoutesName.courses}/$courseId/${RoutesName.materials}',
                  extra: myCourseData,
                );
              },
              child: const Text('COURSE mobile DETAILS'),
            ),
          ],
        ),
      ),
    );
  }
}
