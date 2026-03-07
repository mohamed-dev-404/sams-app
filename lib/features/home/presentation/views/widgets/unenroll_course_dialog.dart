import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/custom_app_button.dart';
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
    final double screenWidth = SizeConfig.screenWidth(context);

    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : screenWidth * 0.25,
        vertical: 20,
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      actionsPadding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Unenroll from $courseName?',
        // textAlign: TextAlign.center,
      ),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Text(
        'You will be removed from this class.\n\nAll your files will remain in Google Drive.',
        style: AppStyles.mobileBodyMediumRg.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
      actions: [
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is RemoveCourseSuccess || state is RemoveCourseFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                  if (state is RemoveCourseSuccess) {
                    AppSnackBar.success(context, state.message);
                  } else if (state is RemoveCourseFailure) {
                    AppSnackBar.error(context, state.errMessage);
                  }
                }
              });
            }
          },
          builder: (context, state) {
            if (state is RemoveCourseLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    color: AppColors.primaryDark,
                  ),
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: CustomAppButton(
                    label: 'Cancel',
                    height: 40,
                    textColor: AppColors.primaryDark,
                    backgroundColor: AppColors.secondaryLight,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomAppButton(
                    label: 'Unenroll',
                    height: 40,
                    textColor: AppColors.primaryDark,
                    backgroundColor: AppColors.secondaryLight,
                    onPressed: () {
                      context.read<HomeCubit>().removeCourse(
                        courseId: courseId,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
