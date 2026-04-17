import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_item_model.dart';
import 'package:sams_app/features/materials/presentation/logic/material_navigation_handler.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/empty_items.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/material_item_card.dart';

/// A sliver-based list that categorizes and displays course materials into
/// Videos and Documents sections.
class MaterialsSliverList extends StatelessWidget {
  final List<MaterialItemModel> materials;
  final String materialId;

  const MaterialsSliverList({
    super.key,
    required this.materials,
    required this.materialId,
  });

  @override
  Widget build(BuildContext context) {
    //* Handle the empty state within the sliver protocol.
    if (materials.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: EmptyItems(),
          ),
        ),
      );
    }

    //? Split data into two categorized lists for better organization.
    final videoItems = materials.where((item) => item.isVideoItem).toList();
    final documentItems = materials.where((item) => !item.isVideoItem).toList();

    //* Using SliverMainAxisGroup to treat multiple slivers as a single logical unit.
    return SliverMainAxisGroup(
      slivers: [
        //* Video Section
        if (videoItems.isNotEmpty) ...[
          _buildHeader('Videos'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCard(videoItems[index], context),
              childCount: videoItems.length,
            ),
          ),
        ],

        //* Document Section
        if (documentItems.isNotEmpty) ...[
          //? Add spacing between sections only if both exist.
          if (videoItems.isNotEmpty)
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          _buildHeader('Documents'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCard(documentItems[index], context),
              childCount: documentItems.length,
            ),
          ),
        ],
      ],
    );
  }

  /// Builds a section header that scrolls along with the list.
  Widget _buildHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          title,
          style: AppStyles.mobileTitleMediumSb.copyWith(
            color: AppColors.primaryDarkHover,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  /// Constructs a material card with interaction callbacks.
  Widget _buildCard(MaterialItemModel file, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: MaterialItemCard(
        fileName: file.originalFileName ?? 'Unknown File',
        description: '',
        icon: file.icon,
        iconColor: file.color,
        materialType: file.isVideoItem
            ? CourseMaterialType.video
            : CourseMaterialType.pdf,
        onTap: () => _handleItemTap(context, file),
        onDelete: () => _confirmAndDelete(context, file),
      ),
    );
  }

  /// Triggers the deletion logic via the navigation handler.
  void _confirmAndDelete(BuildContext context, MaterialItemModel item) {
    MaterialsNavigationHandler.showDeleteSingleItemDialog(
      context,
      materialId: materialId,
      itemKey: item.key ?? '',
      fileName: item.originalFileName ?? 'Unknown File',
    );
  }

  /// Navigates to the appropriate viewer (PDF/Video) based on file type.
  void _handleItemTap(BuildContext context, MaterialItemModel file) async {
    MaterialsNavigationHandler.openMaterialItem(context, file);
  }
}
