import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;

  RetryInterceptor(
    this.dio, {
    this.maxRetries = 3,
  });

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;

    //  Retry only GET requests (to Prevents Multiple POST)
    if (request.method != 'GET') {
      return handler.next(err);
    }

    //extra is a Map inside every Dio request (You can store anything inside it)
    // Get current retry count from extra
    final retryCount = (request.extra['retryCount'] ?? 0) as int;

    //  Stop if max retries reached
    if (retryCount >= maxRetries) {
      return handler.next(err);
    }

    if (_shouldRetry(err)) {
      // Save new retry count in extra
      request.extra['retryCount'] = retryCount + 1;

      // Exponential backoff (2s, 4s, 8s...) before retrying
      final delay = Duration(seconds: 2 * (retryCount + 1));
      await Future.delayed(delay);

      //  Retry the request with same options
      final response = await dio.fetch(request);
      return handler.resolve(response);
    }

    return handler.next(err);
  }

  // only 5xx + timeouts are retriable
  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        (e.response?.statusCode ?? 0) >= 500;
  }
}
