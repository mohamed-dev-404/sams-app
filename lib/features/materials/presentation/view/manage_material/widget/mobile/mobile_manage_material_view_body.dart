import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/basic_information_section.dart';
import 'package:sams_app/features/materials/presentation/logic/manage_material_mixin.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/update_progress_overlay.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/uploading_overlay.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

/// A stateful widget that provides the interface for creating or editing course materials.
/// It utilizes [ManageMaterialMixin] to handle form controllers and validation logic.
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
  void initState() {
    super.initState();
    //* Extract initial data from Cubit if in Edit Mode to pre-fill the form.
    final initialMaterial = context.read<MaterialCrudCubit>().initialMaterial;
    initializeControllers(initialMaterial);
  }

  @override
  void dispose() {
    //! Clean up controllers via mixin to prevent memory leaks.
    disposeManageMaterial();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialCrudCubit, MaterialCrudState>(
      listenWhen: (previous, current) =>
          current is UpdateMaterialSuccess ||
          current is CreateMaterialSuccess ||
          current is CreateMaterialFailure ||
          current is UpdateMaterialFailure,
      listener: (context, state) {
        if (state is UpdateMaterialSuccess) {
          AppSnackBar.success(context, state.message);
          //* Return the updated material object to the previous screen.
          context.pop(state.material);
        } else if (state is CreateMaterialSuccess) {
          AppSnackBar.success(context, state.message);
          context.pop(state.material);
        } else if (state is CreateMaterialFailure) {
          AppSnackBar.error(context, state.errMessage);
        }
      },
      builder: (context, state) {
        //* Determine UI state based on specific loading sub-types.
        final isCreateLoading = state is CreateMaterialLoading;
        final isCreateUploading = isCreateLoading && state.isUploadingFiles;
        final isUpdateLoading = state is UpdateMaterialLoading;
        final anyLoading = isCreateLoading || isUpdateLoading;

        //? Extract dynamic message for the update overlay if applicable.
        String updateMsg = '';
        if (state is UpdateMaterialLoading) {
          updateMsg = state.message;
        }

        return Stack(
          children: [
            //* Main UI Layer.
            //! Interaction is disabled and opacity reduced during blocking operations (uploads/updates).
            IgnorePointer(
              ignoring: isCreateUploading || isUpdateLoading,
              child: Opacity(
                opacity: (isCreateUploading || isUpdateLoading) ? 0.3 : 1.0,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildFormSection(),
                      const SizedBox(height: 16),
                      CourseMaterialSection(
                        key: materialSectionKey,
                        initialItems: context
                            .read<MaterialCrudCubit>()
                            .initialMaterial
                            ?.materialItems,
                      ),
                      const SizedBox(height: 32),
                      //* Prevent submission if any asynchronous operation is in progress.
                      if (!anyLoading) _buildActionButton(anyLoading),
                    ],
                  ),
                ),
              ),
            ),

            //* Overlay Layer: Displayed on top of the form during long-running tasks.
            if (isCreateUploading) const UploadingOverlay(),
            if (isUpdateLoading) UpdateProgressOverlay(message: updateMsg),
          ],
        );
      },
    );
  }

  /// Constructs the text input fields for title and description using the provided mixin controllers.
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
            label: 'Description',
            hint: 'e.g. Overview',
            controller: descriptionController,
          ),
        ],
      ),
    );
  }

  /// Constructs the primary action button for submission.
  /// Disables itself and shows a loading indicator when [isLoading] is true.
  Widget _buildActionButton(bool isLoading) {
    return CustomAppButton(
      width: 220,
      height: 50,
      borderRadius: 16,
      label: widget.isEditMode ? 'Edit Material' : 'Add Material',
      onPressed: isLoading
          ? null
          //* Triggers the validation and submission logic defined in the mixin.
          : () => onManageMaterialPressed(
              context: context,
              courseId: widget.courseId,
              isEditMode: widget.isEditMode,
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
