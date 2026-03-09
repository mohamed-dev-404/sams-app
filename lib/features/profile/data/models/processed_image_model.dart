import 'dart:typed_data';

//* Model to hold image data after processing and before the S3 upload
class ProcessedImage {
  final Uint8List bytes;
  final String fileName;
  final String contentType;

  ProcessedImage({
    required this.bytes,
    required this.fileName,
    required this.contentType,
  });
}
