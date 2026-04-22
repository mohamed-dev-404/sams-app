import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_tap_view/widget/web/web_assignment_card.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_fetch/assignment_fetch_cubit.dart';

class AssignmentsWebLayout extends StatelessWidget {
  final String courseId;
  final List<AssignmentModel> assignments;
  final UserRole userRole;

  const AssignmentsWebLayout({
    super.key,
    required this.courseId,
    required this.assignments,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInstructor = userRole == UserRole.instructor;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assignments',
            style: AppStyles.mobileTitleSmallSb.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 24),

          if (assignments.isEmpty && !isInstructor)
            _buildStudentEmptyState()
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _calculateItemCount(isInstructor),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 400 / 440,
              ),
              itemBuilder: (context, index) {
                if (isInstructor && index == 0) {
                  return AddNewCard(
                    title: 'Create Assignment',
                    hight: double.infinity,
                    onTap: () => _navigateToCreateAssignment(context),
                  );
                }

                if (isInstructor && assignments.isEmpty && index == 1) {
                  return _buildInstructorEmptyPlaceholder();
                }

                final int dataIndex = isInstructor ? index - 1 : index;

                if (dataIndex < 0 || dataIndex >= assignments.length) {
                  return isInstructor
                      ? _buildInstructorEmptyPlaceholder()
                      : const SizedBox.shrink();
                }

                final assignment = assignments[dataIndex];
                return WebAssignmentCard(
                  assignment: assignment,
                  onTap: () =>
                      _navigateToAssignmentDetails(context, assignment.id),
                );
              },
            ),
        ],
      ),
    );
  }

  int _calculateItemCount(bool isInstructor) {
    if (isInstructor) {
      return assignments.isEmpty ? 2 : assignments.length + 1;
    }
    return assignments.length;
  }

  Widget _buildStudentEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            'No assignments available yet.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorEmptyPlaceholder() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 12),
        Text(
          'Your assignment list is empty',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void _navigateToCreateAssignment(BuildContext context) {
    context
        .push(
          RoutesName.createAssignment,
          extra: {
            'courseId': courseId,
            'isEditMode': false,
          },
        )
        .then((_) {
          if (context.mounted) {
            context.read<AssignmentFetchCubit>().fetchAssignments(
              courseId: courseId,
            );
          }
        });
  }

  void _navigateToAssignmentDetails(BuildContext context, String assignmentId) {
    context
        .push(
          RoutesName.assignmentDetails,
          extra: {
            'assignmentId': assignmentId.toString(),
            'courseId': courseId,
          },
        )
        .then((_) {
          if (context.mounted) {
            context.read<AssignmentFetchCubit>().fetchAssignments(
              courseId: courseId,
            );
          }
        });
  }
}
