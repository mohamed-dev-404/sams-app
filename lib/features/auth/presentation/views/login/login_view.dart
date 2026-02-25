import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/login_cubit/login_state.dart';
import 'package:sams_app/features/auth/presentation/views/login/widgets/mobile/login_mobile_layout.dart';
import 'package:sams_app/features/auth/presentation/views/login/widgets/web/login_web_layout.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          AppSnackBar.error(context, state.errorMessage);
        } else if (state is LoginSuccess) {
          // final at = await SecureStorageService.instance.getAccessToken();
          // final email = await GetStorageHelper.read(CacheKeys.academicEmail);
          // final name = await GetStorageHelper.read(CacheKeys.name);
          // final role = await GetStorageHelper.read(CacheKeys.role);
          // final isStudent = await GetStorageHelper.read(CacheKeys.isStudent);
          // log(at!);
          // log(email);
          // log(name);
          // log(role);
          // log(isStudent.toString());
          context.go(RoutesName.test); //todo: should navigate to home
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const LoginMobileLayout(),
          webLayout: (context) => const LoginWebLayout(),
        );
      },
    );
  }
}
