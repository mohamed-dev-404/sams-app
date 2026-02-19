// import 'package:flutter/material.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/configs/size_config.dart';
// import 'package:sams_app/core/utils/styles/app_styles.dart';
// import 'package:sams_app/features/home/presentation/views/widgets/web_home_header.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/profile_main_layout_body.dart';

// class WebProfileViewBody extends StatelessWidget {
//   const WebProfileViewBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const WebHomeHeader(),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           'Profile',
//           style: AppStyles.webTitleLargeMd.copyWith(
//             color: AppColors.primaryDarkHover,
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Center(
//           child: Container(
//             constraints: const BoxConstraints(minWidth: 300, maxWidth: 700),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(25)),
//               color: AppColors.primary,
//             ),

//             height: SizeConfig.screenHeight(context) * .7,
//             width: SizeConfig.screenWidth(context) * .27,

//             child: const ProfileMainLayoutBody(),
//           ),
//         ),
//         const Spacer(),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_header.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_main_layout_body.dart';

class WebProfileViewBody extends StatelessWidget {
  const WebProfileViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
  slivers: [
    /// الهيدر
    const SliverToBoxAdapter(
      child: WebHomeHeader(),
    ),

    const SliverToBoxAdapter(
      child: SizedBox(height: 5),
    ),

    /// العنوان
    SliverToBoxAdapter(
      child: Center(
        child: Text(
          'Profile',
          style: AppStyles.webTitleLargeMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
      ),
    ),

    const SliverToBoxAdapter(
      child: SizedBox(height: 10),
    ),

    /// الكارد الرئيسي
    SliverToBoxAdapter(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 300,
            maxWidth: 700,
          ),
          child: SizedBox(
            /// خليه نسبي للشاشة زي ما كنتي عاملة
            height: SizeConfig.screenHeight(context) * .7,
            width: SizeConfig.screenWidth(context) * .27,

            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: AppColors.primary,
              ),
              child: const ProfileMainLayoutBody(),
            ),
          ),
        ),
      ),
    ),

    /// بدل Spacer (مهم جداً)
    const SliverFillRemaining(
      hasScrollBody: false,
      child: SizedBox(),
    ),
  ],
);

  }
}
