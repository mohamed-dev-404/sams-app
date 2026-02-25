import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/password_field_type.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
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
import 'package:sams_app/features/auth/presentation/views/widgets/auth_sider_image.dart';

class SignUpWebLayout extends StatefulWidget {
  const SignUpWebLayout({super.key});

  @override
  State<SignUpWebLayout> createState() => _SignUpWebLayoutState();
}

class _SignUpWebLayoutState extends State<SignUpWebLayout> {
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
    final width = MediaQuery.of(context).size.width;
    cubit = context.read<SignUpCubit>();

    return Scaffold(
      body: Row(
        children: [
          width <= 980
              ? const SizedBox(
                  height: double.infinity,
                )
              : const AuthSiderImage(),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(24),

                      //* header text
                      _buildHeaderText(),

                      const Gap(32),

                      //* form fields
                      _buildNameAndEmailFields(),
                      const Gap(16),
                      _buildIdAndPasswordFields(),
                      const Gap(16),
                      _buildConfirmPasswordField(),

                      const Gap(90),

                      //* sign up button
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          if (state.status == SignUpStatus.loading) {
                            return const AppAnimatedLoadingIndicator();
                          }
                          return _buildSignUpButton();
                        },
                      ),

                      const Gap(24),

                      //* build already have button row
                      _buildAlreadyHaveAccountRow(),

                      const Gap(50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Text(
        'Create Account',
        style: AppStyles.webTitleLargeMd.copyWith(
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
          style: AppStyles.web20Regular.copyWith(
            color: AppColors.primaryDarker,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.go(RoutesName.login);
          },
          child: Text(
            'Log In',
            style: AppStyles.web20Regular.copyWith(
              color: AppColors.secondaryDarkHover,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndEmailFields() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TitledInputField(
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
          ),
          const Gap(8),
          Expanded(
            child: TitledInputField(
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
          ),
        ],
      ),
    );
  }

  Widget _buildIdAndPasswordFields() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TitledInputField(
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
          ),
          const Gap(8),
          Expanded(
            child: TitledInputField(
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
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TitledInputField(
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
    );
  }

  Widget _buildSignUpButton() {
    return AppButton(
      model: AppButtonStyleModel(
        label: 'Sign Up',
        onPressed: () {
          _submitForm();
        },
      ),
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
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
}
