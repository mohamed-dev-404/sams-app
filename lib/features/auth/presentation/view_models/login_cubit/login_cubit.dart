import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/features/auth/data/repos/auth_repo.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _authRepo.login(email: email, password: password);

    result.fold(
      (errorMessage) {
        emit(LoginFailure(errorMessage));
      },
      (loginModel) {
        emit(LoginSuccess(loginModel));
      },
    );
  }
}
