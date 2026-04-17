import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/models/input_field_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/basic_information_section.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/web/web_home_header.dart';
import 'package:sams_app/features/materials/presentation/logic/manage_material_mixin.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/update_progress_overlay.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/uploading_overlay.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

/// The Web implementation for managing materials (Create/Edit).
/// Adapts the form layout for larger screens while sharing logic with mobile via [ManageMaterialMixin].
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
  void initState() {
    super.initState();
    //* Critical: Initialize text controllers and internal state.
    //? If in Edit Mode, this populates fields with existing material data.
    final initialMaterial = context.read<MaterialCrudCubit>().initialMaterial;
    initializeControllers(initialMaterial);
  }

  @override
  void dispose() {
    //? Mixin cleanup to avoid memory leaks from TextControllers.
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
          context.pop(state.material);
        } else if (state is CreateMaterialSuccess) {
          //* Return the newly created model so the parent list can update locally.
          AppSnackBar.success(context, state.message);
          context.pop(state.material);
        } else if (state is CreateMaterialFailure ||
            state is UpdateMaterialFailure) {
          //! Explicitly cast to dynamic to access errMessage safely if types differ.
          AppSnackBar.error(context, (state as dynamic).errMessage);
        }
      },
      builder: (context, state) {
        //* Decouple various loading states to manage UI blocking and overlays.
        final isCreateLoading = state is CreateMaterialLoading;
        final isCreateUploading = isCreateLoading && state.isUploadingFiles;
        final isUpdateLoading = state is UpdateMaterialLoading;
        final anyLoading = isCreateLoading || isUpdateLoading;

        String updateMsg = '';
        if (state is UpdateMaterialLoading) {
          updateMsg = state.message;
        }

        return Stack(
          children: [
            //* Interactive UI Layer.
            //! Disable all clicks and dim the screen during active uploads/updates.
            IgnorePointer(
              ignoring: isCreateUploading || isUpdateLoading,
              child: Opacity(
                opacity: (isCreateUploading || isUpdateLoading) ? 0.3 : 1.0,
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
                            //* Submission logic: Only show the button if no background task is running.
                            if (!anyLoading) _buildSubmitButton(anyLoading),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //* Feedback Overlays: Appear globally within the Stack during processing.
            if (isCreateUploading) const UploadingOverlay(),
            if (isUpdateLoading) UpdateProgressOverlay(message: updateMsg),
          ],
        );
      },
    );
  }

  /// Renders the page title based on the current mode (Add vs Edit).
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

  /// Organizes the input form and material file section in a side-by-side [Row].
  Widget _buildFormContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Form(
            key: formKey, //? Mixed in from ManageMaterialMixin.
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
          child: CourseMaterialSection(
            key: materialSectionKey,
            //* Provides existing items to the file picker widget for editing.
            initialItems: context
                .read<MaterialCrudCubit>()
                .initialMaterial
                ?.materialItems,
          ),
        ),
      ],
    );
  }

  /// The main action button that triggers form validation and API calls.
  Widget _buildSubmitButton(bool isLoading) {
    return CustomAppButton(
      width: 220,
      height: 50,
      borderRadius: 16,
      label: widget.isEditMode ? 'Edit Material' : 'Add Material',
      onPressed: isLoading
          ? null
          //* Triggers centralized logic in the Mixin to handle file uploads and data mapping.
          : () => onManageMaterialPressed(
              context: context,
              courseId: widget.courseId,
              isEditMode: widget.isEditMode,
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
