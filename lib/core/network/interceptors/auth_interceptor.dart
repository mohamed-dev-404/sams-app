import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _refreshToken();

      if (newToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    }

    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final response = await dio.post('auth/refresh');
    return response.data['token'];
  }
}
