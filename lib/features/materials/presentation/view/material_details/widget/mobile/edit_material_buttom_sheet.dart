import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

/// A Bottom Sheet for updating material metadata (Title & Description) on Mobile.
/// Logic for success/failure (navigation & snacks) is delegated to the Centralized Listener in the parent view.
class EditMaterialBottomSheet extends StatefulWidget {
  final MaterialModel material;

  const EditMaterialBottomSheet({
    super.key,
    required this.material,
  });

  @override
  State<EditMaterialBottomSheet> createState() =>
      _EditMaterialBottomSheetState();
}

class _EditMaterialBottomSheetState extends State<EditMaterialBottomSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //? Initialize controllers with current material data.
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
    return Padding(
      padding: EdgeInsets.only(
        //? Responsive padding to lift the sheet above the keyboard.
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 12,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //* UI Decor: Sheet Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Edit Material Details',
                style: AppStyles.mobileTitleMediumSb.copyWith(
                  color: AppColors.primaryDarkHover,
                ),
              ),
              const SizedBox(height: 24),

              //* Inputs: Title & Description
              AppTextField(
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
                hintText: 'Material Title',
                textFieldType: TextFieldType.normal,
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              AppTextField(
                prefixIcon: const Icon(Icons.description_outlined),
                hintText: 'Description',
                textFieldType: TextFieldType.normal,
                controller: _descriptionController,
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              //* Guidance Text
              Text(
                '• Provide a clear title and summary to help students recognize the content.',
                style: AppStyles.mobileBodyMediumRg.copyWith(
                  color: AppColors.primaryDark.withAlpha(180),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 24),

              //* Action Buttons
              BlocBuilder<MaterialCrudCubit, MaterialCrudState>(
                builder: (context, state) {
                  if (state is UpdateMaterialLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: CustomAppButton(
                          label: 'Cancel',
                          height: 45,
                          textColor: AppColors.primaryDark,
                          backgroundColor: AppColors.secondaryLight,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomAppButton(
                          label: 'Save',
                          height: 45,
                          onPressed: () => _handleUpdate(context),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Validates and triggers the update action via MaterialCrudCubit.
  void _handleUpdate(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    //? Efficiency: Only call API if changes were actually made.
    final bool isChanged =
        title != widget.material.title ||
        description != widget.material.description;

    if (isChanged && title.isNotEmpty) {
      context.read<MaterialCrudCubit>().updateMaterialMetadata(
        materialId: widget.material.id,
        title: title,
        description: description,
      );
    } else {
      //? No changes? Just dismiss the sheet.
      Navigator.pop(context);
    }
  }
}
