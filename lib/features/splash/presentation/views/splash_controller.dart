import 'package:sams_app/core/cache/secure_storage.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';

/// Handles splash screen initialization and determines the navigation target.
///
/// This class separates business/init logic from the splash UI,
/// keeping the presentation layer focused on animations.
class SplashController {
  SplashController._();

  /// Checks the user's auth token from secure storage and returns
  /// the appropriate route path.
  ///
  /// - Authenticated users → [RoutesName.courses] (HomeView)
  /// - Unauthenticated users → [RoutesName.login] (LoginView)
  static Future<String> initializeAndGetRoute() async {
    //! 🛑 FOR TESTING: Infinite delay to keep splash visible and prevent navigation
    await Future.delayed(const Duration(days: 365));
    //!-------------------------------------------------------------------
    
    final token = await SecureStorageService.instance.getAccessToken();

    if (token != null && token.isNotEmpty) {
      return RoutesName.courses;
    }

    return RoutesName.login;
  }
}
