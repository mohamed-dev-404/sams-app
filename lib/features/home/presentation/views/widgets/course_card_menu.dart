import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/custom_popup_menu_item.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/views/widgets/delete_course_dialog.dart';
import 'package:sams_app/features/home/presentation/views/widgets/show_invitation_code_dialog.dart';
import 'package:sams_app/features/home/presentation/views/widgets/unenroll_course_dialog.dart';

//* Role-based contextual menu for course management (Edit, Delete, Share, etc.)
class CourseCardMenu extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final UserRole role;
  final bool isMobile;
  final CourseModel course;
  const CourseCardMenu({
    super.key,
    required this.cardWidth,
    required this.cardHeight,
    required this.role,
    required this.isMobile,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: cardWidth * 0.05,
      top: cardHeight * 0.05,
      child: PopupMenuButton<String>(
        //? Adjust menu position relative to the icon
        offset: Offset(-cardWidth * 0.07, cardHeight * 0.2),
        color: AppColors.whiteLight,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero,
        icon: SvgPicture.asset(
          AppIcons.iconsMenu,
          width: isMobile ? cardWidth * 0.15 : cardWidth * 0.09,
          height: isMobile ? cardHeight * 0.15 : cardHeight * 0.09,
        ),
        itemBuilder: (context) => _buildItems(context),
      ),
    );
  }

  //! Logic to differentiate available actions between Instructors and Students
  List<PopupMenuEntry<String>> _buildItems(BuildContext context) {
    if (role == UserRole.instructor) {
      return [
        CustomPopupMenuItem(
          value: 'share',
          title: 'Share Invitation Link',
          onTap: () {
            context.pop();
            showDialog(
              context: context,
              builder: (_) => ShowInvitationCodeDialog(
                invitationCode: course
                    .courseInvitationCode!, // pass the invitation code from course model
                courseName: course.name, // pass the name from course model
              ),
            );
            // debugPrint('Share Course'),
          },
        ),
        CustomPopupMenuItem(
          value: 'edit',
          title: 'Edit',
          onTap: () {
            context.pop();
            debugPrint('Edit Course');
          },
        ),
        CustomPopupMenuItem(
          value: 'delete',
          title: 'Delete',
          onTap: () {
            context.pop();
            final homeCubit = context.read<HomeCubit>();
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: homeCubit,
                child: DeleteCourseDialog(
                  courseId: course.id,
                  courseName: course.name,
                ),
              ),
            );
          },
        ),
      ];
    }
    // Student view: only allowed to Unenroll
    return [
      CustomPopupMenuItem(
        value: 'unenroll',
        title: 'Unenroll',
        onTap: () {
          context.pop();
          final homeCubit = context.read<HomeCubit>();
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: homeCubit,
              child: UnenrollCourseDialog(
                courseId: course.id,
                courseName: course.name,
              ),
            ),
          );
        },
      ),
    ];
  }
}
