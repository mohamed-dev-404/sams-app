import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/mixins/cubit_message_mixin.dart';
import 'package:sams_app/core/utils/mixins/safe_emit_mixin.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/data/repos/material_repo.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

//* Handles Material operations: Create (Upload), Update, and Delete.
class MaterialCrudCubit extends Cubit<MaterialCrudState>
    with CubitMessageMixin, SafeEmitMixin {
  final MaterialRepo materialsRepo;
  final MaterialModel? initialMaterial;

  MaterialCrudCubit(this.materialsRepo, {this.initialMaterial})
    : super(MaterialCrudInitial());

  //* Full Workflow: Request Presigned URLs → S3 Upload → Backend Confirmation
  Future<void> uploadMaterial({
    required String courseId,
    required String title,
    required String description,
    required List<XFile> selectedFiles,
  }) async {
    // 1. Show loading state to block UI or show progress
    emit(MaterialCrudLoading());

    // 2. Execute the full workflow in the repository
    final result = await materialsRepo.uploadMaterialFullWorkflow(
      courseId: courseId,
      title: title,
      description: description,
      selectedFiles: selectedFiles,
    );

    result.fold(
      (failure) {
        // Show snackbar error message using mixin
        emitMessage(failure);
        emit(MaterialCrudFailure(failure));
      },
      (newMaterial) {
        // Success: Emit the newly created material to update the list later
        emit(
          MaterialCrudSuccess(
            material: newMaterial,
            message: 'Material added successfully!',
          ),
        );
      },
    );
  }
}
