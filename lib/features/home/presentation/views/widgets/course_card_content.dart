import 'package:flutter/material.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/presentation/views/widgets/course_title_row.dart';
import 'package:sams_app/features/home/presentation/views/widgets/instructor_row.dart';

class CourseCardContent extends StatelessWidget {
  final double w;
  final double h;
  final CourseModel course;
  final bool isMobile;

  const CourseCardContent({
    super.key,
    required this.w,
    required this.h,
    required this.course,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: w * 0.15,
      right: w * 0.05,
      top: h * 0.2,
      bottom: h * 0.08,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CourseTitleRow(course: course, isMobile: isMobile, w: w),
          SizedBox(height: h * (isMobile ? 0.08 : 0.04)),
          InstructorRow(course: course, w: w),
        ],
      ),
    );
  }
}