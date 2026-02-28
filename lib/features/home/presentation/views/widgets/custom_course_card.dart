import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/presentation/views/widgets/course_card_content.dart';
import 'package:sams_app/features/home/presentation/views/widgets/course_card_decoration.dart';
import 'package:sams_app/features/home/presentation/views/widgets/course_card_menu.dart';


// --- Main Course Card Widget ---
class CustomCourseCard extends StatelessWidget {
  final UserRole role;
  final CourseModel course;
  final bool isMobile;

  const CustomCourseCard({
    super.key,
    required this.course,
    required this.role,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = isMobile ? (343 / 135) : (301 / 240);
    final double borderRadius = isMobile ? 15 : 20;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.primaryLightHover,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            return Stack(
              children: [
                /// Background Decorative Elements
                CourseCardDecorations(w: w, h: h, isMobile: isMobile),

                /// Management Menu Button
                CourseCardMenu(
                  w: w,
                  h: h,
                  role: role,
                  isMobile: isMobile,
                  course: course,
                ),

                /// Primary Course Information
                CourseCardContent(
                  w: w,
                  h: h,
                  course: course,
                  isMobile: isMobile,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// --- Sub-Widget: Background Decorations ---












