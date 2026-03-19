import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/basic_information_section.dart';
import 'package:sams_app/features/materials/presentation/logic/manage_material_mixin.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/uploading_overlay.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

class MobileManageMaterialViewBody extends StatefulWidget {
  const MobileManageMaterialViewBody({
    super.key,
    required this.isEditMode,
    required this.courseId,
  });

  final bool isEditMode;
  final String courseId;

  @override
  State<MobileManageMaterialViewBody> createState() =>
      _MobileManageMaterialViewBodyState();
}

class _MobileManageMaterialViewBodyState
    extends State<MobileManageMaterialViewBody>
    with ManageMaterialMixin {
  @override


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialCrudCubit, MaterialCrudState>(
      listener: (context, state) {},
      builder: (context, state) {
        final isLoading = state is MaterialCrudLoading;
        final isUploading = isLoading && state.isUploadingFiles;

        return Stack(
          children: [
            IgnorePointer(
              ignoring: isUploading,
              child: Opacity(
                opacity: isUploading ? 0.3 : 1.0,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildFormSection(),
                      const SizedBox(height: 16),
                      CourseMaterialSection(key: materialSectionKey),
                      const SizedBox(height: 32),
                      if (!isUploading) _buildActionButton(isLoading),
                    ],
                  ),
                ),
              ),
            ),

            if (isUploading) const UploadingOverlay(),
          ],
        );
      },
    );
  }

  Widget _buildFormSection() {
    return Form(
      key: formKey,
      child: CustomBasicInformationSection(
        sectionTitle: 'Basic Information',
        fields: [
          InputFieldData(
            label: 'Title',
            hint: 'e.g. Ch 1',
            controller: titleController,
          ),
          InputFieldData(
            label: 'Subtitle',
            hint: 'e.g. Overview',
            controller: subtitleController,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(bool isLoading) {
    return CustomAppButton(
      width: 220,
      height: 50,
      borderRadius: 16,
      label: widget.isEditMode ? 'Edit Material' : 'Add Material',
      onPressed: isLoading
          ? null
          : () => onAddMaterialPressed(
              context: context,
              courseId: widget.courseId,
            ),
      child: isLoading
          ? const CircularProgressIndicator(
              color: AppColors.whiteLight,
              strokeWidth: 2,
            )
          : null,
    );
  }
}
