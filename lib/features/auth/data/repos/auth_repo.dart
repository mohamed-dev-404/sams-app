//todo auth repos
import 'package:dartz/dartz.dart';
import 'package:sams_app/features/auth/data/models/login_model/login_model.dart';

abstract class AuthRepo {
  //! login
  Future<Either<String, LoginModel>> login({
    required String email,
    required String password,
  });

  //! signup flow

  Future<Either<String, String>> signUp({
    required String academicEmail,
    required String academicId,
    required String fullName,
    required String password,
    required String confirmPassword,
  });

  //! forget password flow
  //? (1) Forgot Password (returns a failure message or void)
  Future<Either<String, void>> forgotPassword({required String email});

  //? (2) Verify OTP <activate account & reset password> (returns a failure message or resetToken)
  Future<Either<String, String>> verifyOtp({
    required String email,
    required String otp,
    required String action,
  });

  //? (3) Reset Password (returns a failure message or success message)
  Future<Either<String, String>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  });

  //* resend otp
  Future<Either<String, void>> resendOTP({
    required String email,
    required String action,
  });
}
