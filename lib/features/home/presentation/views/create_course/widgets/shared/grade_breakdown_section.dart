import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/features/home/presentation/logic/mixin_create_course.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/create_course_form_section.dart';

//* Dynamic section for defining how classwork grades are distributed
class GradeBreakdownSection extends StatelessWidget {
  final List<Map<String, dynamic>> fields;
  final double remaining;
  final double limit;
  final GradeStatus status;
  final double totalInput;
  final double finalInput;
  final VoidCallback onAddField;
  final Function(int) onRemoveField;

  const GradeBreakdownSection({
    super.key,
    required this.fields,
    required this.remaining,
    required this.limit,
    required this.status,
    required this.onAddField,
    required this.onRemoveField,
    required this.totalInput,
    required this.finalInput,
  });

  @override
  Widget build(BuildContext context) {
    return CreatecourseFormSection(
      title: 'Classwork Grade Breakdown',
      children: [
        //? Visual indicator of how many points are left to assign
        _totalClasswork(
          remaining: remaining,
          limit: limit,
          status: status,
          totalInput: totalInput,
          finalInput: finalInput,
        ),

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
                      //! Remove field button
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
                    //* Label and grade
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
        //? Add field button
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

  //* Visual indicator of how many points are left to assign
  Widget _totalClasswork({
    required double remaining,
    required double limit,
    required GradeStatus status,
    required double totalInput,
    required double finalInput,
  }) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    String message;

    // Check if data is missing or if the final exam takes the full grade
    final bool isMissingData = totalInput <= 0 || finalInput <= 0;
    final bool isFinalEatsAll =
        !isMissingData && totalInput == finalInput && limit <= 0;

    switch (status) {
      case GradeStatus.remaining:
        if (isMissingData) {
          // Initial state: User hasn't provided core grade info yet
          backgroundColor = StatusColors.grey.withAlpha(20);
          borderColor = StatusColors.grey;
          textColor = StatusColors.grey;
          message = 'Enter Total & Final Grade first ○';
        } else if (isFinalEatsAll) {
          // Warning state: Total equals Final, leaving no room for classwork
          backgroundColor = StatusColors.orange.withAlpha(20);
          borderColor = StatusColors.orange;
          textColor = StatusColors.orange;
          message = 'Final Exam covers all grades ⚠';
        } else {
          // Active state: Core info provided, points need to be assigned
          backgroundColor = AppColors.secondaryLight;
          borderColor = StatusColors.orange;
          textColor = AppColors.whiteDarkHover;
          message = 'Assign ${remaining.toStringAsFixed(0)} more points ○';
        }
        break;

      case GradeStatus.done:
        // Success state: Distribution is 100% correct
        backgroundColor = Colors.green.withAlpha(20);
        borderColor = Colors.green;
        textColor = Colors.green;
        message = 'All Points Distributed ✓';
        break;

      case GradeStatus.exceeded:
        // Error state: Classwork points exceeded the allowed limit
        backgroundColor = AppColors.redLight;
        borderColor = Colors.red;
        textColor = Colors.red;
        message = 'Exceeded by ${remaining.abs().toStringAsFixed(0)} points ✕';
        break;
    }

    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50,
        width: 270,
        margin: const EdgeInsets.only(bottom: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Text(
          message,
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
