import 'dart:typed_data';

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
