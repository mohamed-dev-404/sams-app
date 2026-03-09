import 'package:dartz/dartz.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/core/utils/services/s3_upload_service.dart';
import 'package:sams_app/features/profile/data/models/save_profile_pic_request.dart';
import 'package:sams_app/features/profile/data/models/upload_url_model.dart';
import 'package:sams_app/features/profile/data/models/upload_url_request.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';
import 'package:sams_app/features/profile/data/repos/profile_repo.dart';
import 'package:sams_app/features/profile/data/services/image_processor.dart';

//* Handles all profile-related API calls and S3 upload logic
class ProfileRepoImpl extends ProfileRepo {
  ProfileRepoImpl({required this.api, required this.s3Service, required this.imageProcessor});
  final ApiConsumer api;
  final S3UploadService s3Service;
  final ImageProcessor imageProcessor;

  //* GET /profile → returns current user data
  @override
  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(EndPoints.getProfile);

      final userModel = UserModel.fromMap(response[ApiKeys.data]);

      return Right(userModel);
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

 // POST → get presigned S3 URL and object key
  @override
  Future<Either<String, UserModel>> uploadProfilePicture(XFile imageFile) async {
    try {
       final processResult = await imageProcessor.processImage(imageFile);

      return await processResult.fold(
      (error) => Left(error), 
      (processed) async {

      final uploadData = await _getPresignedUrl(
        processed.fileName,
          processed.bytes.length,
          processed.contentType,
      );

      await s3Service.uploadFile(
        url: uploadData.uploadUrl,
          fileBytes: processed.bytes,
          fileName: processed.fileName,
          contentType: processed.contentType,
      );

      final userUpdated = await _savePictureToProfile(uploadData.key);
        return Right(userUpdated);
      },
    );
  } on ApiException catch (e) {
    return Left(e.errorModel.errorMessage);
  } catch (e) {
    return Left('Failed to upload profile picture: ${e.toString()}');
  }
}

// POST → returns presigned S3 URL and object key
  Future<UploadUrlModel> _getPresignedUrl(
    String name,
    int size,
    String type,
  ) async {
    final requestBody = UploadUrlRequest(
      originalFileName: name,
      contentType: type,
      fileSize: size,
    );

    final response = await api.post(
      EndPoints.createUploadUrl,
      data: requestBody.toJson(),
    );
    return UploadUrlModel.fromJson(response[ApiKeys.data]);
  }

  // PATCH → updates profile pic with the uploaded S3 key
  Future<UserModel> _savePictureToProfile(String key) async {
    final response = await api.patch(
      EndPoints.saveProfilePic,
      data: SaveProfilePicRequest(key: key).toJson(),
    );
  
    return UserModel.fromMap(response[ApiKeys.data]);
  }
}
