// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sams_app/core/utils/assets/app_icons.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/configs/size_config.dart';
// import 'package:sams_app/features/profile/data/models/user_model.dart';
// import 'package:sams_app/features/profile/presentation/utils/image_acquisition.dart';
// import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
// import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/image_preview_dialog.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/image_source_sheet.dart';

// class ProfilePicSection extends StatefulWidget {
//   const ProfilePicSection({super.key, required this.userModel});
//   final UserModel userModel;

//   @override
//   State<ProfilePicSection> createState() => _ProfilePicSectionState();
// }

// class _ProfilePicSectionState extends State<ProfilePicSection> {
//   XFile? _pickedImage;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProfileCubit, ProfileState>(
//       listener: (context, state) {
//         if (state is UploadProfilePicSuccess) {
//           setState(() {
//             _pickedImage = null;
//           });
//         }
//       },
//       child: Center(
//         child: SizedBox(
//           width: SizeConfig.screenWidth(context) * .35,
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Stack(
//               alignment: Alignment.center,
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   //  width: double.infinity,
//                   height: double.infinity,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.fromBorderSide(
//                       BorderSide(
//                         color: AppColors.secondary,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                   child: ClipOval(
//                     child: BlocBuilder<ProfileCubit, ProfileState>(
//                       buildWhen: (previous, current) =>
//                           current is ProfileSuccess ||
//                           current is UploadProfilePicSuccess,
//                       builder: (context, state) {
//                         return _buildProfileImage(state);
//                       },
//                     ),
//                   ),
//                 ),

//                 BlocBuilder<ProfileCubit, ProfileState>(
//                   buildWhen: (previous, current) =>
//                       current is UploadProfilePicLoading ||
//                       current is! UploadProfilePicLoading,
//                   builder: (context, state) {
//                     if (state is UploadProfilePicLoading) {
//                       return _buildLoadingOverlay();
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),

//                 Positioned(
//                   bottom: 5,
//                   right: 0,
//                   left: 85,
//                   child: GestureDetector(
//                     onTap: _showImageSourceSheet,
//                     child: _buildEditIcon(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? processedImage = await ImageAcquisition.pickImage(
//       context,
//       source,
//     );

//     if (processedImage != null) {
//       setState(() {
//         _pickedImage = processedImage;
//       });

//       if (mounted) {
//         context.read<ProfileCubit>().uploadProfileImage(processedImage);
//       }
//     }
//   }

//   void _showImageSourceSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => ImageSourceBottomSheet(
//         onSourceSelected: _pickImage,
//       ),
//     );
//   }

