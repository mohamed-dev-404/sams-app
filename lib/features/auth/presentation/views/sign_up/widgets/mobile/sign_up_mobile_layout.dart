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
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_state.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/mobile_auth_header.dart';

class SignUpMobileLayout extends StatefulWidget {
  const SignUpMobileLayout({super.key});

  @override
  State<SignUpMobileLayout> createState() => _SignUpMobileLayoutState();
}

class _SignUpMobileLayoutState extends State<SignUpMobileLayout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for the form
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPassController;

  // FocusNodes to manage the keyboard "Next" flow
  late final FocusNode _emailFocusNode;
  late final FocusNode _idFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPassFocusNode;

  //login cubit
  late SignUpCubit cubit;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _confirmPassController = TextEditingController();
    _passwordController = TextEditingController();
    _idController = TextEditingController();

    _emailFocusNode = FocusNode();
    _idFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPassFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();

    _emailFocusNode.dispose();
    _idFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    cubit = context.read<SignUpCubit>();

    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 8,
              children: [
                //* header image
                const MobileAuthHeader(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      //* header text
                      _buildHeaderText(),

                      const Gap(16),

                      //* form field
                      _buildSignUpFormFields(),

                      const Gap(32),

                      //* button
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          if (state.status == SignUpStatus.loading) {
                            return const AppAnimatedLoadingIndicator();
                          }
                          return _buildSignUpButton(screenWidth);
                        },
                      ),
                      const Gap(16),

                      //* build already have button row
                      _buildAlreadyHaveAccountRow(),

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
        'Create Account',
        style: AppStyles.mobileTitleLargeMd.copyWith(
          color: AppColors.primaryDarkHover,
        ),
      ),
    );
  }

  Widget _buildAlreadyHaveAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already Have An Account? ',
          style: AppStyles.web16Medium.copyWith(
            color: AppColors.primaryDarker,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.go(RoutesName.login);
          },
          child: Text(
            'Log In',
            style: AppStyles.web16Medium.copyWith(
              color: AppColors.secondaryDarkHover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpFormFields() {
    return Column(
      children: [
        TitledInputField(
          label: 'Full Name',
          child: AppTextField(
            controller: _nameController,
            prefixIcon: const SvgIcon(
              AppIcons.iconsAuthName,
            ),
            hintText: 'John Doe',
            textFieldType: TextFieldType.alphabetical,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_emailFocusNode),
          ),
        ),
        const Gap(12),
        TitledInputField(
          label: 'Academic Email',
          child: AppTextField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            prefixIcon: const SvgIcon(
              AppIcons.iconsProfileEmail,
            ),
            hintText: '2022202020@o6u.edu.eg',
            textFieldType: TextFieldType.academicEmail,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_idFocusNode),
          ),
        ),
        const Gap(12),
        TitledInputField(
          label: 'Academic ID',
          child: AppTextField(
            controller: _idController,
            focusNode: _idFocusNode,
            prefixIcon: const SvgIcon(
              AppIcons.iconsProfileId,
            ),
            hintText: '2022202020',
            textFieldType: TextFieldType.numerical,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_passwordFocusNode),
          ),
        ),
        const Gap(12),
        TitledInputField(
          label: 'Password',
          child: AppPasswordField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            hintText: 'password',
            passwordFieldType: PasswordFieldType.originalPassword,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_confirmPassFocusNode),
          ),
        ),
        const Gap(12),
        TitledInputField(
          label: 'Confirm Password',
          child: AppPasswordField(
            controller: _confirmPassController,
            originalController: _passwordController,
            focusNode: _confirmPassFocusNode,
            hintText: 'confirm password',
            passwordFieldType: PasswordFieldType.confirmPassword,
            onFieldSubmitted: (_) {
              _submitForm();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(double screenWidth) {
    return AppButton(
      model: AppButtonStyleModel(
        label: 'Sign Up',
        width: screenWidth * .56,
        onPressed: () {
          _submitForm();
        },
      ),
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.register(
        fullName: _nameController.text.trim(),
        id: _idController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPassController.text.trim(),
      );
    }
  }
}
