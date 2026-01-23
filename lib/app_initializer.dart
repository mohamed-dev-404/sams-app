import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sams_app/core/cache/secure_storage.dart';
import 'package:sams_app/core/cache/shared_pref_helper.dart';
import 'package:sams_app/core/utils/services/service_locator.dart';
import 'core/helper/app_logger.dart';

class AppInitializer {
  AppInitializer._();

  /// This method is called ONCE when the app starts
  /// It prepares all services the app depends on
  static Future<void> init() async {
    try {
      // (1) Initialize logger first
      // So we can log messages during app startup
      _initLogger();

      // (2) Initialize app storage systems
      // GetStorage, SharedPreferences, SecureStorage
      await _initAppStorage();

      // (3) Setup service locator (GetIt)
      // Registers all app services and dependencies
      _initServiceLocator();

      //* Final success log
      AppLogger.success(
        'Application initialized successfully',
        tag: 'AppInitializer',
      );
    } catch (e, stackTrace) {
      //! If ANY error happens during initialization, log it and rethrow
      AppLogger.error(
        'Application initialization failed',
        error: e,
        stackTrace: stackTrace,
        tag: 'AppInitializer',
      );
      rethrow;
    }
  }

  //! =========================
  //! Private helper methods
  //! =========================
  static Future<void> _initAppStorage() async {
    // (1) Initialize GetStorage
    await _initGetStorage();

    // (2) Check that secure storage is available
    await _initSharedPreferences();

    // (3) Initialize SharedPreferences
    await SecureStorageService.instance.init();
  }

  /// Initializes GetStorage
  /// Used for simple fast key-value local storage
  static Future<void> _initGetStorage() async {
    await GetStorage.init();

    AppLogger.success('GetStorage initialized successfully', tag: 'GetStorage');
  }

  /// Initializes SharedPreferences using your helper
  /// Used for lightweight cached data (flags, settings, etc.)
  static Future<void> _initSharedPreferences() async {
    await SharedPrefHelper().init();

    AppLogger.success(
      'SharedPreferences initialized successfully',
      tag: 'SharedPreferences',
    );
  }

  /// Configures logging behavior
  /// Logs are enabled only in debug mode
  static void _initLogger() {
    // Enable logs in debug mode
    // Disable logs in release mode
    AppLogger.setEnabled(kDebugMode);

    AppLogger.success('Logger initialized', tag: 'Logger');
  }

  /// Initializes the service locator (GetIt)
  /// Registers all app services and dependencies
  static void _initServiceLocator() {
    setupServiceLocator();

    AppLogger.success('Service locator initialized successfully', tag: 'GetIt');
  }
}
