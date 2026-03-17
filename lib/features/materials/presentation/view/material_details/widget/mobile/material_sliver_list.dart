import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_item_model.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/file_preview_screen.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/material_item_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialsSliverList extends StatelessWidget {
  final List<MaterialItemModel> materials;

  const MaterialsSliverList({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    if (materials.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('No files attached to this material.'),
          ),
        ),
      );
    }

    final videoItems = materials.where((item) => item.isVideoItem).toList();
    final documentItems = materials.where((item) => !item.isVideoItem).toList();

    return SliverMainAxisGroup(
      slivers: [
        if (videoItems.isNotEmpty) ...[
          _buildHeader('Videos'),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCard(videoItems[index], context),
              childCount: videoItems.length,
            ),
          ),
        ],
        if (documentItems.isNotEmpty) ...[
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

        if (kIsWeb) {
          await launchUrl(
            Uri.parse(url),
            webOnlyWindowName: '_blank',
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
      },
    );
  }
}
