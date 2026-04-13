import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/text_field_type.dart';
import 'package:sams_app/core/models/app_button_style_model.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/base/app_button.dart';
import 'package:sams_app/core/widgets/base/app_text_field.dart';
import 'package:sams_app/core/widgets/shared/titled_input_field.dart';
import 'package:sams_app/features/home/data/models/classwork_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/classwork_item_model.dart';
import 'package:sams_app/features/quizzes/presentation/view_model/create_quiz_cubit/create_quiz_cubit.dart';

/// A tap-able field that looks like a text input but opens a bottom-sheet
/// selector for choosing a [ClassworItemkModel].
///
class ClassworkSelectorField extends StatelessWidget {
  const ClassworkSelectorField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateQuizCubit>();

    return BlocBuilder<CreateQuizCubit, CreateQuizState>(
      buildWhen: (previous, current) {
        return current is CreateQuizUIUpdated || current is CreateQuizInitial;
      },
      builder: (context, state) {
        final selectedClasswork = cubit.selectedClasswork;

        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            FocusScope.of(context).unfocus(); // Unfocus form fields
            cubit.getAvailableClassworks();
            _showClassworkSheet(context: context, cubit: cubit);
          },
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryDark,
              ),
            ),
            child: selectedClasswork != null
                ? Text(
                    '${selectedClasswork.name}  •  ${selectedClasswork.points} pts',
                    style: AppStyles.mobileBodySmallMd.copyWith(
                      color: AppColors.primaryDarkHover,
                    ),
                  )
                : Text(
                    'Select assigned classwork',
                    style: AppStyles.mobileBodySmallRg.copyWith(
                      color: AppColors.whiteDarkHover,
                    ),
                  ),
          ),
        );
      },
    );
  }

  // * ──────────────── Bottom Sheet / Dialog ────────────────

  void _showClassworkSheet({
    required BuildContext context,
    required CreateQuizCubit cubit,
  }) {
    if (MediaQuery.of(context).size.width >= 800) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return BlocProvider.value(
            value: cubit,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: AppColors.whiteLight,
              child: SizedBox(
                width: 500,
                child: _buildDialogContent(dialogContext, cubit),
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.whiteLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (sheetContext) {
          return BlocProvider.value(
            value: cubit,
            child: _buildDialogContent(sheetContext, cubit),
          );
        },
      );
    }
  }

  Widget _buildDialogContent(BuildContext context, CreateQuizCubit cubit) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Handle bar ──
            if (MediaQuery.of(context).size.width < 800) ...[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.whiteActive,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ── Title ──
            Center(
              child: Text(
                'Select Classwork',
                style: AppStyles.mobileTitleSmallSb.copyWith(
                  color: AppColors.primaryDarkHover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(color: AppColors.whiteHover, thickness: 1),
            const SizedBox(height: 4),

            // ── Dynamic Content ──
            BlocBuilder<CreateQuizCubit, CreateQuizState>(
              buildWhen: (prev, curr) => curr is GetAvailableClassworks,
              builder: (context, state) {
                if (state is GetAvailableClassworksFailure) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style:
                              AppStyles.mobileBodySmallMd.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  );
                } else if (state is GetAvailableClassworksSuccess) {
                  if (state.classworks.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.inbox_outlined,
                            color: AppColors.whiteDarkActive,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No assigned classworks found.',
                            textAlign: TextAlign.center,
                            style: AppStyles.mobileBodySmallMd.copyWith(
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return _ClassworkSelectionSheet(
                    items: state.classworks,
                    selectedId: cubit.selectedClasswork?.id,
                    onSelected: (item) {
                      cubit.onClassworkSelected(item);
                      Navigator.of(context).pop();
                    },
                  );
                }

                // Default / Loading State
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: AppAnimatedLoadingIndicator(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ! ══════════════════════════════════════════════════════════════
// !  Bottom-Sheet or Dialog Content
// ! ══════════════════════════════════════════════════════════════

class _ClassworkSelectionSheet extends StatelessWidget {
  final List<ClassworkItemModel> items;
  final String? selectedId;
  final ValueChanged<ClassworkItemModel> onSelected;

  const _ClassworkSelectionSheet({
    required this.items,
    required this.selectedId,
    required this.onSelected,
  });

  Future<ClassworkModel?> showAddClassworkDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController pointsController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showDialog<ClassworkModel>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TitledInputField(
                    label: 'Quiz Title',
                    child: AppTextField(
                      hintText: 'e.g. Quiz 3',
                      controller: nameController,
                      textFieldType: TextFieldType.normal,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TitledInputField(
                    label: 'Total Marks',
                    child: AppTextField(
                      hintText: 'e.g. 5',
                      controller: pointsController,
                      textFieldType: TextFieldType.numerical,
                    ),
                  ),
                  const SizedBox(height: 24),

                  AppButton(
                    model: AppButtonStyleModel(
                      label: 'Done',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final newClasswork = ClassworkModel(
                            name: nameController.text.trim(),
                            points: double.parse(pointsController.text.trim()),
                          );
                          // TODO hit the post now class work
                          Navigator.of(context).pop(newClasswork);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Items ──
        ...items.map((item) {
              final bool isSelected = item.id == selectedId;
              return _ClassworkTile(
                item: item,
                isSelected: isSelected,
                onTap: () => onSelected(item),
              );
            }),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();

                    final ClassworkModel? newClasswork =
                        await showAddClassworkDialog(context);

                    if (newClasswork != null) {
                      // Here you can do the following:
                      // - Update the UI to add the new item to the list (using setState or Bloc/Provider).
                      // - Call the API (POST request) that you attached in the Postman screenshot to upload the new classwork to the server.

                      print(
                        'Created Classwork: ${newClasswork.name} with ${newClasswork.points} points',
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

// ! ══════════════════════════════════════════════════════════════
// !  Single Tile
// ! ══════════════════════════════════════════════════════════════

class _ClassworkTile extends StatelessWidget {
  final ClassworkItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClassworkTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryLight : AppColors.whiteLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.whiteHover,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.secondary
                      : AppColors.whiteDarkHover,
                  width: 2,
                ),
                color: isSelected ? AppColors.secondary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),

            // Name & points
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppStyles.mobileBodySmallMd.copyWith(
                      color: isSelected
                          ? AppColors.primaryDarkHover
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.points} points',
                    style: AppStyles.mobileBodyXsmallRg.copyWith(
                      color: AppColors.whiteDarkActive,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
