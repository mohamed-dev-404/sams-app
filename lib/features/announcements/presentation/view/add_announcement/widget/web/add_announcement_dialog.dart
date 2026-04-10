import 'package:flutter/material.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_button.dart';
import 'package:sams_app/features/announcements/presentation/view/add_announcement/widget/shared/add_announcement_section.dart';

class AddAnnouncementDialog extends StatefulWidget {
  const AddAnnouncementDialog({super.key});

  @override
  State<AddAnnouncementDialog> createState() => _AddAnnouncementDialogState();
}

class _AddAnnouncementDialogState extends State<AddAnnouncementDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // void _submit() {
  //   if (_formKey.currentState!.validate()) {
  //     // TODO: handle submission
  //     Navigator.of(context).pop({
  //       'title': _titleController.text.trim(),
  //       'description': _descriptionController.text.trim(),
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 550,
        padding: const EdgeInsets.all(28),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Title ──
              Center(
                child: Text(
                  'Announcement Information',
                  style: AppStyles.webTitleMediumSb.copyWith(
                    color: AppColors.primaryDarkHover,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Announcement Title Field ──
               AddAnnouncementSection(titleController: _titleController, contentController: _descriptionController),
              const SizedBox(height: 30),
              // ── Submit Button ──
              AppButton(
                model: AppButtonStyleModel(
                  height: 40,
                  width: 250,
                  label: 'Add Announcement',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    // TODO: context.read<AnnouncementsCubit>().addAnnouncement(...)
                  }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

