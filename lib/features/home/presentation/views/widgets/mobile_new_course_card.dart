import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/views/create_course_view.dart';
import 'package:sams_app/features/home/presentation/views/widgets/enroll_course_dialog.dart';

class MobileNewCourseCard extends StatelessWidget {
  const MobileNewCourseCard({super.key, required this.role});
  final UserRole role;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = cardWidth * 0.35;

        return GestureDetector(
          onTap: () {
            if (role == UserRole.student) {
              showDialog(
                context: context,
                builder: (context) => const EnrollCourseDialog(),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (homeContext) => BlocProvider.value(
                    value: BlocProvider.of<HomeCubit>(context),
                    child: const CreateCourseView(),
                  ),
                ),
              );
              debugPrint('Create Course');
            }
          },
          child: Opacity(
            opacity: .75,
            child: Container(
              width: double.infinity,
              height: cardHeight,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.primaryLightHover,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1.5,
                  color: AppColors.secondary,
                ),
              ),
              child: Stack(
                children: [
                  _buildAddSection(cardHeight),
                  _buildTopCorner(cardHeight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddSection(double cardHeight) {
    return Center(
      child: SizedBox(
        height: cardHeight * 0.35,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppIcons.iconsAdd,
          ),
        ),
      ),
    );
  }

  Widget _buildTopCorner(double cardHeight) {
    return Positioned(
      top: 0,
      left: 0,
      child: ClipRect(
        child: Align(
          alignment: Alignment.bottomRight,
          widthFactor: 0.7,
          heightFactor: 0.88,
          child: SizedBox(
            width: cardHeight * .66,
            height: cardHeight * .66,
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(AppImages.imagesCourseCardTopCorner),
            ),
          ),
        ),
      ),
    );
  }
}
