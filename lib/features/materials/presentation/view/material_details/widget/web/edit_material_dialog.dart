import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

/// A responsive dialog for updating material metadata (Title & Description).
/// This Dialog only triggers the update; success/failure logic is handled by the parent's Centralized Listener.
class EditMaterialDialog extends StatefulWidget {
  final MaterialModel material;
  final String courseId;

  const EditMaterialDialog({
    super.key,
    required this.courseId,
    required this.material,
  });

  @override
  State<EditMaterialDialog> createState() => _EditMaterialDialogState();
}

class _EditMaterialDialogState extends State<EditMaterialDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //? Initialize controllers with current values.
    _titleController = TextEditingController(text: widget.material.title);
    _descriptionController = TextEditingController(
      text: widget.material.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //* Responsive width: adapt for Mobile vs Web.
    double dialogWidth = SizeConfig.isMobile(context)
        ? MediaQuery.sizeOf(context).width
        : 450;

    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Center(child: Text('Edit Material Details')),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Container(
        width: dialogWidth,
        constraints: const BoxConstraints(maxWidth: 450),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Field 1: Title
              AppTextField(
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
                hintText: 'Material Title',
                textFieldType: TextFieldType.normal,
                controller: _titleController,
              ),
              const SizedBox(height: 16),

              //* Field 2: Description
              AppTextField(
                prefixIcon: const Icon(Icons.description_outlined),
                hintText: 'Description',
                textFieldType: TextFieldType.normal,
                controller: _descriptionController,
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              //* Educational Tip
              Text(
                '• Use a descriptive title and summary to help students find their resources easily.',
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark.withAlpha(180),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      actions: [
        //* Using BlocBuilder only for UI states (Loading/Idle).
        //* ! Logic for Success/Failure is delegated to the Parent Listener (WebMaterialDetailsViewBody).
        BlocBuilder<MaterialCrudCubit, MaterialCrudState>(
          builder: (context, state) {
            if (state is UpdateMaterialLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.secondary),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: CustomAppButton(
                    label: 'Cancel',
                    height: 40,
                    textColor: AppColors.primaryDark,
                    backgroundColor: AppColors.secondaryLight,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomAppButton(
                    textColor: AppColors.whiteLight,
                    height: 40,
                    label: 'Save',
                    onPressed: () => _handleUpdate(context),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Triggers the metadata update logic if changes are valid.
  void _handleUpdate(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    //? Check if data has actually changed to prevent unnecessary network overhead.
    final bool hasChanged =
        title != widget.material.title ||
        description != widget.material.description;

    if (title.isNotEmpty && hasChanged) {
      context.read<MaterialCrudCubit>().updateMaterialMetadata(
        materialId: widget.material.id,
        title: title,
        description: description,
      );
    } else {
      //? If no changes, close the dialog immediately.
      Navigator.pop(context);
    }
  }
}
