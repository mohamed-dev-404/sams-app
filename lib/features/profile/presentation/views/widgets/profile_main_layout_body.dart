// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sams_app/core/utils/assets/app_images.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
// import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_card.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/profile_pic_section.dart';

// class ProfileMainLayoutBody extends StatelessWidget {
//   const ProfileMainLayoutBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileCubit, ProfileState>(
//       listenWhen: (previous, current) =>
//           current is ProfileFailure ||
//           current is UploadProfilePicSuccess ||
//           current is UploadProfilePicFailure,
//       listener: (context, state) {
//         if (state is ProfileFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errMessage),
//               backgroundColor: AppColors.red,
//               duration: const Duration(seconds: 2),
//             ),

//           );
//         }

//         if (state is UploadProfilePicSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('the image uploaded successfully ✓ '),
//               backgroundColor: AppColors.greenDark,
//               duration: Duration(seconds: 1),
//             ),
//           );
//         }

//         if (state is UploadProfilePicFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errMessage),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       buildWhen: (previous, current) => current is! ProfileActionState,
//       builder: (context, state) {
//         if (state is ProfileSuccess) {
//           return Stack(
//             children: [
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: SizedBox(
//                   child: SvgPicture.asset(
//                     AppImages.imagesHeaderCard,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: ProfilePicSection(
//                       userModel: state.userModel,
//                     ),
//                   ),
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   Flexible(
//                     flex: 12,
//                     child: ProfileInfoCard(
//                       userModel: state.userModel,
//                     ),
//                   ),
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   const Expanded(
//                     flex: 5,
//                     child: SizedBox(width: double.infinity),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         }
//         if (state is ProfileFailure) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error_outline, size: 48, color: AppColors.red),
//                 const SizedBox(height: 16),
//                 Text(state.errMessage),
//                 TextButton(
//                   onPressed: () =>
//                       context.read<ProfileCubit>().getUserProfile(),
//                   child: const Text('Try again'),
//                 ),
//               ],
//             ),
//           );
//         }
//         return const Center(
//           child: CircularProgressIndicator(
//             color: AppColors.whiteLight,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_card.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_pic_section.dart';

class ProfileMainLayoutBody extends StatelessWidget {
  const ProfileMainLayoutBody({super.key});

  /// Dummy model used only to let Skeletonizer draw UI bones
  UserModel get _dummyUser => const UserModel(
        id: 'dummy-id',
        name: 'User Full Name', 
        academicEmail: 'username@academic.edu.eg', 
        academicId: '202XXXXXXX', 
        profilePic: '',
      );

  @override
  Widget build(BuildContext context) {
    bool isMobile = SizeConfig.isMobile(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileFailure ||
          current is UploadProfilePicSuccess ||
          current is UploadProfilePicFailure,
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        if (state is UploadProfilePicSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated successfully'), 
              backgroundColor: AppColors.greenDark,
              duration: Duration(seconds: 1),
            ),
          );
        }

        if (state is UploadProfilePicFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      buildWhen: (previous, current) => current is! ProfileActionState,
      builder: (context, state) {
        final bool isLoading = state is! ProfileSuccess;
        final user = state is ProfileSuccess ? state.userModel : _dummyUser;

        if (state is ProfileFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_off_rounded, size: 48, color: AppColors.red), 
                const SizedBox(height: 16),
                Text(state.errMessage),
                const SizedBox(height: 8),
                TextButton.icon( 
                  onPressed: () =>
                      context.read<ProfileCubit>().getUserProfile(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'), 
                ),
              ],
            ),
          );
        }

        return Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          child: Column(
            children: [
              // Variable top spacing based on device type
              SizedBox(height: isMobile ? 40 : 20),

              // Profile Picture Section
              ProfilePicSection(userModel: user),

              // Intermediate spacing
              SizedBox(height: isMobile ? 40 : 20),

              // User Information Card
              ProfileInfoCard(userModel: user),

              // Decorative background illustration
              Expanded(
                flex: 7,
                child: Align(
                  alignment: isMobile
                      ? Alignment.bottomCenter
                      : Alignment.bottomRight,
                  child: SvgPicture.asset(
                    AppImages.imagesHeaderCard,
                    fit: BoxFit.contain,
                    width: isMobile
                        ? double.infinity
                        : MediaQuery.sizeOf(context).width * 0.4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}