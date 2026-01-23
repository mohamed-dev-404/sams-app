import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sams_app/core/errors/exceptions/api_exception.dart';
import 'package:sams_app/core/errors/handlers/dio_exception_handler.dart';
import 'package:sams_app/core/errors/models/error_model.dart';
import 'package:sams_app/core/network/api_consumer.dart';
import 'package:sams_app/core/network/interceptors/app_log_interceptor.dart';
import 'package:sams_app/core/network/interceptors/auth_interceptor.dart';
import 'package:sams_app/core/network/interceptors/header_interceptor.dart';
import 'package:sams_app/core/network/interceptors/network_interceptor.dart';
import 'package:sams_app/core/network/interceptors/retry_interceptor.dart';
import 'package:sams_app/core/utils/constants/app_constants.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.options
      ..connectTimeout = const Duration(seconds: 20)
      ..receiveTimeout = const Duration(seconds: 20);
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(NetworkInterceptor(Connectivity()));
    dio.interceptors.add(AuthInterceptor(dio));
    dio.interceptors.add(RetryInterceptor(dio, maxRetries: 5));
    if (!kReleaseMode) {
      dio.interceptors.add(DioLogger());
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  Never _handleException(Object e) {
    if (e is DioException) {
      handleDioExceptions(
        e,
      ); // throw suitable ApiException based on DioException type
    }
    throw ApiException(errorModel: ErrorModel(errorMessage: e.toString()));
  }
}
