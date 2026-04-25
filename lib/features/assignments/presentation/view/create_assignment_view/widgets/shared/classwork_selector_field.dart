import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/shared/classwork_picker_dialog.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/create_assignment/create_assignment_cubit.dart';
import 'package:sams_app/features/assignments/presentation/view_model/cubits/create_assignment/create_assignment_state.dart';

/// A tap-able field that looks like a text input but opens a picker
/// dialog / bottom-sheet for choosing a classwork within the Assignment flow.
class ClassworkSelectorField extends StatelessWidget {
  const ClassworkSelectorField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAssignmentCubit, CreateAssignmentState>(
      buildWhen: (_, current) =>
          current is CreateAssignmentUIUpdated ||
          current is CreateAssignmentInitial,
      builder: (context, state) {
        final selectedClasswork = context
            .read<CreateAssignmentCubit>()
            .selectedClasswork;

        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _openPicker(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryDark,
              ),
            ),
            child: selectedClasswork != null
                ? _buildSelectedLabel(
                    selectedClasswork.name,
                    selectedClasswork.points,
                  )
                : _buildPlaceholder(),
          ),
        );
      },
    );
  }

  void _openPicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    ClassworkPickerDialog.show(context);
  }

  Widget _buildSelectedLabel(String name, num points) {
    return Text(
      '$name  •  $points pts',
      style: AppStyles.mobileBodySmallMd.copyWith(
        color: AppColors.primaryDarkHover,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Text(
      'Select assigned classwork',
      style: AppStyles.mobileBodySmallRg.copyWith(
        color: AppColors.whiteDarkHover,
      ),
    );
  }
}
