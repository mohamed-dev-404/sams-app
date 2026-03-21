import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sams_app/core/utils/assets/app_lottie.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/all_submission_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/shared/submission_list_tile.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/shared/submissions_stats_bar.dart';

class SubmissionsListWebLayout extends StatelessWidget {
  const SubmissionsListWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final markedList = mockSubmissions
        .where((e) => e.status == SubmissionStatus.marked)
        .toList();
    final unmarkedList = mockSubmissions
        .where((e) => e.status == SubmissionStatus.unmarked)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Row(
        children: [
          // Optional: Side Navigation would go here
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1300),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(32),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Lottie.asset(
                                    AppLottie.quizSubmissions,
                                    width: 250,
                                  ),
                                  Text(
                                    'Submissions Overview',
                                    style: AppStyles.mobileBodyXXlargeMd
                                        .copyWith(
                                          color: AppColors.primaryDark,
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            SubmissionsStatsBar(
                              totalSubmitted: mockSubmissions.length,
                              totalMarked: markedList.length,
                              totalUnmarked: unmarkedList.length,
                            ),

                            const SizedBox(height: 48),

                            // --- UNMARKED SECTION ---
                            if (unmarkedList.isNotEmpty) ...[
                              _buildSectionTitle(
                                'Needs Immediate Review',
                                StatusColors.orangeDark,
                              ),
                              const SizedBox(height: 20),
                              _buildResponsiveGrid(context, unmarkedList),
                              const SizedBox(height: 48),
                            ],

                            // --- MARKED SECTION ---
                            if (markedList.isNotEmpty) ...[
                              _buildSectionTitle(
                                'Graded Submissions',
                                StatusColors.green,
                              ),
                              const SizedBox(height: 20),
                              _buildResponsiveGrid(context, markedList),
                            ],
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(title, style: AppStyles.mobileBodyXXlargeMd),
      ],
    );
  }

  Widget _buildResponsiveGrid(
    BuildContext context,
    List<AllSubmissionModel> list,
  ) {
    double width = MediaQuery.of(context).size.width;
    // Determine column count based on available width
    int crossAxisCount = width > 1100 ? 3 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 110, // Fixed height for tiles in grid
      ),
      itemBuilder: (context, index) => SubmissionListTile(
        submission: list[index],
        maxScore: 10,
        onTap: () {
          //TODO nav to Grading
        },
      ),
    );
  }
}
