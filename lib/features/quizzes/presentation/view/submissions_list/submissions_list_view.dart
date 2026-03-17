import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/mobile/submissions_list_mobile_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/web/submissions_list_web_layout.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/grading_cubit/grading_cubit.dart';

class SubmissionsListView extends StatelessWidget {
  const SubmissionsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GradingCubit, GradingState>(
      listener: (context, state) {
        // TODO: Implement listener logic for GradingFailure and GradingSuccess later
      },
      builder: (context, state) {
        return AdaptiveLayout(
          mobileLayout: (context) => const SubmissionsListMobileLayout(),
          webLayout: (context) => const SubmissionsListWebLayout(),
        );
      },
    );
  }
}
