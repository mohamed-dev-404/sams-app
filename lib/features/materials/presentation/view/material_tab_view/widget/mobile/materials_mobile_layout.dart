import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/mobile/mobile_main_card.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/logic/material_navigation_handler.dart';
import 'package:sams_app/features/materials/presentation/logic/material_refresh_trigger.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

/// Mobile-specific layout for displaying a course's materials.
/// It integrates Bloc for state management and supports role-based actions.
class MaterialsMobileLayout extends StatefulWidget {
  const MaterialsMobileLayout({super.key, required this.courseId});

  final String courseId;

  @override
  State<MaterialsMobileLayout> createState() => _MaterialsMobileLayoutState();
}

class _MaterialsMobileLayoutState extends State<MaterialsMobileLayout> {
  @override
  void initState() {
    super.initState();
    //* Observer Pattern: Listening to global refresh events (e.g., after adding/deleting a material).
    MaterialRefreshTrigger.shouldRefresh.addListener(_fetch);
  }

  @override
  void dispose() {
    //* Memory Management: Detach listener to prevent context leaks.
    MaterialRefreshTrigger.shouldRefresh.removeListener(_fetch);
    super.dispose();
  }

  /// Dispatches the fetch event to the Cubit.
  void _fetch() {
    if (mounted) {
      context.read<MaterialFetchCubit>().fetchMaterials(
        courseId: widget.courseId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialFetchCubit, MaterialFetchState>(
      //* Performance Optimization: Rebuild only on core state transitions.
      buildWhen: (previous, current) =>
          current is MaterialFetchSuccess ||
          current is MaterialFetchLoading ||
          current is MaterialFetchFailure,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => _fetch(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              //* 1. Administrative UI: Displayed only for instructors to manage content.
              if (CurrentRole.role == UserRole.instructor)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  sliver: SliverToBoxAdapter(
                    child: AddNewCard(
                      isMobile: true,
                      title: 'Add Material',
                      onTap: () => _navigateToAddMaterial(context),
                    ),
                  ),
                ),

              //* 2. Loading State: Uses a custom animated indicator for brand consistency.
              if (state is MaterialFetchLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: AppAnimatedLoadingIndicator()),
                ),

              //* 3. Failure State: Basic error reporting.
              if (state is MaterialFetchFailure)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.errMessage)),
                ),

              //* 4. Success State: Renders a list of interactive cards.
              if (state is MaterialFetchSuccess)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final material = state.materials[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Builder(
                          builder: (cardContext) => MobileMainCard(
                            cardModel: MainCardModel(
                              title: material.title,
                              description: material.description,
                              image: AppImages.imagesMaterialCard,
                              actionWidget:
                                  (CurrentRole.role == UserRole.instructor)
                                  ? SvgPicture.asset(
                                      AppIcons.iconsMenu,
                                      width: 22,
                                      height: 22,
                                    )
                                  : null,
                              onActionTap: () {
                                if (CurrentRole.role == UserRole.instructor) {
                                  _showPopupMenu(cardContext, material);
                                } else {
                                  _navigateToDetails(material);
                                }
                              },
                              onTap: () => _navigateToDetails(material),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: state.materials.length,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToAddMaterial(BuildContext context) {
    MaterialsNavigationHandler.navigateToManageMaterial(
      context,
      courseId: widget.courseId,
    );
  }

  void _navigateToDetails(MaterialModel material) {
    MaterialsNavigationHandler.navigateToDetails(
      context,
      courseId: widget.courseId,
      material: material,
    );
  }

  /// Calculates and displays a context menu relative to the tapped card.
  void _showPopupMenu(BuildContext context, MaterialModel material) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

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
      context: context,
      position: position,
      color: AppColors.whiteLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        const PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: AppColors.primary, size: 20),
              SizedBox(width: 10),
              Text('Edit', style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
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
      _confirmDelete(material);
    }

    if (selected == 'edit' && mounted) {
      _navigateToEditMaterial(material);
    }
  }

  void _navigateToEditMaterial(MaterialModel material) {
    MaterialsNavigationHandler.navigateToEditMaterial(
      context,
      material: material,
      courseId: widget.courseId,
    );
  }

  void _confirmDelete(MaterialModel material) {
    MaterialsNavigationHandler.showDeleteDialog(context, material: material);
  }
}
