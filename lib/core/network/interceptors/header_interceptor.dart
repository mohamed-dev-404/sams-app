import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers[ApiKey.authorization] =
    //  CacheHelper().getData(key: ApiKey.token) != null
    //         ? 'Bearer ${CacheHelper().getData(key: ApiKey.token)}'
    //         : null;
    super.onRequest(options, handler);
  }
}
