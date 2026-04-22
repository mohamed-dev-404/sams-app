import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/widgets/shared/adaptive_layout.dart';
import 'package:sams_app/features/assignments/data/model/helper/mock_data.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/mobile/instructor/assignment_details_mobile_instructor_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/mobile/student/assignment_details_mobile_student_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/web/instructor/assignment_details_web_instructor_layout.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_details_view/widgets/web/student/assignment_details_web_student_layout.dart';

class AssignmentDetailsView extends StatelessWidget {
  final String assignmentId;
  final String courseId;

  const AssignmentDetailsView({
    super.key,
    required this.assignmentId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    
    final assignment = mockAssignments.firstWhere(
      (a) => a.id == assignmentId,
      orElse: () => mockAssignments.first,
    );

    // * UI Direct Rendering (No Bloc/Cubit)
    return AdaptiveLayout(
      // --- Mobile Layouts ---
      mobileLayout: (context) => CurrentRole.role == UserRole.instructor
          ? AssignmentDetailsMobileInstructorLayout(
              assignment: assignment,
              courseId: courseId,
            )
          : AssignmentDetailsMobileStudentLayout(
              assignment: assignment,
              courseId: courseId,
            ),

      // --- Web Layouts (Desktop/Tablet) ---
      webLayout: (context) => CurrentRole.role == UserRole.instructor
          ? AssignmentDetailsWebInstructorLayout(
              assignment: assignment,
              courseId: courseId,
            )
          : AssignmentDetailsWebStudentLayout(
              assignment: assignment,
              courseId: courseId,
            ),
    );
  }
}
