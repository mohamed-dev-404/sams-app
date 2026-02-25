import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/functions/hide_keyboard.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/app_button.dart';
import 'package:sams_app/core/widgets/app_text_field.dart';
import 'package:sams_app/core/widgets/svg_icon.dart';
import 'package:sams_app/core/widgets/titled_input_field.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/mobile_auth_header.dart';

class ForgotPasswordMobileLayout extends StatefulWidget {
  const ForgotPasswordMobileLayout({super.key});

  @override
  State<ForgotPasswordMobileLayout> createState() =>
      _ForgotPasswordMobileLayoutState();
}

class _ForgotPasswordMobileLayoutState
    extends State<ForgotPasswordMobileLayout> {
  late PasswordResetCubit cubit;

  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    cubit = context.read<PasswordResetCubit>();

    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 20,
              children: [
                //* header image
                const MobileAuthHeader(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* header text
                      _buildHeaderSection(),

                      const Gap(32),

                      //* email field
                      _buildEmailField(),

                      const Gap(90),

                      //* next button
                      BlocBuilder<PasswordResetCubit, PasswordResetState>(
                        builder: (context, state) {
                          return _buildNextButton(screenWidth, state);
                        },
                      ),

                      const Gap(30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password',
          style: AppStyles.mobileTitleLargeMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'reset password?',
          style: AppStyles.mobileBodySmallSb.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Please enter your academic email\nto reset your password ',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TitledInputField(
      label: 'Academic Email',
      child: AppTextField(
        controller: _emailController,
        prefixIcon: const SvgIcon(
          AppIcons.iconsProfileEmail,
        ),
        hintText: '202220202@o6u.edu.eg',
        textFieldType: TextFieldType.academicEmail,
        onFieldSubmitted: (_) {
          _submitForm();
        },
      ),
    );
  }

  Widget _buildNextButton(double screenWidth, PasswordResetState state) {
    return Align(
      alignment: Alignment.center,
      child: state.status == PasswordResetStatus.loading
          ? const AppAnimatedLoadingIndicator()
          : AppButton(
              model: AppButtonStyleModel(
                label: 'Next Step',
                width: screenWidth * .56,
                onPressed: () {
                  _submitForm();
                },
              ),
            ),
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.sendResetCode(email: _emailController.text.trim());
    }
  }
}
