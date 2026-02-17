import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_button.dart';
import 'package:sams_app/core/widgets/app_text_field.dart';

class EnrollCourseDialog extends StatefulWidget {
  const EnrollCourseDialog({super.key});

  @override
  State<EnrollCourseDialog> createState() => _EnrollCourseDialogState();
}

class _EnrollCourseDialogState extends State<EnrollCourseDialog> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      actionsPadding: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Center(
        child: Text('Enter Course Code'),
      ),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            prefixIcon: const Icon(Icons.fact_check),
            hintText: 'D3dfx5',
            textFieldType: TextFieldType.normal,
            controller: textEditingController,
          ),
          const SizedBox(height: 16),
          Text(
            '''to sign in with a course code
• Use an authorised account
• Use a class code with 5–8 letters or numbers, and no spaces or symbols
''',
            style: AppStyles.mobileBodyMediumRg.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: AppButton(
            model: AppButtonStyleModel(
              height: 55,
              width: 200,
              textColor: AppColors.whiteLight,
              label: 'Join Course',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
