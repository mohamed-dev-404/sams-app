import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_info_card.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_pic_section.dart';

class ProfileMainLayoutBody extends StatelessWidget {
  const ProfileMainLayoutBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileSuccess) {
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
              Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  ProfilePicSection(
                    userModel: state.userModel,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  ProfileInfoCard(
                    userModel: state.userModel,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Expanded(
                    flex: 5,
                    child: SizedBox(width: double.infinity),
                  ),
                ],
              ),
            ],
          );
        } else if (state is ProfileFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.red),
                const SizedBox(height: 16),
                Text(state.errMessage),
                TextButton(
                  onPressed: () =>
                      context.read<ProfileCubit>().getUserProfile(),
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
      },
    );
  }
}
