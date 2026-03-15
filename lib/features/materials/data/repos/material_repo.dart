import 'package:dartz/dartz.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';

//* Abstract contract for materials data operations
abstract class MaterialRepo {
  //* Fetch all materials for a specific course
  Future<Either<String, List<MaterialModel>>> fetchMaterials({
    required String courseId,
  });

  //* Fetch a single material details
  Future<Either<String, MaterialModel>> fetchMaterialDetails({
    required String materialId,
  });

  //* Return cached materials
  List<MaterialModel> getCachedMaterials();
}
