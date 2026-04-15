import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

class DeleteSingleItemDialog extends StatelessWidget {
  const DeleteSingleItemDialog({
    super.key,
    required this.materialId,
    required this.itemKey,
    required this.fileName,
  });

  final String materialId;
  final String itemKey;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile(context);
    final double screenWidth = SizeConfig.screenWidth(context);

    return AlertDialog(
      backgroundColor: AppColors.whiteLight,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : screenWidth * 0.25,
        vertical: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        'Delete File?',
      ),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• Are you sure you want to delete "$fileName"?',
            style: AppStyles.mobileBodyMediumRg.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '• This action will permanently remove the file from storage.',
            style: AppStyles.mobileBodyMediumRg.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 16,
        right: 16,
      ),
      actions: [
        BlocConsumer<MaterialCrudCubit, MaterialCrudState>(
          listener: (context, state) {
            if (state is DeleteMaterialItemFailure) {
              context.pop();
              AppSnackBar.error(context, state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is DeleteMaterialItemLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AppAnimatedLoadingIndicator(),
                ),
              );
            }
            return Row(
              children: [
                Expanded(
                  child: CustomAppButton(
                    label: 'Cancel',
                    height: 40,
                    textColor: AppColors.primaryDark,
                    backgroundColor: AppColors.secondaryLight,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomAppButton(
                    label: 'Delete',
                    height: 40,
                    textColor: AppColors.whiteLight,
                    backgroundColor: StatusColors.red,
                    onPressed: () {
                      context.read<MaterialCrudCubit>().deleteSingleItem(
                        materialId:
                            materialId,
                        itemKey: itemKey,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
