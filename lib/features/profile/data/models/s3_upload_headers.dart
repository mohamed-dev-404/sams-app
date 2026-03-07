import 'package:sams_app/core/utils/constants/api_keys.dart';

class S3UploadHeaders {
  final String contentType;
  final int contentLength;

  S3UploadHeaders({required this.contentType, required this.contentLength});

  Map<String, dynamic> toMap() => {
    ApiKeys.contentTypeHeader: contentType,
    ApiKeys.contentLengthHeader: contentLength,
  };
}
