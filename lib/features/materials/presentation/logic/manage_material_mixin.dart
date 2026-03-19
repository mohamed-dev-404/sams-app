import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';

//* Mixin for manage material view logic and state management for both mobile and web 
mixin ManageMaterialMixin<T extends StatefulWidget> on State<T> {
  //* Text controllers and keys
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final GlobalKey<CourseMaterialSectionState> materialSectionKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //* onAddMaterialPressed
  void onAddMaterialPressed({
    required BuildContext context,
    required String courseId,
  }) {
    if (!formKey.currentState!.validate()) return;

    final files = materialSectionKey.currentState?.allPickedFiles ?? [];

    context.read<MaterialCrudCubit>().uploadMaterial(
      courseId: courseId,
      title: titleController.text.trim(),
      description: subtitleController.text.trim(),
      selectedFiles: files,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }
}
