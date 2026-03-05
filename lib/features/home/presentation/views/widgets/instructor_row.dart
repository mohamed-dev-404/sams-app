
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
  final bool isMobile;

  const InstructorRow({
    super.key,
    required this.course,
    required this.w,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.iconsPerson,
            width: w * 0.06,
            height: w * 0.06,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryDarker,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 5),
          AutoSizeText(
            course.instructor,
            //course.instructor.firstTwoNames,
            style: AppStyles.mobileBodySmallRg.copyWith(
              color: AppColors.primaryDarker,
              fontSize: isMobile ? null : w * 0.05,
            ),
            maxLines: isMobile ? 1 : 2,
            minFontSize: isMobile ? 12 : 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

extension StringFormat on String {
  String get firstTwoNames {
    List<String> names = trim().split(RegExp(r'\s+'));
    if (names.length <= 2) return this;
    return '${names[0]} ${names[1]}';
  }
}
