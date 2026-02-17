import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_custom_app_bar.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_main_layout_body.dart';

class MobileProfileView extends StatelessWidget {
  const MobileProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: MobileCustomAppBar(
        titleStyle: AppStyles.mobileTitleLargeMd.copyWith(
          color: AppColors.whiteLight,
        ),
        arrowBackColor: AppColors.whiteLight,
        title: 'Profile',
      ),
      body: const ProfileMainLayoutBody()
      ) ;
  }
}

 