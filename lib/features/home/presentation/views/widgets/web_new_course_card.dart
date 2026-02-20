import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/features/home/presentation/views/layouts/web_create_course_view.dart';
import 'package:sams_app/features/home/presentation/views/widgets/enroll_course_dialog.dart';

class WebNewCourseCard extends StatelessWidget {
  const WebNewCourseCard({super.key, required this.role});
  final UserRole role;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 301 / 240,
      child: GestureDetector(
        onTap: () {
          role == UserRole.teacher
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WebCreateCourseView(),
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (context) => const EnrollCourseDialog(),
                );
        },
        child: DottedBorder(
          color: AppColors.secondary,
          strokeWidth: 1,
          dashPattern: const [4, 2],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightHover,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        AppImages.imagesCourseCardTopCorner,
                        width: w * 0.3,
                        height: h * 0.34,
                        fit: BoxFit.fill,
                      ),
                    ),

                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondaryActive,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                          color: AppColors.secondaryActive,
                        ),
                      ),
                    ),
                    // role == UserRole.student
                    //     ? Container(
                    //         width: double.infinity,
                    //         height: double.infinity,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           // color: AppColors.primaryLight,
                    //           color: Colors.white.withOpacity(0.6),
                    //         ),
                    //       )
                    //     : Container(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
