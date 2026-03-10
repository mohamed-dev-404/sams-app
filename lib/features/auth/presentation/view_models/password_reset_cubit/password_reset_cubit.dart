import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/auth/data/repos/auth_repo.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  final AuthRepo _authRepo;

  PasswordResetCubit(this._authRepo) : super(const PasswordResetState());

  //? ============================================================
  //? STEP 1: FORGOT PASSWORD SCREEN
  // Endpoint: /api/v1/auth/forgot-password
  // ?============================================================
  Future<void> sendResetCode({required String email}) async {
    // Result should update status to .codeSent and store email upon success
    // UI Listener: if (state.status == PasswordResetStatus.codeSent) -> Go to OTP view
    emit(state.copyWith(status: PasswordResetStatus.loading));

    final result = await _authRepo.forgotPassword(email: email);
    result.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.codeSent,
            email: email,
          ),
        );
      },
    );
  }

  //? ============================================================
  //? STEP 2: VERIFY OTP SCREEN
  // Endpoint: /api/v1/auth/verify-otp
  //? ============================================================
  Future<void> verifyOtp({required String otp}) async {
    // GUARD: Ensure email exists
    if (state.email == null) {
      emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          errorMessage: 'Session timed out. Please request a new code.',
        ),
      );
      return;
    }
    // Result should update status to .verified and store resetToken upon success
    // UI Listener: if (state.status == PasswordResetStatus.verified) -> Go to Reset Password view
    final String email = state.email!;
    final String action = ApiValues.resetPassword;

    emit(state.copyWith(status: PasswordResetStatus.loading));

    final result = await _authRepo.verifyOtp(
      email: email,
      otp: otp,
      action: action,
    );
    result.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (resetToken) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.verified,
            resetToken: resetToken,
          ),
        );
      },
    );
  }

  //? ============================================================
  //? STEP 3: RESET PASSWORD SCREEN
  // Endpoint: /api/v1/auth/reset-password
  //? ============================================================
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    // GUARD: Ensure resetToken exists
    if (state.resetToken == null) {
      emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          errorMessage: 'Security token missing. Please verify your OTP again.',
        ),
      );
      return;
    }
    // Result should update status to .success and store successMessage upon success
    // UI Listener: if (state.status == PasswordResetStatus.success) -> Go to Login view
    final String resetToken = state.resetToken!;

    emit(state.copyWith(status: PasswordResetStatus.loading));

    final result = await _authRepo.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmNewPassword: confirmPassword,
    );
    result.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.success,
            successMessage: successMessage,
          ),
        );
      },
    );
  }

  //* ============================================================
  //* HELPER: RESEND CODE (OTP SCREEN)
  // Endpoint: /api/v1/auth/resend-code
  //* ============================================================
  Future<void> resendCode() async {
    // If user refreshed the page, email might be lost.
    // This prevents the app from crashing.
    if (state.email == null) {
      emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          errorMessage: 'Session expired. Please back and re-enter your email.',
        ),
      );
      return;
    }
    // Implementation for resending code using state.email
    final String email = state.email!;
    final String action = ApiValues.resetPassword;

    emit(state.copyWith(status: PasswordResetStatus.loading));

    final result = await _authRepo.resendOTP(email: email, action: action);
    result.fold(
      (errorMessage) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: PasswordResetStatus.codeResent,
          ),
        );
      },
    );
  }
}
