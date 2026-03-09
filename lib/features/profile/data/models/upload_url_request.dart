import 'package:sams_app/core/utils/constants/api_keys.dart';

//* Request body sent to get a presigned S3 upload URL
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
