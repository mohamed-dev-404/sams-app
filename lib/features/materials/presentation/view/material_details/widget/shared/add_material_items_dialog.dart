import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/helper/app_snack_bar.dart';
import 'package:sams_app/core/helper/app_toast.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/base/custom_app_button.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/course_material_section.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/uploading_overlay.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_state.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

class AddNewMaterialItemsDialog extends StatefulWidget {
  final String courseId;
  final String materialId;

  const AddNewMaterialItemsDialog({
    super.key,
    required this.courseId,
    required this.materialId,
  });

  @override
  State<AddNewMaterialItemsDialog> createState() =>
      _AddNewMaterialItemsDialogState();
}

class _AddNewMaterialItemsDialogState extends State<AddNewMaterialItemsDialog> {
  final GlobalKey<CourseMaterialSectionState> _sectionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = SizeConfig.isMobile(context);

    var blocListener = BlocListener<MaterialCrudCubit, MaterialCrudState>(
      listener: (context, state) {
        if (state is AddMaterialItemsSuccess) {
          // Start fetching new data immediately after upload success
          context.read<MaterialFetchCubit>().fetchMaterialDetails(
            materialId: widget.materialId,
          );
        } else if (state is AddMaterialItemsFailure) {
          AppSnackBar.error(context, state.errMessage);
        }
      },
    );
    return MultiBlocListener(
      listeners: [
        blocListener,
        BlocListener<MaterialFetchCubit, MaterialFetchState>(
          listener: (context, state) {
            // Only pop the dialog when data is successfully refreshed
            if (state is MaterialFetchDetailsSuccess) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
                AppSnackBar.success(context, 'Materials updated successfully!');
              }
            }
          },
        ),
      ],
      child: Stack(
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Add New Materials',
                  style: isMobile
                      ? AppStyles.mobileTitleSmallSb
                      : AppStyles.mobileTitleMediumSb,
                ),
              ],
            ),
            content: SizedBox(
              width: 600,
              child: SingleChildScrollView(
                child: CourseMaterialSection(
                  key: _sectionKey,
                  initialItems: const [],
                ),
              ),
            ),
            actions: [
              BlocBuilder<MaterialCrudCubit, MaterialCrudState>(
                builder: (context, crudState) {
                  return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
                    builder: (context, fetchState) {
                      final bool isLoading =
                          crudState is AddMaterialItemsLoading ||
                          fetchState is MaterialFetchLoading;

                      if (isLoading) return const SizedBox.shrink();

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
                              label: 'Confirm',
                              height: 40,
                              textColor: AppColors.whiteLight,
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                final allFiles =
                                    _sectionKey.currentState?.allPickedFiles ??
                                    [];
                                if (allFiles.isNotEmpty) {
                                  context
                                      .read<MaterialCrudCubit>()
                                      .addNewItemsOnly(
                                        materialId: widget.materialId,
                                        courseId: widget.courseId,
                                        newFiles: allFiles,
                                      );
                                } else {
                                  AppToast.warning(
                                    context,
                                    'Please select at least one file.',
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          // Overlay stays visible during both Uploading and Fetching
          BlocBuilder<MaterialCrudCubit, MaterialCrudState>(
            builder: (context, crudState) {
              return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
                builder: (context, fetchState) {
                  if (crudState is AddMaterialItemsLoading ||
                      fetchState is MaterialFetchLoading) {
                    return const UploadingOverlay();
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
