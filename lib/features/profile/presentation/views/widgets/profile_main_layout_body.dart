// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sams_app/core/utils/assets/app_images.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_card.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/profile_pic_section.dart';

// class ProfileMainLayoutBody extends StatelessWidget {
//   const ProfileMainLayoutBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: SizedBox(
//             width: double.infinity,
//             child: SvgPicture.asset(
//               AppImages.imagesHeaderCard,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         const Column(
//           children: [
//             Spacer(
//               flex: 1,
//             ),
//             ProfilePicSection(),
//             Spacer(
//               flex: 1,
//             ),
//             ProfileInfoCard(),
//             Spacer(
//               flex: 1,
//             ),
//             Expanded(flex: 5, child: SizedBox(width: double.infinity)),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_card.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_pic_section.dart';

class ProfileMainLayoutBody extends StatelessWidget {
  const ProfileMainLayoutBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            child: SvgPicture.asset(
              AppImages.imagesHeaderCard,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Column(
          children: [
            Spacer(
              flex: 1,
            ),
            ProfilePicSection(),
            Spacer(
              flex: 1,
            ),
            ProfileInfoCard(),
            Spacer(
              flex: 1,
            ),
            Expanded(flex: 5, child: SizedBox(width: double.infinity)),
          ],
        ),
      ],
    );
  }
}
