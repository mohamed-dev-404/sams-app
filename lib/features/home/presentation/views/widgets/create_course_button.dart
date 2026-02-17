import 'package:flutter/material.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/app_button.dart';

class CreateCourseButton extends StatelessWidget {
  const CreateCourseButton({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppButton(
        model: AppButtonStyleModel(
          height: 55,
          width: 230,
          backgroundColor: AppColors.secondary,
          textColor: AppColors.whiteLight,
          label: 'Create Course',
          onPressed: () {
            // final bool isValid = formKey.currentState!.validate();
            // if (isValid) {
            //   // do something
            // }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
