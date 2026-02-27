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
              content: Text('the image uploaded successfully ✓ '),
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
                  Expanded(
                    flex: 5,
                    child: ProfilePicSection(
                      userModel: state.userModel,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 12,
                    child: ProfileInfoCard(
                      userModel: state.userModel,
                    ),
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
        }
        if (state is ProfileFailure) {
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
        }
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.whiteLight,
          ),
        );
      },
    );
  }
}
