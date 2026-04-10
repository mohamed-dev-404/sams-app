import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/presentation/views/create_course/widgets/shared/input_field_title.dart';

class AddAnnouncementSection extends StatelessWidget {
  const AddAnnouncementSection({
    super.key,
    required this.titleController,
    required this.contentController,
  });
  final TextEditingController titleController;
  final TextEditingController contentController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.whiteLight,
        border: Border.all(color: AppColors.secondary, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Announcement Information',
              style: AppStyles.mobileBodyLargeSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title cannot be empty';
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter announcement title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Announcement Description',
              style: AppStyles.mobileTitleXsmallMd.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Content cannot be empty';
                }
                return null;
              },
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter announcement content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
