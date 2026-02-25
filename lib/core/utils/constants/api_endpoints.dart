class EndPoints {
  EndPoints._();

  //? --- Admin User  --- ;

  static String users = 'admin/users';

  static String toggleUserActivation(String userId) {
    return 'admin/users/$userId/toggle-activation';
  }

  static String changeRole(String userId) {
    return 'admin/users/$userId/role';
  }

  static const String roles = 'admin/roles';

  //? --- Auth  --- ;
  static String login = 'auth/login';
  static String register = 'auth/register';
  static String refresh = 'auth/refresh';
  static String forgetPassword = 'auth/forgot-password';
  static String verifyOTP = 'auth/verify-otp';
  static String resetPassword = 'auth/reset-password';
  static String resendOTP = 'auth/resend-code';
}
