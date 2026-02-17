import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_text_field.dart';
import 'package:sams_app/features/home/presentation/views/widgets/create_course_form_section.dart';

class GradeBreakdownSection extends StatelessWidget {
  final List<Map<String, dynamic>> fields;
  final double remaining;
  final double limit;
  final VoidCallback onAddField;
  final Function(int) onRemoveField;

  const GradeBreakdownSection({
    super.key,
    required this.fields,
    required this.remaining,
    required this.limit,
    required this.onAddField,
    required this.onRemoveField,
  });

  @override
  Widget build(BuildContext context) {
    return CreatecourseFormSection(
      title: 'Classwork Grade Breakdown',
      children: [
        _totalClasswork(remaining, limit),

        ...List.generate(fields.length, (index) {
          final field = fields[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.whiteLight,
                border: Border.all(color: AppColors.secondary, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),

                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColors.redLight,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            onPressed: () => onRemoveField(index),
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppColors.red,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AppTextField(
                      controller: field['nameController'],
                      hintText: 'Label',
                      textFieldType: TextFieldType.normal,
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: field['gradeController'],
                      hintText: 'Grade',
                      textFieldType: TextFieldType.numerical,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: onAddField,
            child: const Center(
              child: Icon(
                Icons.add_circle,
                color: AppColors.secondary,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _totalClasswork(double remaining, double limit) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 50,
        width: 200,
        margin: const EdgeInsets.only(bottom: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.secondaryLight,
          border: Border.all(
            color: AppColors.greenLightActive,
            width: 1,
          ),
        ),
        child: Text(
          'Remaining: ${remaining.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)}',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: remaining < 0 ? Colors.red : AppColors.whiteDarkHover,
          ),
        ),
      ),
    );
  }
}
