import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/custom_popup_menu_item.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/presentation/views/widgets/enroll_course_dialog.dart';
import 'package:sams_app/features/home/presentation/views/widgets/unenroll_course_dialog.dart';

class CourseCardMenu extends StatelessWidget {
  final double w;
  final double h;
  final UserRole role;
  final bool isMobile;
  final CourseModel course;
  const CourseCardMenu({
    super.key,
    required this.w,
    required this.h,
    required this.role,
    required this.isMobile,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: w * 0.05,
      top: h * 0.05,
      child: PopupMenuButton<String>(
        offset: Offset(-w * 0.07, h * 0.2),
        color: AppColors.whiteLight,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero,
        icon: SvgPicture.asset(
          AppIcons.iconsMenu,
          width: isMobile ? w * 0.15 : w * 0.09,
          height: isMobile ? h * 0.15 : h * 0.09,
        ),
        itemBuilder: (context) => _buildItems(context),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildItems(BuildContext context) {
    if (role == UserRole.teacher) {
      return [
        CustomPopupMenuItem(
          value: 'edit',
          title: 'Edit',
          onTap: () => showDialog(
            context: context,
            builder: (_) => const EnrollCourseDialog(),
          ),
        ),
        CustomPopupMenuItem(
          value: 'share',
          title: 'Share Invitation Link',
          onTap: () => debugPrint('Share Course'),
        ),
      ];
    }
    return [
      CustomPopupMenuItem(
        value: 'unenroll',
        title: 'Unenroll',
        onTap: () => showDialog(
          context: context,
          builder: (_) => UnenrollCourseDialog(
            courseId: course.id, // pass the id from course model
            courseName: course.name, // pass the name from course model
          ),
        ),
      ),
    ];
  }
}