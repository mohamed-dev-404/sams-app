import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/cache/get_storage.dart';
import 'package:sams_app/core/cache/secure_storage.dart';
import 'package:sams_app/core/utils/constants/api_endpoints.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/core/utils/constants/app_constants.dart';
import 'package:sams_app/core/utils/router/app_router.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/features/auth/data/models/login_model/login_model.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  // Use a variable to track the refresh progress
  Future<String?>? _accessTokenFuture;

  AuthInterceptor(this.dio);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // 1. Define paths that should NOT trigger a refresh/logout
    final guestPaths = [
      EndPoints.forgetPassword,
      EndPoints.verifyOTP,
      EndPoints.resetPassword,
      EndPoints.resendOTP,
      EndPoints.login,
    ];

    // 2. Check if the current error came from one of these paths
    final bool isGuestRequest = guestPaths.any(
      (path) => err.requestOptions.path.contains(path),
    );

    // 3. If it's a guest request, just let the error pass to your Cubit
    if (isGuestRequest) {
      return handler.next(err);
    }

    // 4. Otherwise, proceed with the normal 401 refresh logic
    if (err.response?.statusCode == 401) {
      // If a refresh is already in progress, wait for it.
      // Otherwise, start a new one.
      _accessTokenFuture ??= _refreshToken();

      final newAccessToken = await _accessTokenFuture;
      _accessTokenFuture = null; // Clear it after completion

      if (newAccessToken != null) {
        err.requestOptions.headers[ApiKeys.authorization] =
            'Bearer $newAccessToken';
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final oldRefreshToken = await SecureStorageService.instance
        .getRefreshToken();

    if (oldRefreshToken == null) {
      await _performLogout();
      return null;
    }

    try {
      final refreshDio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
      final response = await refreshDio.post(
        EndPoints.refresh,
        data: {ApiKeys.refreshToken: oldRefreshToken},
      );

      final dataJson = response.data[ApiKeys.data];
      LoginModel loginModel = LoginModel.fromJson(dataJson);

      await _cacheNewTokens(loginModel);
      return loginModel.accessToken;
    } catch (e) {
      await _performLogout();
      return null;
    }
  }

  Future<void> _performLogout() async {
    await SecureStorageService.instance.clearAll();
    await GetStorageHelper.erase();

    // ignore: use_build_context_synchronously
    AppRouter.navigatorKey.currentState?.context.go(RoutesName.login);
  }

  Future<void> _cacheNewTokens(LoginModel loginModel) async {
    await SecureStorageService.instance.saveAccessToken(
      loginModel.accessToken ?? '',
    );
    await SecureStorageService.instance.saveRefreshToken(
      loginModel.refreshToken ?? '',
    );
  }
}
