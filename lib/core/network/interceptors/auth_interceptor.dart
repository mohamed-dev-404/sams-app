// import 'package:dio/dio.dart';

// class AuthInterceptor extends Interceptor {
//   final Dio dio;

//   AuthInterceptor(this.dio);

//   @override
//   Future onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (err.response?.statusCode == 401) {
//       final newToken = await _refreshToken();

//       if (newToken != null) {
//         err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

//         final response = await dio.fetch(err.requestOptions);
//         return handler.resolve(response);
//       }
//     }

//     return handler.next(err);
//   }

//   Future<String?> _refreshToken() async {
//     final response = await dio.post('auth/refresh');
//     return response.data['token'];
//   }
// }

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const String manualAccessToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OTc3YmI3NTI0YjE5NTczMWMwYWU1NDciLCJhY2FkZW1pY0VtYWlsIjoiMjAyMjAyNjExQG82dS5lZHUuZWciLCJyb2xlcyI6WyJzdHVkZW50Il0sImlhdCI6MTc3MjMxODk2OCwiZXhwIjoxNzcyMzE5ODY4fQ.5RhdvYgePTsUtzhe-GiNZaevqT8dHbUvrzcrNAo_l3I";

    options.headers['Authorization'] = 'Bearer $manualAccessToken';

    print("🔑 Auth Token Injected Manually");
    return handler.next(options);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print("⚠️ Token Expired or Invalid (401)");
    }
    return handler.next(err);
  }
}
