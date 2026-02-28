// import 'package:flutter/material.dart';
// import 'package:sams_app/core/utils/assets/app_icons.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/configs/size_config.dart';
// import 'package:sams_app/core/utils/styles/app_styles.dart';
// import 'package:sams_app/features/profile/data/models/user_model.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/logout_item.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_item.dart';

// class ProfileInfoCard extends StatelessWidget {
//   const ProfileInfoCard({
//     super.key,
//     required this.userModel,
//   });
//   final UserModel userModel;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.whiteLight,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.secondary),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Personal Data',
//               style: AppStyles.mobileButtonMediumSb.copyWith(
//                 color: AppColors.primaryDarkHover,
//               ),
//             ),
//             SizedBox(
//               height: SizeConfig.screenHeight(context) * .03,
//             ),

//             ProfileInfoItem(
//               svgPath: AppIcons.iconsProfileName,
//               label: 'Name',
//               value: userModel.name ?? '',
//             ),
//             ProfileInfoItem(
//               svgPath: AppIcons.iconsProfileEmail,
//               label: 'Email',
//               value: userModel.academicEmail ?? '',
//             ),
//             ProfileInfoItem(
//               svgPath: AppIcons.iconsProfileId,
//               label: 'ID',
//               value: userModel.academicId ?? '',
//             ),

//             const LogoutSection(),
//             SizedBox(
//               height: SizeConfig.screenHeight(context) * .03,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/logout_item.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_item.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Determine responsive width: 
    // Max 450px for Web/Desktop and 90% of screen width for Mobile devices
    double cardWidth = width > 800 ? 450 : width * 0.9;

    return Center(
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        // Reduced vertical padding for a more compact look
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.whiteLight,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.secondary),
        ),
        child: Column(
          // Uses minimum height required by children data
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Data',
              style: AppStyles.mobileButtonMediumSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            // Consistent spacing instead of complex SizeConfig calculations
            const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
