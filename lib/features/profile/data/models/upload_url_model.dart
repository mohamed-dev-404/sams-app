import 'package:sams_app/core/utils/constants/api_keys.dart';

//* Response model for the pre-signed URL from backend
class UploadUrlModel {
  final String key;
  final String uploadUrl;

  UploadUrlModel({required this.key, required this.uploadUrl});

  factory UploadUrlModel.fromJson(Map<String, dynamic> json) {
    return UploadUrlModel(
      key: json[ApiKeys.key] ?? '',
      uploadUrl: json[ApiKeys.uploadUrl] ?? '',
    );
  }
}
