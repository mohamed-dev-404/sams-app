//* Handles all material-related API calls and local caching
import 'package:dartz/dartz.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/materials/data/data_source/material_local_data_source.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/data/repos/material_repo.dart';

class MaterialRepoImpl implements MaterialRepo {
  final ApiConsumer api;
  final MaterialLocalDataSource localDataSource;

  MaterialRepoImpl({required this.api, required this.localDataSource});

  //* GET materials → cache locally → return list
  @override
  Future<Either<String, List<MaterialModel>>> fetchMaterials({
    required String courseId,
  }) async {
    try {
      final response = await api.get(EndPoints.getMaterials(courseId));

      List<MaterialModel> materials =
          (response[ApiKeys.data] as List?)
              ?.map((item) => MaterialModel.fromJson(item))
              .toList() ??
          [];

      await localDataSource.cacheMaterials(materials);

      return right(materials);
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  //* GET single material details
  @override
  Future<Either<String, MaterialModel>> fetchMaterialDetails({
    required String materialId,
  }) async {
    try {
      final response = await api.get(EndPoints.materialDetails(materialId));

      return right(MaterialModel.fromJson(response[ApiKeys.data]));
    } on ApiException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  //* Returns materials from local cache
  @override
  List<MaterialModel> getCachedMaterials() {
    return localDataSource.getCachedMaterials();
  }
}
