import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sams_app/core/helper/app_logger.dart';
import 'package:sams_app/core/utils/constants/cache_keys.dart';

///! ===================================================
///! SecureStorageService
///! ===================================================
///? This service is used to **store sensitive data securely**
/// (tokens, user credentials, etc.)
///
///  It follows the Singleton pattern → only one instance is created.
///  Uses `flutter_secure_storage` which is encrypted.
///  Must call `init()` once before using it.
///
/// Example setup in main():
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await SecureStorageService.instance.init(); // init once
///   runApp(MyApp());
/// }
/// ```
///
/// Example usage:
/// ```dart
/// await SecureStorageService.instance.setString('token', 'abcd1234');
/// final token = await SecureStorageService.instance.getString('token');
/// print(token); // abcd1234
/// ```
class SecureStorageService {
  static final SecureStorageService instance = SecureStorageService._internal();

  SecureStorageService._internal();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  bool _isInitialized = false;

  ///! Must be called once at app startup
  Future<void> init() async {
    if (_isInitialized) return;

    await _storage.containsKey(key: '_health_check_');
    _isInitialized = true;

    AppLogger.success(
      'SecureStorageService initialized successfully',
      tag: 'SecureStorage',
    );
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'SecureStorageService.init() must be called before usage',
      );
    }
  }

  //! ===============================
  //! Generic Methods
  //! ===============================

  //* Set a string value by key
  Future<void> setString(String key, String value) async {
    _ensureInitialized();
    await _storage.write(key: key, value: value);
  }

  //* Get a string value by key
  Future<String?> getString(String key) async {
    _ensureInitialized();
    return _storage.read(key: key);
  }

  //* Remove a value by key
  Future<void> remove(String key) async {
    _ensureInitialized();
    await _storage.delete(key: key);
  }

  //* Clear all stored data
  Future<void> clearAll() async {
    _ensureInitialized();
    await _storage.deleteAll();
  }

  //! ===============================
  //! App-specific helpers
  //! ===============================

  //* Save access token
  Future<void> saveAccessToken(String token) async {
    await setString(CacheKeys.accessToken, token);
  }

  //* Get access token
  Future<String?> getAccessToken() async {
    return getString(CacheKeys.accessToken);
  }

  //* Delete access token
  Future<void> deleteAccessToken() async {
    await remove(CacheKeys.accessToken);
  }

  //* Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await setString(CacheKeys.refreshToken, token);
  }

  //* Get refresh token
  Future<String?> getRefreshToken() async {
    return getString(CacheKeys.refreshToken);
  }

  //* Delete refresh token
  Future<void> deleteRefreshToken() async {
    await remove(CacheKeys.refreshToken);
  }

  //* Save user role
  Future<void> saveUserRole(String role) async {
    await setString(CacheKeys.role, role);
  }

  //* Get user role
  Future<String?> getUserRole() async {
    return getString(CacheKeys.role);
  }
}
