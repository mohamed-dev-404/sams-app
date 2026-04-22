import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_tap_view/widget/mobile/assignments_mobile_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_tap_view/widget/web/assignments_web_layout.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_fetch/assignment_fetch_cubit.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_fetch/assignment_fetch_state.dart';

class AssignmentsTabView extends StatelessWidget {
  final String courseId;
  const AssignmentsTabView({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentFetchCubit, AssignmentFetchState>(
      builder: (context, state) {
        if (state is AssignmentFetchLoading) {
          return const Center(child: AppAnimatedLoadingIndicator());
        }

        if (state is AssignmentFetchSuccess) {
          return AdaptiveLayout(
            mobileLayout: (BuildContext context) {
              return AssignmentsMobileLayout(
                courseId: courseId,
                assignments: state.assignments,
                userRole: CurrentRole.role,
              );
            },
            webLayout: (BuildContext context) {
              return AssignmentsWebLayout(
                courseId: courseId,
                assignments: state.assignments,
                userRole: CurrentRole.role,
              );
            },
          );
        }

        if (state is AssignmentFetchFailure) {
          return Center(
            child: Text(
              state.errMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
