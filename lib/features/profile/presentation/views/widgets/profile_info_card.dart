import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/logout_item.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_item.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Data',
              style: AppStyles.mobileButtonMediumSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight(context) * .03,
            ),

            ProfileInfoItem(
              svgPath: AppIcons.iconsProfileName,
              label: 'Name',
              value: userModel.name ?? '',
            ),
            ProfileInfoItem(
              svgPath: AppIcons.iconsProfileEmail,
              label: 'Email',
              value: userModel.academicEmail ?? '',
            ),
            ProfileInfoItem(
              svgPath: AppIcons.iconsProfileId,
              label: 'ID',
              value: userModel.academicId ?? '',
            ),

            const LogoutSection(),
            SizedBox(
              height: SizeConfig.screenHeight(context) * .03,
            ),
          ],
        ),
      ),
    );
  }
}
