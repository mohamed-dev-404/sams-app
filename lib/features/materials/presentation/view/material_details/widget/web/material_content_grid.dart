import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      return const Center(child: Text('No files attached to this material.'));
    }
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display two items per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 220 / 70, // Adjusts the height relative to width
      ),
      itemCount: materials.length, // Replace with actual data length
      itemBuilder: (context, index) {
        final file = materials[index];
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
      },
    );
  }
}
