// // ignore_for_file: curly_braces_in_flow_control_structures
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sams_app/core/helper/app_toast.dart';
// import 'package:sams_app/core/utils/colors/app_colors.dart';
// import 'package:sams_app/core/utils/configs/size_config.dart';
// import 'package:sams_app/core/utils/styles/app_styles.dart';
// import 'package:sams_app/core/widgets/base/custom_app_button.dart';
// import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
// import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/shared/submission_section.dart';
// import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/shared/uploading_overlay.dart';
// import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_details/assignment_details_cubit.dart';
// import 'package:sams_app/features/assignments/presentation/view_model/cubits/assignment_details/assignment_details_state.dart';

// class StudentSubmissionDialog extends StatefulWidget {
//   final String courseId;
//   final AssignmentModel assignment;
//   final String assignmentId;
//   final String classworkId;
//   final bool checkPlagiarism;
//   final bool hasPreviousSubmission;

//   const StudentSubmissionDialog({
//     super.key,
//     required this.courseId,
//     required this.assignmentId,
//     required this.classworkId,
//     required this.checkPlagiarism,
//     this.hasPreviousSubmission = false,
//     required this.assignment,
//   });

//   @override
//   State<StudentSubmissionDialog> createState() =>
//       _StudentSubmissionDialogState();
// }

// class _StudentSubmissionDialogState extends State<StudentSubmissionDialog> {
//   final GlobalKey<SubmissionSectionState> _sectionKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     final bool isMobile = SizeConfig.isMobile(context);

//     return Stack(
//       children: [
//         AlertDialog(
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           title: Text(
//             'Submit Assignment',
//             style: isMobile
//                 ? AppStyles.mobileTitleSmallSb
//                 : AppStyles.mobileTitleMediumSb,
//           ),
//           backgroundColor: AppColors.whiteLight,
//           content: SizedBox(
//             width: 600,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (widget.checkPlagiarism) _buildPlagiarismHint(),

//                   const SizedBox(height: 8),
//                   Text(
//                     'Attach your solution files below:',
//                     style: AppStyles.mobileBodySmallRg.copyWith(
//                       color: AppColors.secondary,
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   SubmissionSection(
//                     key: _sectionKey,
//                     initialItems: const [],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             _buildActions(context),
//           ],
//         ),

//         BlocBuilder<AssignmentDetailsCubit, AssignmentDetailsState>(
//           builder: (context, state) {
//             if (state is StudentSubmissionLoading)
//               return const UploadingOverlay();
//             return const SizedBox.shrink();
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildPlagiarismHint() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.amber.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.warning_amber_rounded,
//             color: StatusColors.orange,
//             size: 20,
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               'Plagiarism check is ON. You can only submit ONE file, it must be a WORD file.',
//               style: AppStyles.mobileBodyXsmallRg.copyWith(
//                 color: StatusColors.orange,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActions(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: CustomAppButton(
//             label: 'Cancel',
//             height: 44,
//             textColor: AppColors.primaryDark,
//             backgroundColor: AppColors.secondaryLight,
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: CustomAppButton(
//             label: 'Submit',
//             height: 44,
//             textColor: Colors.white,
//             backgroundColor: AppColors.primary,
//             onPressed: _handleSubmit,
//           ),
//         ),
//       ],
//     );
//   }

//   void _handleSubmit() {
//     final pickedFiles = _sectionKey.currentState?.allPickedFiles ?? [];

//     if (pickedFiles.isEmpty) {
//       AppToast.warning(context, 'Please attach your work first.');
//       return;
//     }

//     if (widget.checkPlagiarism) {
//       if (widget.hasPreviousSubmission) {
//         AppToast.error(
//           context,
//           'You have already submitted a file. Please unsubmit it first to upload a new one.',
//         );
//         return;
//       }

//       if (pickedFiles.length > 1) {
//         AppToast.error(
//           context,
//           'Plagiarism check is active: You are only allowed to upload ONE file.',
//         );
//         return;
//       }

//       final file = pickedFiles.first;
//       final String name = file.name;
//       final String extension = name.split('.').last.toLowerCase();
//       const allowedDocExtensions = ['doc', 'docx'];
      
//       if (!allowedDocExtensions.contains(extension)) {
//         AppToast.error(
//           context,
//           'Invalid file type. Please upload a Word document.',
//         );
//         return;
//       }
//     }

//     context.read<AssignmentDetailsCubit>().submitAssignment(
//       courseId: widget.courseId,
//       assignmentId: widget.assignmentId,
//       classworkId: widget.classworkId,
//       files: pickedFiles,
//     );
//   }
// }
