import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_dialogs.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/widgets/mobile/reset_password_mobile_layout.dart';
import 'package:sams_app/features/auth/presentation/views/password_reset/widgets/web/reset_password_web_layout.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordResetCubit, PasswordResetState>(
      listener: (context, state) {
        if (state.status == PasswordResetStatus.failure) {
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'unexpected error, please try again later.',
          );
        } else if (state.status == PasswordResetStatus.success) {
          AppDialog.showSuccess(
            context,
            title: 'Password Reset Successfully!',
            message:
                state.successMessage ??
                'Your password has been changed. Please log in to continue to your app.',
            onTap: () {
              context.go(RoutesName.login);
            },
          );
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const ResetPasswordMobileLayout(),
          webLayout: (context) => const ResetPasswordWebLayout(),
        );
      },
    );
  }
}
