import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sams_app/core/utils/assets/app_lottie.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_item_model.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/file_preview_screen.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/material_item_card.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/video_player_screen.dart';
import 'package:url_launcher/url_launcher.dart';

//* A SliverList that displays course materials grouped by type (Videos and Documents).
class MaterialsSliverList extends StatelessWidget {
  final List<MaterialItemModel> materials;

  const MaterialsSliverList({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    // Handle empty state
    if (materials.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Lottie.asset(
                  AppLottie.empty,
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                const Text('No files attached to this material.'),
              ],
            ),
          ),
        ),
      );
    }

    // Categorize items based on file type
    final videoItems = materials.where((item) => item.isVideoItem).toList();
    final documentItems = materials.where((item) => !item.isVideoItem).toList();

    return SliverMainAxisGroup(
      slivers: [
        // Render Video Section if available
        if (videoItems.isNotEmpty) ...[
          _buildHeader('Videos'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCard(videoItems[index], context),
              childCount: videoItems.length,
            ),
          ),
        ],

        // Render Document Section if available
        if (documentItems.isNotEmpty) ...[
          // Add spacing between sections if both exist
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

  /// Builds a section header with stylized text.
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

  /// Builds an individual material card and manages navigation logic based on platform and file type.
  Widget _buildCard(MaterialItemModel file, BuildContext context) {
    return MaterialItemCard(
      fileName: file.originalFileName ?? 'Unknown File',
      description: '',
      icon: file.icon,
      iconColor: file.color,
      materialType: file.isVideoItem
          ? CourseMaterialType.video
          : CourseMaterialType.pdf,
      onTap: () async {
        final url = file.displayUrl ?? '';
        if (url.isEmpty) return;

        if (kIsWeb) {
          // For Web platform: Open the file in a new browser tab
          await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
        } else {
          // For Mobile platforms: Determine the appropriate viewer
          if (file.isVideoItem) {
            // Navigate to the custom video player for video files
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
            // Navigate to the standard file preview for documents (PDFs, Images, etc.)
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
      },
    );
  }
}