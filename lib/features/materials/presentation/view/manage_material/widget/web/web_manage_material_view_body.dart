import 'package:flutter/material.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/basic_information_section.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/web/web_home_header.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';

class WebManageMaterialViewBody extends StatelessWidget {
  const WebManageMaterialViewBody({super.key, required this.isEditMode});
  final bool isEditMode;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WebHomeHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                Text(
                  isEditMode ? 'Edit Material' : 'Add Material',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006064),
                  ),
                ),
                const SizedBox(height: 40),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CustomBasicInformationSection(
                          sectionTitle: 'Basic Information',
                          fields: [
                            InputFieldData(
                              label: 'Title',
                              hint: 'e.g. Chapter 1',
                              controller: TextEditingController(),
                            ),
                            InputFieldData(
                              label: 'Subtitle',
                              hint: 'e.g. Overview',
                              controller: TextEditingController(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(
                        child: CourseMaterialSection(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                CustomAppButton(
                  width: 220,
                  height: 50,
                  borderRadius: 16,
                  label: isEditMode ? 'Edit Material' : 'Add Material',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
