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


"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OThjNTM1ZWM5NWZkNjVmMzYyOTE1MGUiLCJhY2FkZW1pY0VtYWlsIjoiMjAyMjA3MDAwQG82dS5lZHUuZWciLCJyb2xlcyI6WyJpbnN0cnVjdG9yIl0sImlhdCI6MTc3MTYxNDY3MiwiZXhwIjoxNzcxNjE1NTcyfQ.0AGOYy7aCcDz6TO17hXkPzyqtywWex__WJ_FzIObpMA";





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
