import 'package:sams_app/core/utils/constants/api_keys.dart';

class UploadUrlRequest {
  final String originalFileName;
  final String contentType;
  final int fileSize;

  UploadUrlRequest({
    required this.originalFileName,
    required this.contentType,
    required this.fileSize,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.originalFileName: originalFileName,
      ApiKeys.contentType: contentType,
      ApiKeys.fileSize: fileSize,
    };
  }
}
