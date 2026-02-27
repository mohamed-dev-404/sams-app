class S3UploadHeaders {
  final String contentType;
  final int contentLength;

  S3UploadHeaders({required this.contentType, required this.contentLength});

  Map<String, dynamic> toMap() => {
    'Content-Type': contentType,
    'Content-Length': contentLength,
  };
}
