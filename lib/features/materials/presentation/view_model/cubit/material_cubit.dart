import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/mixins/cubit_message_mixin.dart';
import 'package:sams_app/core/utils/mixins/safe_emit_mixin.dart';
import 'package:sams_app/features/materials/data/repos/material_repo.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubit/material_state.dart';

//* Manages materials state — fetch all materials and single material details
class MaterialCubit extends Cubit<MaterialsState>
    with CubitMessageMixin, SafeEmitMixin {
  final MaterialRepo materialsRepo;

  MaterialCubit(this.materialsRepo) : super(MaterialInitial());

  //* Load cached materials first, then fetch fresh data from API
  //* Shows cached data instantly while waiting for network response
  Future<void> fetchMaterials({required String courseId}) async {
    // 1. Try to get data from local cache first for instant UI feedback
    final cachedMaterials = materialsRepo.getCachedMaterials();

    if (cachedMaterials.isNotEmpty) {
      emit(MaterialSuccess(cachedMaterials));
    } else {
      // 2. If no cache, show loading spinner
      emit(MaterialLoading());
    }

    // 3. Fetch fresh data from Remote API
    final result = await materialsRepo.fetchMaterials(courseId: courseId);

    result.fold(
      (failure) {
        // If we already have cached data on screen, don't show error screen
        // Just show a snackbar message using our mixin
        if (state is MaterialSuccess) {
          emitMessage(failure);
        } else {
          emit(MaterialFailure(failure));
        }
      },
      // 4. Update UI with fresh data from server
      (materials) => emit(MaterialSuccess(materials)),
    );
  }

  //* Fetch details for a specific material by ID
  Future<void> fetchMaterialDetails({required String materialId}) async {
    emit(MaterialLoading());

    final result = await materialsRepo.fetchMaterialDetails(
      materialId: materialId,
    );

    result.fold(
      (failure) => emit(MaterialFailure(failure)),
      (material) => emit(MaterialDetailsSuccess(material)),
    );
  }
}
