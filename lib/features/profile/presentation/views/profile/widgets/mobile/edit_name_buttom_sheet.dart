import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/functions/hide_keyboard.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:sams_app/features/profile/presentation/view_model/cubit/profile_state.dart';

//* A bottom sheet widget for updating a user's name on a mobile device.
class EditNameButtonSheet extends StatefulWidget {
  final String currentName;

  const EditNameButtonSheet({super.key, required this.currentName});

  @override
  State<EditNameButtonSheet> createState() => _UpdateNameBottomSheetState();
}

class _UpdateNameBottomSheetState extends State<EditNameButtonSheet> {
  late TextEditingController nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 24,
        right: 24,
        top: 12,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Visual drag handle for better UX
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              'Edit Your Name',
              style: AppStyles.mobileTitleMediumSb.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: nameController,
              prefixIcon: const Icon(Icons.person_outline),
              hintText: 'Full Name',
              textFieldType: TextFieldType.normal,
            ),
            const SizedBox(height: 16),
            Text(
              '• Please enter your full name as it should appear on official academic records and communications.',
              style: AppStyles.mobileBodySmallRg.copyWith(
                color: AppColors.primaryDark.withAlpha(220),
              ),
            ),
            const SizedBox(height: 32),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is UpdateNameSuccess) {
                  Navigator.pop(context);
                  hideKeyboard(context);
                }
              },
              builder: (context, state) {
                if (state is UpdateNameLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondary,
                    ),
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: CustomAppButton(
                        label: 'Cancel',
                        height: 42,
                        textColor: AppColors.primaryDark,
                        backgroundColor: AppColors.secondaryLight,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomAppButton(
                        label: 'Save',
                        height: 42,
                        onPressed: () => _handleSave(context),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleSave(BuildContext context) {
    final newName = nameController.text.trim();
    if (newName.isNotEmpty && newName != widget.currentName) {
      context.read<ProfileCubit>().updateName(newName);
    } else {
      Navigator.pop(context);
    }
  }
}
