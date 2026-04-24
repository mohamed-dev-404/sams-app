import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sams_app/core/utils/assets/app_lottie.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/mobile/mobile_custom_app_bar.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_submission/shared/approve_all_button.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_submission/shared/assign_submission_states_bar.dart';
import 'package:sams_app/features/assignments/presentation/view/assignment_submission/shared/submission_card.dart';

class AssignmentSubmissionMobileLayout extends StatelessWidget {
  const AssignmentSubmissionMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileCustomAppBar(
        title: 'Assignmet Submission',
        titleStyle: TextStyle(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: AppColors.secondaryLightActive),
                ),
                child: Column(
                  children: [
                    Lottie.asset(AppLottie.quizSubmissions),

                    const SizedBox(height: 8),
                    Text(
                      'Submissions Overview',
                      style: AppStyles.mobileTitleSmallSb,
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            const SliverToBoxAdapter(
              child: AssignSubmissionsStatsBar(
                totalSubmitted: 10,
                totalMarked: 7,
                totalUnmarked: 3,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SubmissionCard(
                    studentName: 'Nadia Ashraf',
                    academicId: '20201234',
                    formattedTime: '2 hours ago',
                    displayScore: '85',
                    maxScore: '100',
                    onTap: () {
                      context.push(
                        RoutesName.studentProfile,
                        extra: {
                          'assignmentId': 'assignment_01',
                          'courseId': 'course_01',
                        },
                      );
                    },
                    isGraded: index % 2 == 0,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  width: 180,
                  child: ApproveAllButton(
                    onTap: () {},
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}
