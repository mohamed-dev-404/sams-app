import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/features/home/presentation/views/widgets/create_course_form_section.dart';
import 'package:sams_app/features/home/presentation/views/widgets/input_field_title.dart';

class BasicInformationSection extends StatelessWidget {
  const BasicInformationSection({
    super.key,
    required this.totalController,
    required this.finalController,
    required this.courseNameController,
    required this.courseCodeController,
  });

  final TextEditingController totalController;
  final TextEditingController finalController;
  final TextEditingController courseNameController;
  final TextEditingController courseCodeController;

  @override
  Widget build(BuildContext context) {
    return CreatecourseFormSection(
      title: 'Basic Information',
      children: [
        InputFieldTile(
          label: 'Course Name',
          hint: 'e.g. Web Development',
          textFieldType: TextFieldType.normal,
          controller: courseNameController,
        ),
        InputFieldTile(
          label: 'Course Code',
          hint: 'e.g. CS101',
          textFieldType: TextFieldType.normal,
          controller: courseCodeController,
        ),
        InputFieldTile(
          label: 'Total Grade',
          hint: 'e.g. 100',
          textFieldType: TextFieldType.numerical,
          controller: totalController,
        ),

        InputFieldTile(
          label: 'Final Exam',
          hint: 'e.g. 60',
          textFieldType: TextFieldType.numerical,
          controller: finalController,
        ),
      ],
    );
  }
}
