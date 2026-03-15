import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/presentation/view/widget/shared/material_sliver_list.dart';

class MobileMaterialsDetailsViewBody extends StatelessWidget {
  const MobileMaterialsDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 32),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(18),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ch1',
                      style: AppStyles.mobileTitleLargeMd.copyWith(
                        color: AppColors.primaryDarkHover,
                      ),
                    ),
                    SvgPicture.asset(AppIcons.iconsEditMaterial),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Chapter 1: Database Fundamentals and theories',
                  style: AppStyles.mobileBodyMediumRg.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 8,
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Material Content',
              style: AppStyles.mobileTitleMediumSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
          ),
        ),
        MaterialsSliverList(),
      ],
    );
  }
}
