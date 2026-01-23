import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadHelper {
  ImageUploadHelper._();

  ///* Converts an image file to MultipartFile format for API upload
  static Future<MultipartFile> convertToMultipart(XFile image) async {
    try {
      // Verify file exists
      final file = File(image.path);
      if (!await file.exists()) {
        throw FileSystemException('Image file not found', image.path);
      }

      // Convert to MultipartFile
      return await MultipartFile.fromFile(
        image.path,
        filename: _extractFileName(image.path),
      );
    } catch (e) {
      throw Exception('Failed to convert image to multipart: $e');
    }
  }

  ///* Converts multiple images to MultipartFile list
  static Future<List<MultipartFile>> convertMultipleToMultipart(
    List<XFile> images,
  ) async {
    final List<MultipartFile> multipartFiles = [];

    for (var image in images) {
      final multipartFile = await convertToMultipart(image);
      multipartFiles.add(multipartFile);
    }

    return multipartFiles;
  }

  ///* Extracts filename from full path
  static String _extractFileName(String path) {
    return path.split('/').last;
  }
}
