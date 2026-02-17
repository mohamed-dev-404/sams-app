import 'package:flutter/material.dart';
import 'package:sams_app/features/home/presentation/views/widgets/enum_user_role.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_course_card.dart';

class CourseSliverList extends StatelessWidget {
  const CourseSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: MobileCourseCard(
            role: UserRole.teacher,
          ),
        );
      },
    );
  }
}
