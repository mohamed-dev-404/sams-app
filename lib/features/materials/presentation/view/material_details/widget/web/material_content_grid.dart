import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_item_model.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/file_preview_screen.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/material_item_card.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/video_player_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialContentGrid extends StatelessWidget {
  final List<MaterialItemModel> materials;
  const MaterialContentGrid({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    if (materials.isEmpty) {
      return const Center(child: Text('No content available for this material.'));
    }

    // Filter materials into two separate lists
    final videoItems = materials.where((item) => item.isVideoItem).toList();
    final fileItems = materials.where((item) => !item.isVideoItem).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        // 1. Videos Section
        if (videoItems.isNotEmpty) ...[
          _buildSectionTitle('Videos'),
          _buildGrid(context, videoItems),
          const SizedBox(height: 24),
        ],

        // 2. Files Section (PDFs, Images, etc.)
        if (fileItems.isNotEmpty) ...[
          _buildSectionTitle('Files & Documents'),
          _buildGrid(context, fileItems),
        ],
      ],
    );
  }

  /// Reusable Header for each section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 4),
      child: Text(
        title,
        style: AppStyles.web32Semibold.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Reusable Grid for displaying items
  Widget _buildGrid(BuildContext context, List<MaterialItemModel> items) {
    return GridView.builder(
      shrinkWrap: true, // Important to work inside ListView
      physics: const NeverScrollableScrollPhysics(), // Scroll is handled by Parent ListView
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return MaterialItemCard(
          fileName: item.originalFileName ?? 'Unknown',
          description: '',
          icon: item.icon,
          iconColor: item.color,
          materialType: item.isVideoItem
              ? CourseMaterialType.video
              : CourseMaterialType.pdf,
          onTap: () => _handleItemTap(context, item),
        );
      },
    );
  }

  /// Handle interaction based on platform and type
  void _handleItemTap(BuildContext context, MaterialItemModel file) async {
    final url = file.displayUrl ?? '';
    if (url.isEmpty) return;

    if (kIsWeb) {
      // For Web: Always open in new tab for better experience
      await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
    } else {
      // For Mobile logic (kept for shared code consistency)
      if (file.isVideoItem) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              videoUrl: url,
              videoTitle: file.originalFileName ?? 'Video',
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilePreviewScreen(
              url: url,
              fileName: file.originalFileName ?? 'File',
            ),
          ),
        );
      }
    }
  }
}