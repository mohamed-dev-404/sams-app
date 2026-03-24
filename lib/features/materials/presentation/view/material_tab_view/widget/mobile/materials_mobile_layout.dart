import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/main_card_model.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/router/routes_name.dart';
import 'package:sams_app/core/widgets/base/app_animated_loading_indicator.dart';
import 'package:sams_app/core/widgets/mobile/mobile_main_card.dart';
import 'package:sams_app/core/widgets/shared/add_new_card.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';
import 'package:sams_app/features/materials/presentation/logic/material_refresh_trigger.dart';
import 'package:sams_app/features/materials/presentation/view/material_tab_view/widget/shared/delete_material_dialog.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_crud/material_crud_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_cubit.dart';
import 'package:sams_app/features/materials/presentation/view_model/cubits/material_fetch/material_fetch_state.dart';

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
    //* Subscribe to global refresh triggers for real-time list updates
    MaterialRefreshTrigger.shouldRefresh.addListener(_fetch);
  }

  @override
  void dispose() {
    //* Clean up listener to prevent memory leaks
    MaterialRefreshTrigger.shouldRefresh.removeListener(_fetch);
    super.dispose();
  }

  //* Data fetching logic with safety check
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
      //* Optimized rebuilds: prevent flickering during background detail fetches
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
              //* 1. Instructor Section: Permission-based Add Card
              if (CurrentRole.role == UserRole.instructor)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  sliver: SliverToBoxAdapter(
                    child: AddNewCard(
                      isMobile: true,
                      title: 'Add Material',
                      onTap: () async {
                        final newMaterial = await context.pushNamed(
                          RoutesName.manageMaterial,
                          pathParameters: {
                            'courseId': widget.courseId,
                          },
                        );
                        //* Immediately inject new material into the list for snappy UX
                        if (newMaterial is MaterialModel && context.mounted) {
                          context
                              .read<MaterialFetchCubit>()
                              .addMaterialToListView(newMaterial);
                        }
                      },
                    ),
                  ),
                ),

              //* 2. Loading Visuals
              if (state is MaterialFetchLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: AppAnimatedLoadingIndicator()),
                ),

              //* 3. Error Handling View
              if (state is MaterialFetchFailure)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.errMessage)),
                ),

              //* 4. Dynamic Materials List
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

  //* Navigates and triggers detail pre-fetching for better perceived performance
  void _navigateToDetails(MaterialModel material) {
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

  //* Instructor Actions: Relative position calculation for context menu
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
  }

 //! Instructor Actions: Confirmation Dialog for material deletion
  void _confirmDelete(MaterialModel material) {
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
