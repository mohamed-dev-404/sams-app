import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/shared/add_classwork_dialog.dart';
import 'package:sams_app/features/quizzes/presentation/view/create_quiz/widgets/shared/classwork_list_content.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/create_assignment/create_assignment_cubit.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/create_assignment/create_assignment_state.dart';

/// Opens the classwork picker for Assignments as a **dialog** (web ≥ 500px)
/// or **bottom-sheet** (mobile < 500px).
class ClassworkPickerDialog {
  ClassworkPickerDialog._();

  /// Entry point — using CreateAssignmentCubit
  static void show(BuildContext context) {
    final cubit = context.read<CreateAssignmentCubit>();

    // Trigger the fetch from the shared repo logic
    cubit.getAvailableClassworks();

    final isWide = MediaQuery.of(context).size.width >= 500;

    if (isWide) {
      _showAsDialog(context, cubit);
    } else {
      _showAsBottomSheet(context, cubit);
    }
  }

  static void _showAsDialog(BuildContext context, CreateAssignmentCubit cubit) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.whiteLight,
          child: const SizedBox(
            width: 500,
            child: _PickerBody(showHandle: false),
          ),
        ),
      ),
    );
  }

  static void _showAsBottomSheet(
    BuildContext context,
    CreateAssignmentCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _PickerBody(showHandle: true),
      ),
    );
  }
}

class _PickerBody extends StatelessWidget {
  final bool showHandle;

  const _PickerBody({required this.showHandle});

  @override
  Widget build(BuildContext context) {
    final maxContentHeight = MediaQuery.of(context).size.height * 0.55;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxContentHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              Flexible(child: _buildScrollableContent(context)),
              _buildAddButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showHandle) ...[
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
      ],
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    final cubit = context.read<CreateAssignmentCubit>();

    return BlocBuilder<CreateAssignmentCubit, CreateAssignmentState>(
      buildWhen: (_, curr) =>
          curr is AvailableClassworksLoading ||
          curr is AvailableClassworksLoaded ||
          curr is AvailableClassworksFailure,
      builder: (context, state) {
        final ClassworkListStatus status;
        final String? errorMessage;
        final items = state is AvailableClassworksLoaded
            ? state.classworks
            : const [];

        if (state is AvailableClassworksFailure) {
          status = ClassworkListStatus.error;
          errorMessage = state.message;
        } else if (state is AvailableClassworksLoaded) {
          status = ClassworkListStatus.loaded;
          errorMessage = null;
        } else {
          status = ClassworkListStatus.loading;
          errorMessage = null;
        }

        return SingleChildScrollView(
          child: ClassworkListContent(
            status: status,
            items: List.from(items),
            selectedId: cubit.selectedClasswork?.id,
            errorMessage: errorMessage,
            onSelected: (item) {
              cubit.onClassworkSelected(item);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Center(
        child: InkWell(
          onTap: () => AddClassworkDialog.show(context),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
