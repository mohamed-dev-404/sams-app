import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_dialogs.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:sams_app/features/auth/presentation/view_models/sign_up_cubit/sign_up_state.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/widgets/mobile/sign_up_mobile_layout.dart';
import 'package:sams_app/features/auth/presentation/views/sign_up/widgets/web/sign_up_web_layout.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.failure) {
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'unexpected error, please try again later.',
          );
        } else if (state.status == SignUpStatus.codeSent) {
          AppDialog.showSuccess(
            context,
            title: 'Congratulations!',
            message:
                state.codeSentMessage ??
                'Registration successful! Please check your email to activate your account.',
            onTap: () {
              // 1. Dismiss the dialog first
              context.pop();

              // 2. Then navigate to the activate account screen
              context.push(RoutesName.activateAccount);
            },
          );
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const SignUpMobileLayout(),
          webLayout: (context) => const SignUpWebLayout(),
        );
      },
    );
  }
}
