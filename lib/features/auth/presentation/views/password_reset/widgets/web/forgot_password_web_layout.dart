import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
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
import 'package:sams_app/features/auth/presentation/views/widgets/auth_sider_image.dart';

class ForgotPasswordWebLayout extends StatefulWidget {
  const ForgotPasswordWebLayout({super.key});

  @override
  State<ForgotPasswordWebLayout> createState() =>
      _ForgotPasswordWebLayoutState();
}

class _ForgotPasswordWebLayoutState extends State<ForgotPasswordWebLayout> {
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
    final width = MediaQuery.of(context).size.width;
    cubit = context.read<PasswordResetCubit>();

    return Scaffold(
      body: Row(
        children: [
          width <= 830
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
                      //* header text
                      _buildHeaderSection(),

                      const SizedBox(height: 32),

                      //* email field
                      _buildEmailField(),

                      const SizedBox(height: 90),

                      //* next button
                      BlocBuilder<PasswordResetCubit, PasswordResetState>(
                        builder: (context, state) {
                          return _buildNextButton(state);
                        },
                      ),
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

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password',
          style: AppStyles.webTitleLargeMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'reset password?',
          style: AppStyles.web32Semibold.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Please enter your academic email\nto reset your password ',
          style: AppStyles.web24Regular.copyWith(
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

  Widget _buildNextButton(PasswordResetState state) {
    return (state.status == PasswordResetStatus.loading)
        ? const AppAnimatedLoadingIndicator()
        : AppButton(
            model: AppButtonStyleModel(
              label: 'Next Step',
              onPressed: () {
                _submitForm();
              },
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
