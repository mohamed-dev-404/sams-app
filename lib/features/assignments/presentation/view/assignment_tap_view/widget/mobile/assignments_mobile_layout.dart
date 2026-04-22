import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_tap_view/widget/mobile/mobile_assignment_card.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_fetch/assignment_fetch_cubit.dart';

class AssignmentsMobileLayout extends StatelessWidget {
  final String courseId;
  final List<AssignmentModel> assignments;
  final UserRole userRole;

  const AssignmentsMobileLayout({
    super.key,
    required this.courseId,
    required this.assignments,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInstructor = userRole == UserRole.instructor;
    final int headerCount = isInstructor ? 2 : 1;

    return ListView.builder(
      itemCount: headerCount + (assignments.isEmpty ? 1 : assignments.length),
      itemBuilder: (context, index) {
        // 1. Title Section
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              'Assignments',
              style: AppStyles.mobileTitleSmallSb.copyWith(fontSize: 24),
            ),
          );
        }

        // 2. Instructor Add Button
        if (isInstructor && index == 1) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: AddNewCard(
              title: 'Create Assignment',
              isMobile: true,
              onTap: () => _navigateToCreateAssignment(context),
            ),
          );
        }

        // 3. Handle Empty State or Assignment List
        if (assignments.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'No assignments available yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          );
        }

        final int assignmentIndex = index - headerCount;
        
        // 4. Render Assignment Cards
        final assignment = assignments[assignmentIndex];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: MobileAssignmentCard(
            assignment: assignment,
            onTap: () => _navigateToAssignmentDetails(context, assignment.id),
          ),
        );
      },
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