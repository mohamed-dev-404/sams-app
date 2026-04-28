import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_details/assignment_details_cubit.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_details/assignment_details_state.dart';

class UnsubmitAssignmentDialog {
  static void show(

    BuildContext context,{
    required VoidCallback onConfirm,required AssignmentDetailsCubit assignmentDetailsCubit
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: assignmentDetailsCubit,
        child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500,minWidth: 300),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.redLight,
                        child: Icon(
                          Icons.delete_forever_rounded,
                          color: AppColors.red,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Unsubmit Work?', style: AppStyles.mobileTitleSmallSb),
                      const SizedBox(height: 8),
                      Text(
                        'Are you sure you want to remove your submission? You will need to re-upload your files if you want to submit again.',
                        textAlign: TextAlign.center,
                        style: AppStyles.mobileBodySmallRg.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AssignmentDetailsCubit, AssignmentDetailsState>(
                        builder: (context, state) {
                          return (state is! UnsubmitAssignmentLoading)
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: AppColors.secondary),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          onConfirm();
                                        },
                                        child: Text(
                                          'Unsubmit',
                                          style: AppStyles.mobileBodySmallMd.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(child: AppAnimatedLoadingIndicator());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
