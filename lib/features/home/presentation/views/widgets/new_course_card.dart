import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart' show UserRole;
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/views/widgets/enroll_course_dialog.dart';

class NewCourseCard extends StatelessWidget {
  const NewCourseCard({super.key, required this.role, this.isMobile = false});

  final UserRole role;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;
        final double cardHeight = isMobile ? cardWidth * 0.37 : cardWidth * 0.8;

        return GestureDetector(
          onTap: () => _handleOnTap(context),
          child: Opacity(
            opacity: .88,
            child: DottedBorder(
              color: AppColors.secondary,
              strokeWidth: 1.5,
              dashPattern: const [6, 2],
              borderType: BorderType.RRect,
              radius: Radius.circular(isMobile ? 15 : 20),
              child: Container(
                width: cardWidth,
                height: cardHeight,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightHover,
                  borderRadius: BorderRadius.circular(isMobile ? 15 : 20),
                ),
                child: Stack(
                  children: [
                    _buildTopCornerDecoration(cardHeight),
                    _buildAddIcon(cardHeight, isMobile),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleOnTap(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    if (role == UserRole.instructor) {
      context.pushNamed(RoutesName.createCourse, extra: homeCubit);
    } else {
      showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
          value: homeCubit,
          child: const EnrollCourseDialog(),
        ),
      );
    }
  }

  Widget _buildAddIcon(double cardHeight, bool isMobile) {
    return Center(
      child: isMobile
          ? SvgPicture.asset(
              AppIcons.iconsAdd,
              height: cardHeight * 0.35,
            )
          : Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.secondaryActive, width: 2),
              ),
              child: const Icon(
                Icons.add,
                size: 30,
                color: AppColors.secondaryActive,
              ),
            ),
    );
  }

  Widget _buildTopCornerDecoration(double cardHeight) {
    return Positioned(
      top: 0,
      left: 0,
      child: ClipRect(
        child: Align(
          alignment: Alignment.bottomRight,
          widthFactor: 0.7,
          heightFactor: 0.88,
          child: SizedBox(
            width: cardHeight * (isMobile ? 0.66 : 0.55),
            height: cardHeight * (isMobile ? 0.66 : 0.55),
            child: SvgPicture.asset(
              AppImages.imagesCourseCardTopCorner,
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }
}
