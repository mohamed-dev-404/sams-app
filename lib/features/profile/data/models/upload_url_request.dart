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
      'originalFileName': originalFileName,
      'contentType': contentType,
      'fileSize': fileSize,
    };
  }
}
