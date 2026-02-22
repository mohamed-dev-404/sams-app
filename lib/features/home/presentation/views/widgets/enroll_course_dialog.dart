import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/app_button.dart';
import 'package:sams_app/core/widgets/app_error_dialog.dart';
import 'package:sams_app/core/widgets/app_success_dialog.dart';
import 'package:sams_app/core/widgets/app_text_field.dart';
import 'package:sams_app/features/home/data/models/join_course_model.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:sams_app/features/home/presentation/view_models/cubit/home_state.dart';

class EnrollCourseDialog extends StatefulWidget {
  const EnrollCourseDialog({super.key});

  @override
  State<EnrollCourseDialog> createState() => _EnrollCourseDialogState();
}

class _EnrollCourseDialogState extends State<EnrollCourseDialog> {
  final TextEditingController _inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Center(child: Text('Enter Course Code')),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            prefixIcon: const Icon(Icons.fact_check),
            hintText: 'D3dfx5',
            textFieldType: TextFieldType.normal,
            controller: _inviteCodeController,
          ),
          const SizedBox(height: 16),
          Text(
            'to sign in with a course code\n• Use an authorised account\n• Use a class code with ( 6 ) letters or numbers without spaces or symbols',
            style: AppStyles.mobileBodyMediumRg.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: _handleJoinStates,
            builder: (context, state) {
              if (state is JoinCourseLoading) {
                return const CircularProgressIndicator(
                  color: AppColors.primaryDarkHover,
                );
              }
              return AppButton(
                model: AppButtonStyleModel(
                  height: 55,
                  width: 230,
                  label: 'Join Course',
                  onPressed: () =>
                      _onJoinPressed(context), 
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _onJoinPressed(BuildContext context) {
    final code = _inviteCodeController.text.trim();
    if (code.isNotEmpty) {
      context.read<HomeCubit>().joinCourse(
        model: JoinCourseModel(invitationCode: code),
      );
    }
  }

  void _handleJoinStates(BuildContext context, HomeState state) {
    if (state is JoinCourseSuccess) {
      Navigator.pop(context); 
      _showResultDialog(
        context,
        dialog: AppSuccessDialog(
          title: 'Join Course Successfully',
          message: state.message,
          onTapped: () => Navigator.pop(context),
        ),
      );
    } else if (state is JoinCourseFailure) {
      _showResultDialog(
        context,
        dialog: AppFailureDialog(
          title: 'Fail To Join Course',
          message: state.errMessage,
          onTapped: () => Navigator.pop(context),
        ),
      );
    }
  }

  void _showResultDialog(BuildContext context, {required Widget dialog}) {
    showDialog(context: context, builder: (context) => dialog);
  }
}
