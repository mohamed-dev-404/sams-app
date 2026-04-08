import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_button.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/core/widgets/mobile/mobile_custom_app_bar.dart';
import 'package:sams_app/core/widgets/shared/titled_input_field.dart';
import 'package:sams_app/features/quizzes/presentation/logic/mixin_create_quiz.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/widgets/shared/classwork_selector_field.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/widgets/shared/date_time_picker_field.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/widgets/shared/duration_input_field.dart';

class CreateQuizMobileLayout extends StatefulWidget {
  const CreateQuizMobileLayout({super.key});

  @override
  State<CreateQuizMobileLayout> createState() => _CreateQuizMobileLayoutState();
}

class _CreateQuizMobileLayoutState extends State<CreateQuizMobileLayout>
    with CreateQuizLogic {
  @override
  void dispose() {
    disposeQuizControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileCustomAppBar(title: 'Create Quiz'),

      // ── Bottom Submit Button ──
      bottomNavigationBar: _buildBottomButton(),

      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              // ─────── Section Header ───────
              Text(
                'Quiz Details',
                style: AppStyles.mobileTitleSmallSb.copyWith(
                  color: AppColors.primaryDarkHover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Fill in the details to create a new quiz for your students.',
                style: AppStyles.mobileBodyXsmallRg.copyWith(
                  color: AppColors.whiteDarkActive,
                ),
              ),
              const SizedBox(height: 24),

              // ─────── Assigned Classwork ───────
              TitledInputField(
                label: 'Assigned Classwork',
                child: ClassworkSelectorField(
                  selectedClasswork: selectedClasswork,
                  classworkItems: mockClassworkItems,
                  onSelected: onClassworkSelected,
                ),
              ),
              const SizedBox(height: 20),

              // ─────── Title ───────
              TitledInputField(
                label: 'Title',
                child: AppTextField(
                  hintText: 'Enter quiz title',
                  controller: titleController,
                  textFieldType: TextFieldType.normal,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 20),

              // ─────── Description ───────
              TitledInputField(
                label: 'Description',
                child: AppTextField(
                  hintText: 'Enter a brief description (optional)',
                  controller: descriptionController,
                  textFieldType: TextFieldType.normal,
                  minLines: 3,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              const SizedBox(height: 20),

              // ─────── Start Time ───────
              TitledInputField(
                label: 'Start Time',
                child: DateTimePickerField(
                  controller: startTimeDisplayController,
                  onTap: () => pickStartDateTime(context),
                ),
              ),
              const SizedBox(height: 20),

              // ─────── Duration ───────
              TitledInputField(
                label: 'Duration',
                child: DurationInputField(controller: durationController),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  Bottom Button
  // ══════════════════════════════════════════════════════════════

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(254, 254, 254, 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: AppButton(
        model: AppButtonStyleModel(
          label: 'Create Quiz',
          onPressed: _onCreateQuizPressed,
        ),
      ),
    );
  }

  // ──────────────── Action ────────────────

  void _onCreateQuizPressed() {
    if (!validateAndPrepare()) return;

    final body = buildRequestBody();

    // TODO: Wire to Cubit —
    // context.read<ManageQuizCubit>().createQuiz(body);

    debugPrint('CreateQuizRequestBody → ${body.toJson()}');
  }
}
