import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/core/widgets/custom_app_button.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_state.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/widgets/mobile/sign_up_mobile_layout.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/widgets/web/sign_up_web_layout.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.failure) {
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'unexpected error, please try again later.',
          );
        } else if (state.status == SignUpStatus.codeSent) {
        showDialog(
          context: context,
          builder: (context) => RegisterSuccessDialog(
            title: 'Registration successful!',
            message: state.codeSentMessage ??
                'Please check your email to activate your account.',
            onButtonPressed: () {
              context.pop();
              context.push(RoutesName.activateAccount);
            },
          ),
        );
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const SignUpMobileLayout(),
          webLayout: (context) => const SignUpWebLayout(),
        );
      },
    );
  }
}




class RegisterSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onButtonPressed;

  const RegisterSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onButtonPressed,
    this.buttonLabel = 'Verify OTP',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), 
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              SvgPicture.asset(
                AppImages.imagesSuccessDialog,
                height: 120, 
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: AppStyles.mobileBodyLargeSb.copyWith(
                  color: AppColors.primaryDarkHover,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomAppButton(
                  label: buttonLabel,
                  onPressed: onButtonPressed,
                  textColor: AppColors.whiteLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}