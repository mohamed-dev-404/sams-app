import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {
  final Connectivity connectivity;

  NetworkInterceptor(this.connectivity);

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(
        DioException(
          type: DioExceptionType.unknown,
          requestOptions: options,
          error:
              'No Internet Connection, please check your connection and try again.',
        ),
      );
    }

    return handler.next(options);
  }
}