//   Widget _buildEditIcon() {
//     return Container(
//       width: SizeConfig.isMobile(context)
//           ? SizeConfig.screenWidth(context) * .10
//           : SizeConfig.screenWidth(context) * .023,
//       height: SizeConfig.isMobile(context)
//           ? SizeConfig.screenWidth(context) * .10
//           : SizeConfig.screenWidth(context) * .023,
//       padding: const EdgeInsets.all(8),
//       decoration: const BoxDecoration(
//         color: AppColors.secondary,
//         shape: BoxShape.circle,
//       ),
//       child: SvgPicture.asset(
//         AppIcons.iconsEditMaterial,
//         colorFilter: const ColorFilter.mode(
//           AppColors.whiteLight,
//           BlendMode.srcIn,
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingOverlay() {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.black.withValues(alpha: 0.4),
//         shape: BoxShape.circle,
//       ),
//       child: const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildProfileImage(ProfileState state) {
//     if (state is UploadProfilePicLoading && _pickedImage != null) {
//       return kIsWeb
//           ? Image.network(_pickedImage!.path, fit: BoxFit.cover)
//           : Image.file(File(_pickedImage!.path), fit: BoxFit.cover);
//     }

//     UserModel displayUser = widget.userModel;
//     if (state is ProfileSuccess) {
//       displayUser = state.userModel;
//     } else if (state is UploadProfilePicSuccess) {
//       displayUser = state.userModel;
//     }

//     if (displayUser.profilePic != null && displayUser.profilePic!.isNotEmpty) {
//       return GestureDetector(
//         onTap: () => ImagePreviewDialog.open(context, displayUser.profilePic!),
//         child: Hero(
//           tag: displayUser.profilePic!,
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: CachedNetworkImage(
//               imageUrl:
//                   '${displayUser.profilePic}?t=${DateTime.now().millisecondsSinceEpoch}',
//               fit: BoxFit.cover,
//               key: ValueKey(displayUser.profilePic),
//               placeholder: (context, url) => const Center(
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//               errorWidget: (context, url, error) => _buildDefaultIcon(),
//             ),
//           ),
//         ),
//       );
//     }

//     return _buildDefaultIcon();
//   }

//   Widget _buildDefaultIcon() {
//     return FittedBox(
//       child: SvgPicture.asset(
//         AppIcons.iconsHomeProfileHeader,
//         colorFilter: const ColorFilter.mode(
//           AppColors.whiteLight,
//           BlendMode.srcIn,
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sams_app/core/utils/assets/app_icons.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/configs/size_config.dart';
// import 'package:sams_app/features/profile/data/models/user_model.dart';
// import 'package:sams_app/features/profile/presentation/utils/image_acquisition.dart';
// import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
// import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/image_preview_dialog.dart';
// import 'package:sams_app/features/profile/presentation/views/widgets/image_source_sheet.dart';

// class ProfilePicSection extends StatefulWidget {
//   const ProfilePicSection({super.key, required this.userModel});
//   final UserModel userModel;

//   @override
//   State<ProfilePicSection> createState() => _ProfilePicSectionState();
// }

// class _ProfilePicSectionState extends State<ProfilePicSection> {
//   XFile? _pickedImage;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ProfileCubit, ProfileState>(
//       listener: (context, state) {
//         if (state is UploadProfilePicSuccess) {
//           setState(() {
//             _pickedImage = null;
//           });
//         }
//       },
//       child: Expanded(
//         flex: 5,
//         child: Center(
//           child: SizedBox(
//             width: SizeConfig.isMobile(context)
//                 ? SizeConfig.screenWidth(context) * .35
//                 : SizeConfig.screenWidth(context) * .40,
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: Stack(
//                 alignment: Alignment.bottomRight,
//                 clipBehavior: Clip.none,
//                 children: [
//                   // دائرة الصورة الشخصية
//                   Container(
//                     width: double.infinity,
//                     height: double.infinity,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: ClipOval(
//                       child: BlocBuilder<ProfileCubit, ProfileState>(
//                         buildWhen: (previous, current) =>
//                             current is ProfileSuccess ||
//                             current is UploadProfilePicSuccess ||
//                             current is UploadProfilePicLoading,
//                         builder: (context, state) {
//                           return _buildProfileImage(state);
//                         },
//                       ),
//                     ),
//                   ),

//                   // مؤشر التحميل (Loading Overlay)
//                   BlocBuilder<ProfileCubit, ProfileState>(
//                     builder: (context, state) {
//                       if (state is UploadProfilePicLoading) {
//                         return _buildLoadingOverlay();
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),

//                   // أيقونة التعديل (Edit Icon)
//                   Positioned(
//                     bottom: 5,
//                     right: 0,
//                     left: SizeConfig.isMobile(context) ? 85 : 75, // دمج منطق الـ Positioning
//                     child: GestureDetector(
//                       onTap: _showImageSourceSheet,
//                       child: _buildEditIcon(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // --- Functions & Logic ---

//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? processedImage = await ImageAcquisition.pickImage(
//       context,
//       source,
//     );

//     if (processedImage != null) {
//       setState(() {
//         _pickedImage = processedImage;
//       });

//       if (mounted) {
//         context.read<ProfileCubit>().uploadProfileImage(processedImage);
//       }
//     }
//   }

//   void _showImageSourceSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => ImageSourceBottomSheet(
//         onSourceSelected: _pickImage,
//       ),
//     );
//   }

//   // --- UI Components ---

//   Widget _buildEditIcon() {
//     return Container(
//       width: SizeConfig.isMobile(context)
//           ? SizeConfig.screenWidth(context) * .10
//           : 30, // استخدام القيمة الثابتة 30 كما في الفايل الثاني
//       height: SizeConfig.isMobile(context)
//           ? SizeConfig.screenWidth(context) * .10
//           : 30,
//       padding: const EdgeInsets.all(8),
//       decoration: const BoxDecoration(
//         color: AppColors.secondary,
//         shape: BoxShape.circle,
//       ),
//       child: SvgPicture.asset(
//         AppIcons.iconsEditMaterial,
//         colorFilter: const ColorFilter.mode(
//           AppColors.whiteLight,
//           BlendMode.srcIn,
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingOverlay() {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.black.withAlpha((0.4 * 255).toInt()),
//         shape: BoxShape.circle,
//       ),
//       child: const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       ),
//     );
//   }

//   Widget _buildProfileImage(ProfileState state) {
//     // عرض الصورة المختارة فوراً أثناء الرفع
//     if (state is UploadProfilePicLoading && _pickedImage != null) {
//       return kIsWeb
//           ? Image.network(_pickedImage!.path, fit: BoxFit.cover)
//           : Image.file(File(_pickedImage!.path), fit: BoxFit.cover);
//     }

//     UserModel displayUser = widget.userModel;
//     if (state is ProfileSuccess) {
//       displayUser = state.userModel;
//     } else if (state is UploadProfilePicSuccess) {
//       displayUser = state.userModel;
//     }

//     if (displayUser.profilePic != null && displayUser.profilePic!.isNotEmpty) {
//       return GestureDetector(
//         onTap: () => ImagePreviewDialog.open(context, displayUser.profilePic!),
//         child: Hero(
//           tag: displayUser.profilePic!,
//           child: CachedNetworkImage(
//             imageUrl:
//                 '${displayUser.profilePic}?t=${DateTime.now().millisecondsSinceEpoch}',
//             fit: BoxFit.cover,
//             key: ValueKey(displayUser.profilePic),
//             placeholder: (context, url) => const Center(
//               child: CircularProgressIndicator(strokeWidth: 2),
//             ),
//             errorWidget: (context, url, error) => _buildDefaultIcon(),
//           ),
//         ),
//       );
//     }

//     return _buildDefaultIcon();
//   }

//   Widget _buildDefaultIcon() {
//     return FittedBox(
//       child: SvgPicture.asset(
//         AppIcons.iconsHomeProfileHeader,
//         colorFilter: const ColorFilter.mode(
//           AppColors.white, // تم تغييرها لـ White بناءً على الفايل الثاني
//           BlendMode.srcIn,
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/presentation/utils/image_acquisition.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/image_preview_dialog.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/image_source_sheet.dart';

// --- Main Section (Stateful) ---

class ProfilePicSection extends StatefulWidget {
  const ProfilePicSection({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfilePicSection> createState() => _ProfilePicSectionState();
}

class _ProfilePicSectionState extends State<ProfilePicSection> {
  XFile? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UploadProfilePicSuccess) {
          setState(() => _pickedImage = null);
        }
      },
      child: Expanded(
        flex: 5,
        child: Center(
          child: SizedBox(
            width: SizeConfig.isMobile(context)
                ? SizeConfig.screenWidth(context) * .35
                : SizeConfig.screenWidth(context) * .40,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                alignment: Alignment.bottomRight,
                clipBehavior: Clip.none,
                children: [
                  // Profile Avatar Widget
                  ProfileAvatarDisplay(
                    userModel: widget.userModel,
                    pickedImage: _pickedImage,
                  ),

                  // Loading Overlay Widget
                  const ProfilePicLoadingOverlay(),

                  // Edit Button Widget
                  ProfileEditButton(
                    onTap: _showImageSourceSheet,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? processedImage =
        await ImageAcquisition.pickImage(context, source);
    if (processedImage != null) {
      setState(() => _pickedImage = processedImage);
      if (mounted) {
        context.read<ProfileCubit>().uploadProfileImage(processedImage);
      }
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ImageSourceBottomSheet(onSourceSelected: _pickImage),
    );
  }
}

// --- Sub-Widgets (Can be moved to separate files) ---

class ProfileAvatarDisplay extends StatelessWidget {
  final UserModel userModel;
  final XFile? pickedImage;

  const ProfileAvatarDisplay({
    super.key,
    required this.userModel,
    this.pickedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>
              current is ProfileSuccess ||
              current is UploadProfilePicSuccess ||
              current is UploadProfilePicLoading,
          builder: (context, state) => _resolveImageWidget(context, state),
        ),
      ),
    );
  }

  Widget _resolveImageWidget(BuildContext context, ProfileState state) {
    // 1. Show local picked image during upload
    if (state is UploadProfilePicLoading && pickedImage != null) {
      return kIsWeb
          ? Image.network(pickedImage!.path, fit: BoxFit.cover)
          : Image.file(File(pickedImage!.path), fit: BoxFit.cover);
    }

    // 2. Resolve display user
    UserModel displayUser = userModel;
    if (state is ProfileSuccess) displayUser = state.userModel;
    if (state is UploadProfilePicSuccess) displayUser = state.userModel;

    // 3. Render Network Image or Default Icon
    if (displayUser.profilePic?.isNotEmpty ?? false) {
      return GestureDetector(
        onTap: () => ImagePreviewDialog.open(context, displayUser.profilePic!),
        child: Hero(
          tag: displayUser.profilePic!,
          child: CachedNetworkImage(
            imageUrl:
                '${displayUser.profilePic}?t=${DateTime.now().millisecondsSinceEpoch}',
            fit: BoxFit.cover,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            errorWidget: (_, __, ___) => const DefaultProfileIcon(),
          ),
        ),
      );
    }

    return const DefaultProfileIcon();
  }
}

class ProfilePicLoadingOverlay extends StatelessWidget {
  const ProfilePicLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is UploadProfilePicLoading) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.black.withAlpha((0.4 * 255).toInt()),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ProfileEditButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileEditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile(context);
    final double buttonSize = isMobile 
        ? SizeConfig.screenWidth(context) * .10 
        : 30;

    return Positioned(
      bottom: 5,
      right: 0,
      left: isMobile ? 85 : 75,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: buttonSize,
          height: buttonSize,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppIcons.iconsEditMaterial,
            colorFilter: const ColorFilter.mode(
              AppColors.whiteLight,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultProfileIcon extends StatelessWidget {
  const DefaultProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SvgPicture.asset(
        AppIcons.iconsHomeProfileHeader,
        colorFilter: const ColorFilter.mode(
          AppColors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
