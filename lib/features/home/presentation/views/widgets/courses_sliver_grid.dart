import 'package:flutter/material.dart';
import 'package:sams_app/features/home/data/models/home_course_model.dart';
import 'package:sams_app/features/home/presentation/views/widgets/enum_user_role.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_course_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_new_course_card.dart';

class CoursesSliverGrid extends StatelessWidget {
  const CoursesSliverGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 7) {
              return const WebNewCourseCard(
                role: UserRole.student,
              );
            }
            return const WebCourseCard(
              course: HomeCourseModel(
                courseName: 'Database',
                courseCode: 'CS1010',
                instructorName: 'Julie Watson',
              ),
              role: UserRole.student,
            );
          },
          childCount: 8,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 301 / 240,
        ),
      ),
    );
  }
}
