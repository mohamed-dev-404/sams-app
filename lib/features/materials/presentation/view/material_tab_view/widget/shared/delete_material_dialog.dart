import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';

class DeleteMaterialDialog extends StatelessWidget {
  const DeleteMaterialDialog({
    super.key,
    required this.materialId,
    required this.materialName,
  });

  final String materialId;
  final String materialName;

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
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      actionsPadding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Delete $materialName?',
      ),
      titleTextStyle: AppStyles.mobileTitleMediumSb.copyWith(
        color: AppColors.primaryDarkHover,
      ),
      content: Text(
        '• Are you sure you want to delete this material?\n\n'
        '• All linked files and resources will be permanently removed.\n',
        style: AppStyles.mobileBodyMediumRg.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
      actions: [
        BlocConsumer<MaterialCrudCubit, MaterialCrudState>(
          listener: (context, state) {
            if (state is DeleteMaterialSuccess) {
              context.pop(context); // Close dialog on success
              AppSnackBar.success(context, state.message);
            } else if (state is DeleteMaterialFailure) {
              context.pop(context); // Close dialog on failure
              AppSnackBar.error(context, state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is DeleteMaterialLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    color: AppColors.primaryDark,
                  ),
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
                      // Trigger the delete operation in the Cubit
                      context.read<MaterialCrudCubit>().deleteMaterial(
                        materialId: materialId,
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
