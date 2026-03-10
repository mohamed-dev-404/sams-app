import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/widgets/mobile/forgot_password_mobile_layout.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/widgets/web/forgot_password_web_layout.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordResetCubit, PasswordResetState>(
      listener: (context, state) {
        if (state.status == PasswordResetStatus.failure) {
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'unexpected error, please try again later.',
          );
        } else if (state.status == PasswordResetStatus.codeSent) {
          context.push(RoutesName.verifyOtp);
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const ForgotPasswordMobileLayout(),
          webLayout: (context) => const ForgotPasswordWebLayout(),
        );
      },
    );
  }
}
