import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_create_course_view_body.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_custom_app_bar.dart';

class MobileCreateCourseView extends StatelessWidget {
  const MobileCreateCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileCustomAppBar(
        titleStyle: AppStyles.mobileTitleLargeMd.copyWith(
          color: AppColors.primaryDarkHover,
        ),
        arrowBackColor: AppColors.primaryDarkHover,
        title: 'Create Course',
      ),
      body: const MobileCreateCourseViewBody(),
    );
  }
}

