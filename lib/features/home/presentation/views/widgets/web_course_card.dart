import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/custom_popup_menu_item.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';
import 'package:sams_app/features/home/presentation/views/widgets/show_invitation_code_dialog.dart';
import 'package:sams_app/features/home/presentation/views/widgets/unenroll_course_dialog.dart';

class WebCourseCard extends StatelessWidget {
  const WebCourseCard({super.key, required this.course, required this.role});

  final UserRole role;
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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
                /// Top Decoration
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

                /// Menu
                Positioned(
                  right: w * 0.05,
                  top: h * 0.05,
                  child: PopupMenuButton<String>(
                    offset: Offset(-w * .07, h * .2),
                    color: AppColors.whiteLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      AppIcons.iconsMenu,
                      width: w * 0.08, // Increased from 0.04
                      height: w * 0.08,
                    ),
                    itemBuilder: (context) {
                      if (role == UserRole.student) {
                        return [
                          CustomPopupMenuItem(
                            value: 'Unenroll',
                            title: 'Unenroll',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const UnenrollCourseDialog(),
                              );
                            },
                            //  textStyle: menuItemStyle,
                          ),
                        ];
                      }

                      return [
                        CustomPopupMenuItem(
                          value: 'edit',
                          title: 'Edit',
                          onTap: () {
                            debugPrint('Edit Course');
                          },
                          //  textStyle: menuItemStyle,
                        ),
                        CustomPopupMenuItem(
                          value: 'share',
                          title: 'Share  Invitation Code',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ShowInvitationCodeDialog(
                                invitationCode: course.courseInvitationCode!,
                              ),
                            );
                          },
                          //  textStyle: menuItemStyle,
                        ),
                      ];
                    },
                  ),
                ),

                /// MAIN CONTENT
                Positioned(
                  left: w * 0.15,
                  right: w * 0.05,
                  top: h * 0.2,
                  bottom: h * 0.08, // Increased bottom margin slightly
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Allow column to shrink if needed
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center content vertically available space
                    children: [
                      // Course Name & Code
                      Flexible(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              // Changed from Expanded so text doesn't force full width
                              child: AutoSizeText(
                                course.name,
                                style: AppStyles.mobileTitleLargeMd.copyWith(
                                  color: AppColors.primaryDarker,
                                ),
                                maxLines: 2,
                                minFontSize: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // SizedBox(width: w * 0.02),
                            AutoSizeText(
                              '(${course.academicCourseCode})',
                              style: AppStyles.mobileBodySmallRg.copyWith(
                                color: AppColors.whiteDarkHover,
                                fontSize: w * 0.04, // Reduced from 0.045
                              ),
                              maxLines: 1,
                              minFontSize: 8,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                      // Instructor
                      Flexible(
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
                                padding: EdgeInsets.only(
                                  right: w * 0.25,
                                ), // Reduced padding
                                child: AutoSizeText(
                                  course.instructor,
                                  style: AppStyles.mobileTitleLargeMd.copyWith(
                                    color: AppColors.primaryDarker,
                                    fontSize: w * 0.06, // Reduced from 0.08
                                  ),
                                  maxLines: 2,
                                  minFontSize: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Bottom Decoration
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    AppImages.imagesCourseCardBottomCorner,
                    width: w * 0.5,
                    height: h * 0.4,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
