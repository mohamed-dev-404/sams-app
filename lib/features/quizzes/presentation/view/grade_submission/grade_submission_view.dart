import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/mobile/grade_submission_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/grade_submission/widgets/web/grade_submission_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/grading_cubit/grading_cubit.dart';

class GradeSubmissionView extends StatefulWidget {
  final String submissionId;

  const GradeSubmissionView({
    super.key,
    required this.submissionId,
  });

  @override
  State<GradeSubmissionView> createState() => _GradeSubmissionViewState();
}

class _GradeSubmissionViewState extends State<GradeSubmissionView> {
  @override
  void initState() {
    super.initState();
    // Start fetching data immediately
    context.read<GradingCubit>().loadSubmissionDetails(widget.submissionId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GradingCubit, GradingState>(
      listener: (context, state) {
        // Show SnackBar if save/load fails
        if (state is GradingFailure) {
          AppSnackBar.error(
            context,
            state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => GradeSubmissionMobileLayout(
            submissionId: widget.submissionId,
          ),
          webLayout: (context) => GradeSubmissionWebLayout(
            submissionId: widget.submissionId,
          ),
        );
      },
    );
  }
}
