import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/data/models/home_course_model.dart';
import 'package:sams_app/core/widgets/custom_popup_menu_item.dart';

enum UserRole { student, instructor }

class WebHomeCourseCard extends StatelessWidget {
  WebHomeCourseCard({super.key, required this.course, required this.role});

  final UserRole role;
  final HomeCourseModel course;
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 301, maxHeight: 240),
      child: AspectRatio(
        aspectRatio: 301 / 240,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.primaryLightHover,
            borderRadius: BorderRadius.circular(20),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;

              return Stack(
                children: [
                  // Corner Top Image
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      width: constraints.maxWidth * 0.3,
                      height: constraints.maxHeight * 0.34,

                      AppImages.imagesCourseCardTopCorner,
                      fit: BoxFit.contain,
                      alignment: Alignment.topLeft,
                    ),
                  ),

                  // (Dots Menu)
                  Positioned(
                    right: constraints.maxWidth * 0.05,
                    top: constraints.maxHeight * 0.05,
                    child: PopupMenuButton<String>(
                      offset: Offset(
                        constraints.maxWidth * -.07,
                        .2 * constraints.maxHeight,
                      ),
                      color: AppColors.whiteLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        AppIcons.iconsMenu,
                        width: constraints.maxWidth * 0.02,
                      ),
                      itemBuilder: (context) {
                        if (role == UserRole.student) {
                          return [
                            CustomPopupMenuItem(
                              value: 'Unenroll',
                              title: 'Unenroll',
                              onTap: () {},
                            ),
                          ];
                        }
                        return [
                          CustomPopupMenuItem(
                            onTap: () {},
                            title: 'Edit',
                            value: 'edit',
                          ),
                          CustomPopupMenuItem(
                            onTap: () {},
                            title: 'Share link invitation',
                            value: 'share',
                          ),
                        ];
                      },
                    ),
                  ),

                  Positioned(
                    left: w * 0.15,
                    right: w * 0.05,
                    top: h * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              course.courseName,
                              style: AppStyles.mobileTitleLargeMd.copyWith(
                                color: AppColors.primaryDarker,
                                fontSize: w * 0.1, // ريسبونسيف بناءً على العرض
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '(${course.courseCode})',
                              style: AppStyles.mobileBodySmallRg.copyWith(
                                color: AppColors.whiteDarkHover,
                                fontSize: w * 0.045,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.05),
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.iconsPerson,
                              width: w * 0.07,
                              height: w * 0.07,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                course.instructorName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.webBodySmallRg.copyWith(
                                  color: AppColors.primaryDarker,
                                  fontSize: w * 0.06,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      width: constraints.maxWidth * 0.50,
                      height: constraints.minHeight * 0.4,
                      AppImages.imagesCourseCardBottomCorner,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
