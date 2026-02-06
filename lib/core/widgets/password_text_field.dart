import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/password_field_type.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/validators/app_validators.dart';
import 'package:sams_app/core/widgets/svg_icon.dart';
import 'package:sams_app/core/widgets/text_field_error_builder.dart';

/// A specialized [TextFormField] for password entry with built-in
/// visibility toggling and specific validation types.
class AppPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final PasswordFieldType passwordFieldType;

  /// The controller of the main password field, required only for
  /// [PasswordFieldType.confirmPassword] to perform matching.
  final TextEditingController? originalController;

  // Interaction properties for external control and focus management
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const AppPasswordField({
    super.key,
    required this.hintText,
    required this.passwordFieldType,
    this.controller,
    this.originalController,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
  }) : assert(
         passwordFieldType != PasswordFieldType.confirmPassword ||
             originalController != null,
         'originalController is required when using PasswordFieldType.confirmPassword',
       );

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  // Local state to track whether text is hidden (dots) or visible
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    /* LOGIC: Dynamic TextInputAction based on PasswordFieldType
       1. If the user passes a specific textInputAction, use it.
       2. If it's the 'originalPassword', default to .next (to move to confirmation).
       3. If it's 'confirmPassword', default to .done (to close keyboard).
    */
    final defaultInputAction =
        widget.textInputAction ??
        (widget.passwordFieldType == PasswordFieldType.originalPassword
            ? TextInputAction.next
            : TextInputAction.done);

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,

      // obscureText controls the masking of characters (true = dots)
      obscureText: !_isPasswordVisible,

      // Ensures the keyboard shows the standard password layout
      keyboardType: TextInputType.visiblePassword,

      // Use the calculated action (Next vs Done)
      textInputAction: defaultInputAction,

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle:
            (SizeConfig.isMobile(context)
                    ? AppStyles.mobileBodyXsmallRg
                    : AppStyles.mobileLabelMediumRg)
                .copyWith(
                  color: AppColors.whiteDarkHover,
                ),
        prefixIcon: const SvgIcon(AppIcons.iconsPasswordLock),

        // Eye toggle icon for showing/hiding password characters
        suffixIcon: IconButton(
          icon: _isPasswordVisible
              ? const SvgIcon(AppIcons.iconsOpenedEyeVisible)
              : const SvgIcon(AppIcons.iconsClosedEye),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),

      // Custom error builder
      errorBuilder: (context, errorMessage) {
        return TextFieldErrorBuilder(
          errorMessage: errorMessage,
        );
      },

      // Validation logic branched by the specific password enum type
      validator: (value) {
        switch (widget.passwordFieldType) {
          case PasswordFieldType.originalPassword:
            // Checks for length, casing, numbers, and symbols
            return AppValidators.validatePassword(value);

          case PasswordFieldType.confirmPassword:
            // Checks if current value matches 'originalController.text'
            return AppValidators.validateConfirmPassword(
              value,
              widget.originalController!.text,
            );
        }
      },
    );
  }
}
