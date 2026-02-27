import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart'; // لعمل فحص kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';

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
          setState(() {
            _pickedImage = null;
          });
        }
      },
      child: Center(
        child: SizedBox(
          width: SizeConfig.screenWidth(context) * .35,
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: AppColors.secondary,
                        width: 2,
                      ),
                    ),
                  ),
                  child: ClipOval(
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      buildWhen: (previous, current) =>
                          current is ProfileSuccess ||
                          current is UploadProfilePicSuccess,
                      builder: (context, state) {
                        return _buildProfileImage(state);
                      },
                    ),
                  ),
                ),

                BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                      current is UploadProfilePicLoading ||
                      current is! UploadProfilePicLoading,
                  builder: (context, state) {
                    if (state is UploadProfilePicLoading) {
                      return _buildLoadingOverlay();
                    }
                    return const SizedBox.shrink();
                  },
                ),

                Positioned(
                  bottom: 5,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: _buildEditIcon(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   
  
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
      if (mounted) {
        context.read<ProfileCubit>().uploadProfileImage(image);
      }
    }
  }


  Widget _buildEditIcon() {
    return Container(
      width: SizeConfig.isMobile(context)
          ? SizeConfig.screenWidth(context) * .10
          : SizeConfig.screenWidth(context) * .023,
      height: SizeConfig.isMobile(context)
          ? SizeConfig.screenWidth(context) * .10
          : SizeConfig.screenWidth(context) * .023,
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
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildProfileImage(ProfileState state) {
        if (state is UploadProfilePicLoading && _pickedImage != null) {
          return kIsWeb
              ? Image.network(_pickedImage!.path, fit: BoxFit.cover)
              : Image.file(File(_pickedImage!.path), fit: BoxFit.cover);
        }
    
        UserModel displayUser = widget.userModel;
        if (state is ProfileSuccess) {
          displayUser = state.userModel;
        } else if (state is UploadProfilePicSuccess) {
          displayUser = state.userModel;
        }
    
        if (displayUser.profilePic != null &&
            displayUser.profilePic!.isNotEmpty) {
          return CachedNetworkImage(
            imageUrl:
                '${displayUser.profilePic}?t=${DateTime.now().millisecondsSinceEpoch}',
            fit: BoxFit.cover,
            key: ValueKey(displayUser.profilePic),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            errorWidget: (context, url, error) => _buildDefaultIcon(),
          );
        }
    
        return _buildDefaultIcon();
      
    
  }

  Widget _buildDefaultIcon() {
    return FittedBox(
      child: SvgPicture.asset(
        AppIcons.iconsHomeProfileHeader,
        colorFilter: const ColorFilter.mode(
          AppColors.whiteLight,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
