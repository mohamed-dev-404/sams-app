import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/announcements/presentation/view/announcement_details/widget/shared/comment_divider.dart';
import 'package:sams_app/features/announcements/presentation/view/announcement_details/widget/shared/comment_item.dart';
import 'package:sams_app/features/announcements/presentation/view_model/cubit/announcements_fetch/announcements_fetch_cubit.dart';
import 'package:sams_app/features/announcements/presentation/view_model/cubit/announcements_fetch/announcements_fetch_state.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementsFetchCubit, AnnouncementsFetchState>(
      builder: (context, state) {
        if (state is AnnouncementDetailsFetchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AnnouncementDetailsFetchFailure) {
          return SnackBar(
            content: Text(state.errMessage),
          );
        } else if (state is AnnouncementFetchDetailsSuccess) {
          final announcementDetails = state.announcementDetails;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    announcementDetails.comments.isEmpty
                        ? 'No Comments'
                        : 'Comments',
                    style: AppStyles.web30Regular.copyWith(
                      color: AppColors.primaryDarkHover,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: announcementDetails.comments.isEmpty
                          ? Colors.transparent
                          : AppColors.primaryDarkHover,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      announcementDetails.comments.isEmpty
                          ? ''
                          : announcementDetails.comments.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: announcementDetails.comments.length,
                itemBuilder: (context, index) {
                  final comment = announcementDetails.comments[index];
                  return Column(
                    children: [
                      CommentItem(
                        name: comment.userName,
                        date: comment.date,
                        text: comment.content,
                      ),
                      const CommentDivider(),
                    ],
                  );
                },
              ),
              // const CommentItem(
              //   name: 'Nadia Ashraf',
              //   date: 'Mar 5',
              //   text:
              //       'The make-up quiz will be held tomorrow at 8:45 AM in lab 6302.',
              // ),
              // const CommentDivider(),
              // const CommentItem(
              //   name: 'Nadia Ashraf',
              //   date: 'Mar 5',
              //   text:
              //       'The make-up quiz will be held tomorrow at 8:45 AM in lab 6302.',
              // ),
              // const CommentDivider(),
              // const CommentItem(
              //   name: 'Nadia Ashraf',
              //   date: 'Mar 5',
              //   text:
              //       'The make-up quiz will be held tomorrow at 8:45 AM in lab 6302.',
              // ),
              // const CommentDivider(),
              // const CommentItem(
              //   name: 'Nadia Ashraf',
              //   date: 'Mar 5',
              //   text:
              //       'The make-up quiz will be held tomorrow at 8:45 AM in lab 6302.',
              // ),
              // const CommentDivider(),
              // const CommentItem(
              //   name: 'Nadia Ashraf',
              //   date: 'Mar 5',
              //   text:
              //       'The make-up quiz will be held tomorrow at 8:45 AM in lab 6302nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnbbbbbbbb.',
              // ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
