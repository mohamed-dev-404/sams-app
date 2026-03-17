import 'package:flutter/material.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/basic_information_section.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';

class MobileManageMaterialViewBody extends StatelessWidget {
  const MobileManageMaterialViewBody({super.key, required this.isEditMode});
  final bool isEditMode;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomBasicInformationSection(
            sectionTitle: 'Basic Information',
            fields: [
              InputFieldData(
                label: 'Title',
                hint: 'e.g. Chapter 1',
                controller: TextEditingController(),
              ),
              InputFieldData(
                label: 'Subtitle',
                hint: 'e.g. A Comprehensive Overview',
                controller: TextEditingController(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const CourseMaterialSection(),
          const SizedBox(height: 32),
          CustomAppButton(
            width: 220,
            height: 50,
            borderRadius: 16,
            label: isEditMode ? 'Edit Material' : 'Add Material',
            onPressed: () {
              // Handle add/edit material action
            },
          ),
        ],
      ),
    );
  }
}
