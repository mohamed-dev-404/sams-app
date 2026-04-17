import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/core/widgets/shared/app_grid_style.dart';
import 'package:sams_app/core/widgets/shared/tab_body_view.dart';
import 'package:sams_app/core/widgets/web/web_main_card.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/logic/material_navigation_handler.dart';
import 'package:sams_app/features/materials/presentation/logic/material_refresh_trigger.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

/// Web-optimized layout for course materials.
/// Features a grid-based system that adapts to screen width and integrates
/// instructor-specific management tools directly into the grid flow.
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
    //* Observer Pattern: Real-time UI synchronization across different modules.
    MaterialRefreshTrigger.shouldRefresh.addListener(_fetch);
  }

  @override
  void dispose() {
    MaterialRefreshTrigger.shouldRefresh.removeListener(_fetch);
    super.dispose();
  }

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
                      //* Logic: The 'Add Material' card is appended as the LAST item for instructors.
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
                    //* childCount adjusts based on user role to accommodate the action card.
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

  void _navigateToDetails(BuildContext context, MaterialModel material) {
    MaterialsNavigationHandler.navigateToDetails(
      context,
      courseId: widget.courseId,
      material: material,
    );
  }

  void _navigateToAddMaterial(BuildContext context) {
    MaterialsNavigationHandler.navigateToManageMaterial(
      context,
      courseId: widget.courseId,
    );
  }

  /// Calculates visual coordinates for the popup menu to ensure it aligns
  /// with the specific grid card on the web surface.
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
      MaterialsNavigationHandler.showDeleteDialog(context, material: material);
    }
  }
}
