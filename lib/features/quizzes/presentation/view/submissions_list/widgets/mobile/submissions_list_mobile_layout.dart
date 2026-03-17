import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/quizzes/data/mock_data.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/all_submission_model.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/shared/submission_list_tile.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/mobile/submissions_header_card.dart';
import 'package:sams_app/features/quizzes/presentation/view/submissions_list/widgets/shared/submissions_stats_bar.dart';

class SubmissionsListMobileLayout extends StatelessWidget {
  const SubmissionsListMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final totalSubmitted = mockSubmissions.length;

    final markedList = mockSubmissions
        .where(
          (e) => e.status == SubmissionStatus.marked,
        )
        .toList();

    final unmarkedList = mockSubmissions
        .where(
          (e) => e.status == SubmissionStatus.unmarked,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_circle_left_outlined),
        ),
        title: const Text('Quiz 1'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SubmissionsHeaderCard(),
            const SizedBox(height: 24),

            //* The stats overview
            SubmissionsStatsBar(
              totalSubmitted: totalSubmitted,
              totalMarked: markedList.length,
              totalUnmarked: unmarkedList.length,
            ),
            const SizedBox(height: 32),

            //* --- UNMARKED SECTION ---
            if (unmarkedList.isNotEmpty) ...[
              _buildSectionTitle('Needs Review', StatusColors.orangeDark),
              const SizedBox(height: 16),
              _buildSubmissionsList(unmarkedList),
              const SizedBox(height: 32),
            ],

            //* --- MARKED SECTION ---
            if (markedList.isNotEmpty) ...[
              _buildSectionTitle('Graded', StatusColors.green),
              const SizedBox(height: 16),
              _buildSubmissionsList(markedList),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }

  /// Extracted builder method
  Widget _buildSubmissionsList(List<AllSubmissionModel> submissions) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: submissions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 110,
          child: SubmissionListTile(
            submission: submissions[index],
            maxScore: 10, // Pass your max quiz score here
            onTap: () {
              //TODO nav to Grading
            },
          ),
        );
      },
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
        Text(title, style: AppStyles.mobileBodyLargeSb),
      ],
    );
  }
}
