import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_dialogs.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_state.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/widgets/mobile/activate_account_mobile_layout.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/widgets/web/activate_account_web_layout.dart';

class ActivateAccountView extends StatelessWidget {
  const ActivateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.failure) {
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'unexpected error, please try again later.',
          );
        } else if (state.status == SignUpStatus.success) {
          AppDialog.showSuccess(
            context,
            title: 'Congratulations!',
            message:
                state.successMessage ??
                'Your account has been verified. You can now log in to access your courses.',
            onTap: () {
               // 1. Dismiss the dialog first
              context.pop();

              // 2. Then navigate to the login screen
              context.go(RoutesName.login);
            },
          );
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const ActivateAccountMobileLayout(),
          webLayout: (context) => const ActivateAccountWebLayout(),
        );
      },
    );
  }
}
