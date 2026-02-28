// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sams_app/core/models/app_button_style_model.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/styles/app_styles.dart';
// import 'package:sams_app/core/widgets/app_button.dart';
// import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
// import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';

// class UnenrollCourseDialog extends StatelessWidget {
//   const UnenrollCourseDialog({
//     super.key,
//     required this.courseId,
//     required this.courseName,
//   });

//   final String courseId;
//   final String courseName;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.whiteLight,
//       insetPadding: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
//       actionsPadding: const EdgeInsets.only(bottom: 10),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       title: Center(
//         child: Text(
//           'Unenroll from $courseName?',
//         ),
//       ),
//       titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
//         color: AppColors.primaryDarkHover,
//       ),
//       content: Text(
//         '''You will be removed from this class.

// All your files will remain in Google Drive.
// ''',
//         style: AppStyles.mobileBodyMediumRg.copyWith(
//           color: AppColors.primaryDark,
//         ),
//       ),
//       actions: [
//         BlocConsumer<HomeCubit, HomeState>(
//           listener: (context, state) {
//             if (state is UnEnrollCourseFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.errMessage),
//                   backgroundColor: AppColors.red,
//                 ),
//               );
//               Navigator.pop(context);
//             } else if (state is UnEnrollCourseSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: AppColors.green,
//                 ),
//               );
//               Navigator.pop(context);
//             }
//           },
//           builder: (context, state) {
//             if (state is UnEnrollCourseLoading) {
//               const Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryDark,
//                   ),
//                 ),
//               );
//             }
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 AppButton(
//                   model: AppButtonStyleModel(
//                     height: 55,
//                     width: 150,
//                     textColor: AppColors.primaryDark,
//                     backgroundColor: AppColors.secondaryLight,
//                     label: 'Cancel',
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 AppButton(
//                   model: AppButtonStyleModel(
//                     height: 55,
//                     width: 150,
//                     textColor: AppColors.primaryDark,
//                     backgroundColor: AppColors.secondaryLight,
//                     label: 'Unenroll',
//                     onPressed: () {
//                       context.read<HomeCubit>().unEnrollCourse(
//                         courseId: courseId,
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_button_widget.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';

class UnenrollCourseDialog extends StatelessWidget {
  const UnenrollCourseDialog({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  final String courseId;
  final String courseName;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        double dialogWidth = constraints.maxWidth;
        double dialogHeight = constraints.maxHeight;

        return AlertDialog(
          backgroundColor: AppColors.whiteLight,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          actionsPadding: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          /// ================= TITLE =================
          title: Padding(
            padding: const EdgeInsets.only(bottom: 33.0),
            child: Center(
              child: Text('Unenroll from $courseName?'),
            ),
          ),

          titleTextStyle: isMobile
              ? AppStyles.mobileTitleMediumSb.copyWith(
                  color: AppColors.primaryDarkHover,
                  fontSize: 24,
                )
              : AppStyles.webTitleMediumMd.copyWith(
                  color: AppColors.primaryDarkHover,
                  fontSize: dialogWidth * 0.023,
                ),

          /// ================= CONTENT =================
          content: Text(
            '''You will be removed from this class.

All your files will remain in Google Drive.
''',
            style: isMobile
                ? AppStyles.mobileBodyMediumRg.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 16,
                  )
                : AppStyles.mobileBodyMediumRg.copyWith(
                    color: AppColors.primaryDark,
                  ),
          ),

          /// ================= ACTIONS (WITH LOGIC) =================
          actions: [
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is UnEnrollCourseFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMessage),
                      backgroundColor: AppColors.red,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is UnEnrollCourseSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                /// ===== Loading State (kept logic exactly same) =====
                if (state is UnEnrollCourseLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryDark,
                      ),
                    ),
                  );
                }

                /// ===== Buttons UI (taken from second file) =====
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: isMobile ? 156 : dialogWidth * 0.1,
                      height: isMobile ? 40 : dialogHeight * 0.05,
                      child: AppButtonWidget(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: 'Cancel',
                        backgroundColor: AppColors.secondaryLight,
                        textColor: AppColors.primaryDark,
                        fontSize: isMobile ? 22 : dialogWidth * 0.013,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: isMobile ? 156 : dialogWidth * 0.1,
                      height: isMobile ? 40 : dialogHeight * 0.05,
                      child: AppButtonWidget(
                        onPressed: () {
                          context.read<HomeCubit>().unEnrollCourse(
                                courseId: courseId,
                              );
                        },
                        label: 'Unenroll',
                        backgroundColor: AppColors.secondaryLight,
                        textColor: AppColors.primaryDark,
                        fontSize: isMobile ? 22 : dialogWidth * 0.013,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
