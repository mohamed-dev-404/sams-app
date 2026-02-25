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
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_state.dart';
import 'package:sams_app/features/auth/presentation/views/widgets/auth_sider_image.dart';

class LoginWebLayout extends StatefulWidget {
  const LoginWebLayout({super.key});

  @override
  State<LoginWebLayout> createState() => _LoginWebLayoutState();
}

class _LoginWebLayoutState extends State<LoginWebLayout> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _passFocusNode;
  final _formKey = GlobalKey<FormState>();
  late LoginCubit cubit;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    cubit = context.read<LoginCubit>();

    return Scaffold(
      body: Row(
        children: [
          screenWidth <= 830
              ? const SizedBox(
                  height: double.infinity,
                )
              : const AuthSiderImage(),
          const SizedBox(
            width: 42,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderText(),

                      const Gap(32),

                      _buildEmailField(),

                      const Gap(16),

                      _buildPasswordField(),

                      const Gap(16),

                      _buildForgetPassButton(),

                      const Gap(90),

                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const AppAnimatedLoadingIndicator();
                          }
                          return _buildButtons();
                        },
                      ),
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
    return Text(
      'Log In',
      style: AppStyles.webTitleLargeMd.copyWith(
        color: AppColors.primaryDarkHover,
      ),
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
        hintText: '2022202020@o6u.edu.eg',
        textFieldType: TextFieldType.academicEmail,
        onFieldSubmitted: (_) => FocusScope.of(
          context,
        ).requestFocus(_passFocusNode),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TitledInputField(
      label: 'Password',
      child: AppPasswordField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: 'Enter your password',
        passwordFieldType: PasswordFieldType.originalPassword,
        onFieldSubmitted: (_) {
          _submitForm();
        },
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
          style: AppStyles.mobileTitleSmallSb.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            model: AppButtonStyleModel(
              label: 'Log In',
              onPressed: () {
                _submitForm();
              },
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: AppButton(
            model: AppButtonStyleModel(
              label: 'Sign Up',
              onPressed: () {
                context.go(RoutesName.signUp);
              },
              textColor: AppColors.primaryDark,
              backgroundColor: AppColors.secondaryLight,
            ),
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
