import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/core/widgets/shared/titled_input_field.dart';

class MaterialBasicInfoSection extends StatelessWidget {
  const MaterialBasicInfoSection({
    super.key,
    required this.sectionTitle,
    required this.fields,
  });

  final String sectionTitle;
  final List<InputFieldData> fields;

  @override
  Widget build(BuildContext context) {
    return _buildFormSection(
      title: sectionTitle,
      children: fields
          .map(
            (field) => _buildInputFieldTile(
              label: field.label,
              hint: field.hint,
              textFieldType: field.type,
              controller: field.controller,
            ),
          )
          .toList(),
    );
  }
 Widget _buildFormSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteLight,
        border: Border.all(color: AppColors.secondary, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Section Title (e.g., Basic Info, Grade Distribution)
            Text(
              title,
              style: AppStyles.mobileBodyLargeSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
  Widget _buildInputFieldTile({
    required String label,
    required String hint,
    required TextFieldType textFieldType,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TitledInputField(
        spacing: 2,
        label: label,
        labelStyle: AppStyles.mobileTitleXsmallMd.copyWith(
          color: AppColors.primaryDark,
        ),
        child: AppTextField(
          controller: controller,
          hintText: hint,
          textFieldType: textFieldType,
        ),
      ),
    );
  }
}
