import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/basic_information_section.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/web/web_home_header.dart';
import 'package:sams_app/features/materials/presentation/logic/manage_material_mixin.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/uploading_overlay.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

class WebManageMaterialViewBody extends StatefulWidget {
  const WebManageMaterialViewBody({
    super.key,
    required this.isEditMode,
    required this.courseId,
  });

  final bool isEditMode;
  final String courseId;

  @override
  State<WebManageMaterialViewBody> createState() =>
      _WebManageMaterialViewBodyState();
}

class _WebManageMaterialViewBodyState extends State<WebManageMaterialViewBody>
    with ManageMaterialMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialCrudCubit, MaterialCrudState>(
      listener: (context, state) {
        if (state is MaterialCrudSuccess) {
          AppSnackBar.success(context, state.message);
          Navigator.of(context).pop(state.material);
        } else if (state is MaterialCrudFailure) {
          AppSnackBar.error(context, state.errMessage);
        }
      },
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
                  child: Column(
                    children: [
                      const WebHomeHeader(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 40,
                        ),
                        child: Column(
                          children: [
                            _buildHeaderTitle(),
                            const SizedBox(height: 40),
                            _buildFormContent(),
                            const SizedBox(height: 50),
                            if (!isUploading) _buildSubmitButton(isLoading),
                          ],
                        ),
                      ),
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

  Widget _buildHeaderTitle() {
    return Text(
      widget.isEditMode ? 'Edit Material' : 'Add Material',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildFormContent() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: CustomBasicInformationSection(
                sectionTitle: 'Basic Information',
                fields: [
                  InputFieldData(
                    label: 'Title',
                    hint: 'e.g. Chapter 1',
                    controller: titleController,
                  ),
                  InputFieldData(
                    label: 'Subtitle',
                    hint: 'e.g. Overview',
                    controller: subtitleController,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: CourseMaterialSection(key: materialSectionKey),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
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
              color: Colors.white,
              strokeWidth: 2,
            )
          : null,
    );
  }
}
