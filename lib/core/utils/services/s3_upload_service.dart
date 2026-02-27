import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/errors/models/error_model.dart'; // عشان kIsWeb

class S3UploadService {
  final Dio _dio = Dio();

  Future<void> uploadFile({
    required String url,
    required Uint8List fileBytes,
    required String fileName,
    required String contentType,
    Duration timeout = const Duration(seconds: 120),
    CancelToken? cancelToken,
  }) async {
    try {
      

      final Map<String, dynamic> headers = {
        'Content-Type': contentType,
      };

      if (!kIsWeb) {
        headers['Content-Length'] = fileBytes.length.toString();
      }

      await _dio.put(
        url,
        data: kIsWeb ? fileBytes : Stream.fromIterable([fileBytes]),
        options: Options(
          headers: headers,
          sendTimeout: timeout,
          receiveTimeout: const Duration(seconds: 60),
          responseType: kIsWeb ? ResponseType.plain : ResponseType.json,
        ),
        onSendProgress: (count, total) {
          if (total > 0) {
            if (kDebugMode) {
              print(
                '🚀 Uploading to S3: ${(count / total * 100).toStringAsFixed(2)}%',
              );
            }
          }
        },
      );
    } on DioException catch (e) {
      throw _handleS3Error(e);
    } catch (e) {
      throw ApiException(
        errorModel: ErrorModel(
          errorMessage: 'Unexpected error during S3 upload: $e',
        ),
      );
    }
  }

  ApiException _handleS3Error(DioException e) {
    final String message = (kIsWeb && e.error.toString().contains('TypeError'))
        ? 'Upload completed, but verification failed. Please refresh.'
        : switch (e.type) {
            DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout =>
              'Connection timed out. Please check your internet and try again.',
            DioExceptionType.receiveTimeout =>
              'Server is not responding. Please try again later.',
            DioExceptionType.badResponse => _mapS3StatusToMessage(
              e.response?.statusCode,
            ),
            DioExceptionType.cancel => 'Upload was cancelled.',
            DioExceptionType.connectionError =>
              'No internet connection. Please check your network.',
            _ => 'An unexpected error occurred. Please try again.',
          };

    return ApiException(
      errorModel: ErrorModel(
        errorMessage: message,
        statusCode: e.response?.statusCode,
      ),
    );
  }

  String _mapS3StatusToMessage(int? statusCode) {
    return switch (statusCode) {
      403 => 'Access denied. Please re-select the image.',
      413 => 'Image is too large. Please choose a smaller file.',
      _ => 'Service unavailable (Error: $statusCode).',
    };
  }
}
