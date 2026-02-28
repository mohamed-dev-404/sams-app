import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:sams_app/core/utils/constants/app_constants.dart';
import 'package:sams_app/features/profile/data/models/processed_image_model.dart';


abstract class ImageProcessor {
  Future<Either<String, ProcessedImage>> processImage(XFile file);
}



class ImageProcessorImpl implements ImageProcessor {
  @override
  Future<Either<String, ProcessedImage>> processImage(XFile file) async {
    try {
      final Uint8List bytes = await file.readAsBytes();
      final String path = file.path;
      final String fileName = file.name;

final contentType = lookupMimeType(path) ?? lookupMimeType(fileName) ?? 'image/png';

      if (!contentType.startsWith('image')) {
        return const Left('Invalid image format');
      }

      Uint8List processedBytes = bytes;

      if (processedBytes.length > AppConstants.maxSizeUploadPic) {
        processedBytes = await _compress(processedBytes);

        if (processedBytes.length > AppConstants.maxSizeUploadPic) {
          return const Left(
            'The image is still too large (over 5MB) even after compression.',
          );
        }
      }

      return Right(
        ProcessedImage(
          bytes: processedBytes,
          fileName: fileName,
          contentType: contentType,
        ),
      );
    } catch (_) {
      return const Left('Failed to process image');
    }
  }

  Future<Uint8List> _compress(Uint8List bytes) async {
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 1000,
      minWidth: 1000,
      quality: 80,
    );
    return Uint8List.fromList(result);
  }
}
