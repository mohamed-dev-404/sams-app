import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';

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