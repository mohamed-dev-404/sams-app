import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sams_app/core/helper/app_logger.dart';

///  DioLogger:
/// Responsible for logging Request / Response / Error details
/// in a clean and readable format inside the console.
class DioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info('🌐 [REQUEST] ${options.method} → ${options.uri}');

    // Log headers if present
    if (options.headers.isNotEmpty) {
      AppLogger.debug('🧾 Headers: ${jsonEncode(options.headers)}');
    }

    final body = options.data;
    // Log body if present
    if (body != null && body.toString().isNotEmpty) {
      AppLogger.debug('📤 Body: ${jsonEncode(body)}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    if (statusCode >= 200 && statusCode < 300) {
      AppLogger.success('✅ [RESPONSE] Success');
    } else if (statusCode >= 300 && statusCode < 400) {
      AppLogger.warning('⚠️ [RESPONSE] Redirect ($statusCode)');
    } else {
      AppLogger.error('❌ [RESPONSE] Failed ($statusCode)');
    }

    AppLogger.info('📊 Status: $statusCode ${response.statusMessage ?? ''}');

    // If the server returns HTML instead of JSON
    // (e.g. redirect page or server-side error)
    if (data is String && data.contains('<!DOCTYPE html>')) {
      AppLogger.warning(
        '⚠️ HTML response detected (possible redirect or server issue)',
      );
    } else {
      AppLogger.debug('📦 Data:\n${_prettyJson(data)}');
    }

    AppLogger.log('──────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    AppLogger.error(
      '❌ [ERROR] Request failed (${statusCode ?? 'NO STATUS'})',
      error: err,
      stackTrace: err.stackTrace,
    );
    // Log data if present
    if (err.response?.data != null) {
      AppLogger.debug('📦 Error Data:\n${_prettyJson(err.response?.data)}');
    }

    AppLogger.log('──────────────────────────────────────────────');
    handler.next(err);
  }

  /// Formats JSON with indentation for readable logs
  String _prettyJson(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('   ');
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
