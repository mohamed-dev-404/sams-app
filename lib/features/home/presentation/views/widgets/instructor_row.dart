import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';

class InstructorRow extends StatelessWidget {
  final CourseModel course;
  final double w;

  const InstructorRow({required this.course, required this.w});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.iconsPerson,
            width: w * 0.06,
            height: w * 0.06,
          ),
          SizedBox(width: w * 0.02),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: w * 0.25),
              child: AutoSizeText(
                course.instructor,
                style: AppStyles.mobileBodySmallRg.copyWith(
                  color: AppColors.primaryDarker,
                  fontSize: w * 0.06,
                ),
                maxLines: 2,
                minFontSize: 8,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}