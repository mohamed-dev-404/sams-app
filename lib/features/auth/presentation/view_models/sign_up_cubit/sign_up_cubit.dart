import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';
import 'package:sams_app/features/auth/data/repos/auth_repo.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo _authRepo;

  SignUpCubit(this._authRepo) : super(const SignUpState());

  //* STEP 1: Register (Sends OTP to email)
  Future<void> register({
    required String fullName,
    required String email,
    required String id,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    final result = await _authRepo.signUp(
      academicEmail: email,
      academicId: id,
      fullName: fullName,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (codeSentMessage) => emit(
        state.copyWith(
          status: SignUpStatus.codeSent,
          codeSentMessage: codeSentMessage,
          email: email,
        ),
      ),
    );
  }

  //* STEP 2: Verify OTP to activate account
  Future<void> verifyAccount({required String otp}) async {
    if (state.email == null) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: 'Session timed out. Please request a new code.',
        ),
      );
      return;
    }

    final String email = state.email!;
    final String action = ApiValues.activateAccount;

    emit(state.copyWith(status: SignUpStatus.loading));

    final result = await _authRepo.verifyOtp(
      email: email,
      otp: otp,
      action: action,
    );

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (successMessage) => emit(
        state.copyWith(
          status: SignUpStatus.success,
          successMessage: successMessage,
        ),
      ),
    );
  }

  //* HELPER: Resend Code
  Future<void> resendCode() async {
    if (state.email == null) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: 'Session expired. Please back and re-enter your email.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: SignUpStatus.loading));

    final String email = state.email!;
    final String action = ApiValues.activateAccount;

    final result = await _authRepo.resendOTP(
      email: email,
      action: action,
    );

    result.fold(
      (errorMessage) => emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(status: SignUpStatus.codeResent)),
    );
  }
}
