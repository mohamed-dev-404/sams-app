import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/functions/mask_email.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/app_button.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_state.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/auth_sider_image.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/custom_pinput_field.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/otp_timer.dart';

class ActivateAccountWebLayout extends StatefulWidget {
  const ActivateAccountWebLayout({super.key});

  @override
  State<ActivateAccountWebLayout> createState() =>
      _ActivateAccountWebLayoutState();
}

class _ActivateAccountWebLayoutState extends State<ActivateAccountWebLayout> {
  late SignUpCubit cubit;

  late final TextEditingController _otpController;
  final _formKey = GlobalKey<FormState>();

  int _timerKey = 0; // Increment this to restart the timer
  bool _canResend = false;

  final ValueNotifier<bool> _isOtpValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    cubit = context.read<SignUpCubit>();

    final maskedEmail = maskEmail(cubit.state.email ?? '');

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.codeResent) {
          setState(() {
            _canResend = false;
            _timerKey++; // This forces the OtpTimer to restart
          });
          AppSnackBar.success(
            context,
            'Code successfully resent! Please check your inbox and spam folder.',
            duration: const Duration(seconds: 4),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              if (screenWidth > 980) const AuthSiderImage(),

              const SizedBox(width: 16),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 780),

                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 32.0),
                          child: Column(
                            children: [
                              _buildHeaderSection(maskedEmail),

                              const SizedBox(height: 32),

                              _buildOtpField(),

                              const SizedBox(height: 32),

                              _buildResendRow(),

                              const SizedBox(height: 90),

                              (state.status == SignUpStatus.loading)
                                  ? const AppAnimatedLoadingIndicator()
                                  : _buildSubmitButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Activate Account',
          style: AppStyles.webTitleLargeMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'We sent an OTP to ',
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
              TextSpan(
                text: email,
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField() {
    return CustomPinputField(
      controller: _otpController,
      onValidationChanged: (isValid) {
        setState(() {
          _isOtpValid.value = isValid; // Only rebuilds the listener
        });
      },
    );
  }

  Widget _buildResendRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Didn’t get a code? ',
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: _canResend ? _handleResend : null,
                  child: Text(
                    'Resend',
                    style: AppStyles.mobileBodyMediumRg.copyWith(
                      color: _canResend ? AppColors.primaryDark : Colors.grey,
                      fontWeight: FontWeight.w600,
                      decoration: _canResend
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Adding a Key makes the timer restart when _timerKey changes
        OtpTimer(
          key: ValueKey(_timerKey),
          durationInSeconds: 60,
          onTimerFinished: () => setState(() => _canResend = true),
        ),
      ],
    );
  }

  void _handleResend() {
    cubit.resendCode();
  }

  Widget _buildSubmitButton() {
    // ValueListenableBuilder prevents the whole page from rebuilding
    return ValueListenableBuilder<bool>(
      valueListenable: _isOtpValid,
      builder: (context, isValid, child) {
        return AppButton(
          model: AppButtonStyleModel(
            label: 'Continue',
            onPressed: isValid
                ? () {
                    // Trigger Cubit with _otpController.text
                    _submitForm();
                  }
                : null,
          ),
        );
      },
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.verifyAccount(otp: _otpController.text.trim());
    }
  }
}
