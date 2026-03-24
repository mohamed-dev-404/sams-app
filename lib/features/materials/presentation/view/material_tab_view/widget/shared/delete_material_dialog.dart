import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
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
        'Are you sure you want to delete this material? All linked files, videos, and resources will be permanently removed and cannot be recovered.',
        style: AppStyles.mobileBodyMediumRg.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
      actions: [
        // BlocConsumer<CrudCubit, CrudState>(
        //   listener: (context, state) {
        //     if (state is DeleteMaterialSuccess ||
        //         state is DeleteMaterialFailure) {
        //       WidgetsBinding.instance.addPostFrameCallback((_) {
        //         if (Navigator.canPop(context)) {
        //           Navigator.pop(context); 
        //           if (state is DeleteMaterialSuccess) {
        //             AppSnackBar.success(context, state.message);
        //           } else if (state is DeleteMaterialFailure) {
        //             AppSnackBar.error(context, state.errMessage);
        //           }
        //         }
        //       });
        //     }
        //   },
        //   builder: (context, state) {
        //     if (state is DeleteMaterialLoading) {
        //       return const Center(
        //         child: Padding(
        //           padding: EdgeInsets.all(10),
        //           child: CircularProgressIndicator(
        //             color: AppColors.primaryDark,
        //           ),
        //         ),
        //       );
        //     }
             Row(
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
                     
                    },
                  ),
                ),
              ],
            )
      ],
    );
  }
}
