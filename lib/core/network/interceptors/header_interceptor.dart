import 'package:dio/dio.dart';
import 'package:sams_app/core/cache/secure_storage.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken = await SecureStorageService.instance
        .getAccessToken();

    options.headers[ApiKeys.authorization] = accessToken != null
        ? 'Bearer $accessToken'
        : null;
    super.onRequest(options, handler);
  }
}
