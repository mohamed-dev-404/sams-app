import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/mixins/cubit_message_mixin.dart';
import 'package:sams_app/core/utils/mixins/safe_emit_mixin.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/data/repos/material_repo.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

//* Manages materials state — fetch all materials and single material details
class MaterialFetchCubit extends Cubit<MaterialFetchState>
    with CubitMessageMixin, SafeEmitMixin {
  final MaterialRepo materialsRepo;

  MaterialFetchCubit(this.materialsRepo) : super(MaterialFetchInitial());

  //* Load cached materials first, then fetch fresh data from API
  //* Shows cached data instantly while waiting for network response
  Future<void> fetchMaterials({required String courseId}) async {
    // 1. Try to get data from local cache first for instant UI feedback
    final cachedMaterials = materialsRepo.getCachedMaterials();

    if (cachedMaterials.isNotEmpty) {
      emit(MaterialFetchSuccess(cachedMaterials));
    } else {
      // 2. If no cache, show loading spinner
      emit(MaterialFetchLoading());
    }

    // 3. Fetch fresh data from Remote API
    final result = await materialsRepo.fetchMaterials(courseId: courseId);

    result.fold(
      (failure) {
        // If we already have cached data on screen, don't show error screen
        // Just show a snackbar message using our mixin
        if (state is MaterialFetchSuccess) {
          emitMessage(failure);
        } else {
          emit(MaterialFetchFailure(failure));
        }
      },
      // 4. Update UI with fresh data from server
      (materials) => emit(MaterialFetchSuccess(materials)),
    );
  }

  //* Fetch details for a specific material by ID
  Future<void> fetchMaterialDetails({required String materialId}) async {
    emit(MaterialDetailsFetchLoading());

    final result = await materialsRepo.fetchMaterialDetails(
      materialId: materialId,
    );

    result.fold(
      (failure) => emit(MaterialDetailsFetchFailure(failure)),
      (material) => emit(MaterialFetchDetailsSuccess(material)),
    );
  }
  
//* Update the UI list locally without making a new network request
  void addMaterialToListView(MaterialModel newMaterial) {
    if (state is MaterialFetchSuccess) {
      // 1. Get the current list from the success state
      final currentList = (state as MaterialFetchSuccess).materials;

      // 2. Prepend the material to show it at the top of the list
      final updatedList = [newMaterial, ...currentList];

      // 3. Emit the same success state with the updated list
      emit(MaterialFetchSuccess(updatedList));
    } else {
      // 4. If the state was initial, loading, or empty, show the new item as the first element
      emit(MaterialFetchSuccess([newMaterial]));
    }
  }
}
