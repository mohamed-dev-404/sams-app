import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/password_field_type.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/functions/hide_keyboard.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/app_button.dart';
import 'package:sams_app/core/widgets/app_text_field.dart';
import 'package:sams_app/core/widgets/password_text_field.dart';
import 'package:sams_app/core/widgets/svg_icon.dart';
import 'package:sams_app/core/widgets/titled_input_field.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_state.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/mobile_auth_header.dart';

class LoginMobileLayout extends StatefulWidget {
  const LoginMobileLayout({super.key});

  @override
  State<LoginMobileLayout> createState() => _LoginMobileLayoutState();
}

class _LoginMobileLayoutState extends State<LoginMobileLayout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // FocusNodes to manage the keyboard "Next" flow
  final FocusNode _passFocusNode = FocusNode();

  //login cubit
  late LoginCubit cubit;

  @override
  void dispose() {
    // Cleanup to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    cubit = context.read<LoginCubit>();

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
                    children: [
                      //* header text
                      _buildHeaderText(),

                      const Gap(32),

                      //* email and password field
                      _buildFields(),

                      const Gap(16),

                      //* forget password text button
                      _buildForgetPassButton(),

                      const Gap(32),

                      //* buttons
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const AppAnimatedLoadingIndicator();
                          }
                          return _buildButtons(screenWidth);
                        },
                      ),

                      const Gap(50),
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
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Text(
        'Log In',
        style: AppStyles.mobileTitleLargeMd.copyWith(
          color: AppColors.primaryDarkHover,
        ),
      ),
    );
  }

  Widget _buildForgetPassButton() {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: GestureDetector(
        onTap: () {
          context.push(RoutesName.forgotPassword);
        },
        child: Text(
          'Forgot Password?',
          style: AppStyles.mobileBodySmallMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
      ),
    );
  }

  Widget _buildFields() {
    return Column(
      children: [
        TitledInputField(
          label: 'Academic Email',
          child: AppTextField(
            controller: _emailController,
            prefixIcon: const SvgIcon(
              AppIcons.iconsProfileEmail,
            ),
            hintText: '2022202020@o6u.edu.eg',
            textFieldType: TextFieldType.academicEmail,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_passFocusNode),
          ),
        ),
        const Gap(24),
        TitledInputField(
          label: 'Password',
          child: AppPasswordField(
            controller: _passwordController,
            focusNode: _passFocusNode,
            hintText: 'password',
            passwordFieldType: PasswordFieldType.originalPassword,
            onFieldSubmitted: (_) {
              _submitForm();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(double screenWidth) {
    return Column(
      children: [
        AppButton(
          model: AppButtonStyleModel(
            label: 'Log In',
            width: screenWidth * .56,
            onPressed: () {
              _submitForm();
            },
          ),
        ),
        const Gap(16),
        AppButton(
          model: AppButtonStyleModel(
            label: 'Sign Up',
            width: screenWidth * .56,
            textColor: AppColors.primaryDark,
            backgroundColor: AppColors.secondaryLight,
            onPressed: () {
              context.go(RoutesName.signUp);
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }
}
