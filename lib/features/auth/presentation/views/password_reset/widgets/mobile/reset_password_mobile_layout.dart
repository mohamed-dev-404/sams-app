import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sams_app/core/enums/password_field_type.dart';
import 'package:sams_app/core/functions/hide_keyboard.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/app_button.dart';
import 'package:sams_app/core/widgets/password_text_field.dart';
import 'package:sams_app/core/widgets/titled_input_field.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/mobile_auth_header.dart';

class ResetPasswordMobileLayout extends StatefulWidget {
  const ResetPasswordMobileLayout({super.key});

  @override
  State<ResetPasswordMobileLayout> createState() =>
      _ResetPasswordMobileLayoutState();
}

class _ResetPasswordMobileLayoutState extends State<ResetPasswordMobileLayout> {
  late PasswordResetCubit cubit;

  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _confirmpassFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _confirmpassFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _confirmpassFocusNode.dispose();
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
                      _buildHeaderText(),

                      const Gap(32),

                      //* reset passwoed fields
                      _buildResetPassFields(),

                      const Gap(90),

                      //* submit button
                      BlocBuilder<PasswordResetCubit, PasswordResetState>(
                        builder: (context, state) {
                          return _buildSubmitButton(state, screenWidth);
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

  Widget _buildHeaderText() {
    return Text(
      'Reset Password',
      style: AppStyles.mobileTitleLargeMd.copyWith(
        color: AppColors.primaryDarkHover,
      ),
    );
  }

  Widget _buildResetPassFields() {
    return Column(
      spacing: 16,
      children: [
        TitledInputField(
          label: 'New Password',
          child: AppPasswordField(
            controller: _newPasswordController,
            hintText: 'enter new password',
            passwordFieldType: PasswordFieldType.originalPassword,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_confirmpassFocusNode),
          ),
        ),
        TitledInputField(
          label: 'Confirm new Password',
          child: AppPasswordField(
            controller: _confirmPasswordController,
            originalController: _newPasswordController,
            focusNode: _confirmpassFocusNode,
            hintText: 'confirm your new password',
            passwordFieldType: PasswordFieldType.confirmPassword,
            onFieldSubmitted: (_) {
              _submitForm();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(PasswordResetState state, double secreenWidth) {
    if (state.status == PasswordResetStatus.loading) {
      return const AppAnimatedLoadingIndicator();
    } else {
      return Align(
        alignment: Alignment.center,
        child: AppButton(
          model: AppButtonStyleModel(
            label: 'Change Password',
            width: secreenWidth * .6,
            onPressed: () {
              _submitForm();
            },
          ),
        ),
      );
    }
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.resetPassword(
        newPassword: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );
    }
  }
}
