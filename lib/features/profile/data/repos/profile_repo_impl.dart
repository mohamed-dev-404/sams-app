import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
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

class ProfileRepoImpl extends ProfileRepo {
  ProfileRepoImpl({required this.api, required this.s3Service});
  final ApiConsumer api;
  final S3UploadService s3Service;

  //* Fetches user profile data.
  ///
  /// Sends a GET request to [EndPoints.getProfile].
  /// Handles [ApiException] and returns a failure message if caught.
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

  //! Uploads a profile picture.
  ///
  /// Sends a POST request to [EndPoints.createUploadUrl].
  /// Uploads the image file to S3 using [S3UploadService].
  /// Sends a POST request to [EndPoints.saveProfilePic] with the S3 key.
  /// Handles [ApiException] and returns a failure message if caught.
  @override
  Future<Either<String, UserModel>> uploadProfilePicture(XFile imageFile) async {
    try {
       Uint8List fileBytes = await imageFile.readAsBytes();
      final String fileName = imageFile.name;
      final String contentType = lookupMimeType(imageFile.path) ?? 'image/png';

      const int maxLimit = 5 * 1024 * 1024;

      if (fileBytes.length > maxLimit) {
        if (!contentType.startsWith('image')) {
          return const Left('File is too large. Maximum allowed size is 5MB.');
        }

        fileBytes = await _compressImageLogic(fileBytes);

        if (fileBytes.length > maxLimit) {
          return const Left(
            'The image is still too large (over 5MB) even after compression. Please choose another image.',
          );
        }
      }

      final int finalSize = fileBytes.length;

      final uploadData = await _getPresignedUrl(
        fileName,
        finalSize,
        contentType,
      );

      await s3Service.uploadFile(
        url: uploadData.uploadUrl,
        fileBytes: fileBytes,
        fileName: fileName,
        contentType: contentType,
      );

      final userUpdated = await _savePictureToProfile(uploadData.key);
      return Right(userUpdated);
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left('Failed to upload profile picture: ${e.toString()}');
    }
  }

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


  Future<UserModel> _savePictureToProfile(String key) async {
    final response = await api.patch(
      EndPoints.saveProfilePic,
      data: SaveProfilePicRequest(key: key).toJson(),
    );
  
    return UserModel.fromMap(response[ApiKeys.data]);
  }

  Future<Uint8List> _compressImageLogic(Uint8List bytes) async {
    try {
      final result = await FlutterImageCompress.compressWithList(
        bytes,
        minHeight: 1000,
        minWidth: 1000,
        quality: 80,
      );
      return Uint8List.fromList(result);
    } catch (e) {
      return bytes;
    }
  }
}
