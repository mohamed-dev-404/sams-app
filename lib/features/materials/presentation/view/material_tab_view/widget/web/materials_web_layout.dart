import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/core/widgets/shared/app_grid_style.dart';
import 'package:sams_app/core/widgets/shared/tab_body_view.dart';
import 'package:sams_app/core/widgets/web/web_main_card.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/logic/material_refresh_trigger.dart';
import 'package:sams_app/features/materials/presentation/view/material_tab_view/widget/shared/delete_material_dialog.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

class MaterialsWebLayout extends StatefulWidget {
  const MaterialsWebLayout({super.key, required this.courseId});
  final String courseId;

  @override
  State<MaterialsWebLayout> createState() => _MaterialsWebLayoutState();
}

class _MaterialsWebLayoutState extends State<MaterialsWebLayout> {
  @override
  void initState() {
    super.initState();
    //* Listen for global refresh triggers (e.g., after deletion or creation) to sync the Web UI
    MaterialRefreshTrigger.shouldRefresh.addListener(_fetch);
  }

  @override
  void dispose() {
    //* Clean up listeners to prevent memory leaks in web navigation
    MaterialRefreshTrigger.shouldRefresh.removeListener(_fetch);
    super.dispose();
  }

  //* Core fetch logic triggered by pull-to-refresh or global listeners
  void _fetch() {
    if (mounted) {
      context.read<MaterialFetchCubit>().fetchMaterials(
        courseId: widget.courseId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInstructor = CurrentRole.role == UserRole.instructor;
    final bool isMobile = SizeConfig.isMobile(context);

    return TabBodyView(
      child: BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
        //* Optimize rebuilds: only react to success, loading, or failure states
        buildWhen: (previous, current) =>
            current is MaterialFetchSuccess ||
            current is MaterialFetchLoading ||
            current is MaterialFetchFailure,
        builder: (context, state) {
          if (state is MaterialFetchLoading) {
            return const Center(child: AppAnimatedLoadingIndicator());
          }
          if (state is MaterialFetchFailure) {
            return Center(child: Text(state.errMessage));
          }
          if (state is MaterialFetchSuccess) {
            final materials = state.materials;
            return CustomScrollView(
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      //* Append the 'Add Material' card at the end of the grid for Instructors
                      if (isInstructor && index == materials.length) {
                        return AddNewCard(
                          isMobile: isMobile,
                          title: 'Add Material',
                          onTap: () => _navigateToAddMaterial(context),
                        );
                      }

                      final material = materials[index];
                      return Builder(
                        builder: (cardContext) => WebMainCard(
                          model: MainCardModel(
                            title: material.title,
                            description: material.description,
                            image: AppImages.imagesMaterialCard,
                            actionWidget: isInstructor
                                ? SvgPicture.asset(
                                    AppIcons.iconsMenu,
                                    width: 22,
                                    height: 22,
                                  )
                                : null,
                            onActionTap: isInstructor
                                ? () => _showWebPopupMenu(
                                    cardContext,
                                    context,
                                    material,
                                  )
                                : null,
                            onTap: () => _navigateToDetails(context, material),
                          ),
                        ),
                      );
                    },
                    //* Adjust childCount to include the AddNewCard if Instructor
                    childCount: materials.length + (isInstructor ? 1 : 0),
                  ),
                  gridDelegate: AppGridStyles.tapGridDelegate,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  //* Navigates to details and initiates a background fetch for detailed material data
  void _navigateToDetails(BuildContext context, MaterialModel material) {
    context.read<MaterialFetchCubit>().fetchMaterialDetails(
      materialId: material.id,
    );
    context.pushNamed(
      RoutesName.materialDetails,
      pathParameters: {
        'courseId': widget.courseId,
        'materialId': material.id,
      },
    );
  }

  //* Logic for creating new material; updates the list locally upon success
  void _navigateToAddMaterial(BuildContext context) async {
    final materialCubit = context.read<MaterialFetchCubit>();
    final newMaterial = await context.pushNamed(
      RoutesName.manageMaterial,
      pathParameters: {'courseId': widget.courseId},
    );

    if (newMaterial is MaterialModel && mounted) {
      materialCubit.addMaterialToListView(newMaterial);
    }
  }

  //* Displays a contextually positioned menu for Instructor actions
  void _showWebPopupMenu(
    BuildContext cardContext,
    BuildContext pageContext,
    MaterialModel material,
  ) async {
    final RenderBox button = cardContext.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(pageContext).overlay!.context.findRenderObject()
            as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(button.size.width, 0), ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final String? selected = await showMenu<String>(
      context: pageContext,
      position: position,
      color: AppColors.whiteLight,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        const PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );

    if (selected == 'delete' && mounted) {
      //! Instructor Actions: Confirmation Dialog for material deletion
      showDialog(
        context: context,
        builder: (dialogContext) => BlocProvider.value(
          value: context
              .read<
                MaterialCrudCubit
              >(), // Inject the existing cubit into the dialog's route
          child: DeleteMaterialDialog(
            materialId: material.id, // Pass real material ID
            materialName: material.title, // Pass real material name
          ),
        ),
      );
    }
  }
}