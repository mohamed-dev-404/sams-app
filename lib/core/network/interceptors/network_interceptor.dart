import 'package:connectivity_plus/connectivity_plus.dart';
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
    if (connectivityResult.contains(ConnectivityResult.none)) {
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
