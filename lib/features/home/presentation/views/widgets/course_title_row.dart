import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';

class CourseTitleRow extends StatelessWidget {
  final CourseModel course;
  final bool isMobile;
  final double w;

  const CourseTitleRow({
    required this.course,
    required this.isMobile,
    required this.w,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: AutoSizeText(
              course.name,
              style: AppStyles.mobileBodyXXlargeMd.copyWith(
                color: AppColors.primaryDarker,
              ),
              maxLines: 2,
              minFontSize: 8,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: AutoSizeText(
              '(${course.academicCourseCode})',
              style: AppStyles.mobileBodySmallRg.copyWith(
                color: AppColors.whiteDarkHover,
                fontSize: w * (isMobile ? 0.033 : 0.04),
              ),
              maxLines: 1,
              minFontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}