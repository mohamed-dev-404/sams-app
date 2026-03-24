import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/extentions/filter_files_helper.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_item_model.dart';

class FilePickerCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;
  final List<XFile> pickedFiles;
  final List<MaterialItemModel> existingFiles;
  final VoidCallback onTap;
  final Function(XFile) onRemovePicked;
  final Function(MaterialItemModel) onRemoveExisting;

  const FilePickerCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
    required this.pickedFiles,
    required this.existingFiles,
    required this.onTap,
    required this.onRemovePicked,
    required this.onRemoveExisting,
  });

  @override
  Widget build(BuildContext context) {
    //* Animates the card's expansion/contraction when files are modified
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greenLightActive),
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(height: 16),
              Text(
                title,
                style: AppStyles.mobileLabelMediumRg.copyWith(
                  color: AppColors.blackDarker,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subTitle,
                style: AppStyles.mobileLabelMediumRg.copyWith(
                  color: AppColors.primaryDarkHover,
                ),
              ),
              if (existingFiles.isNotEmpty || pickedFiles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      //* Rendering Remote Assets
                      ...existingFiles.map(
                        (item) => _FileTile(
                          name: item.originalFileName ?? 'Untitled',
                          onRemove: () => onRemoveExisting(item),
                          isExisting: true,
                        ),
                      ),
                      //* Rendering Local Picked Files
                      ...pickedFiles.map(
                        (file) => _FileTile(
                          name: file.name,
                          onRemove: () => onRemovePicked(file),
                          isExisting: false,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

//* Unified and Animated Tile for all file states
class _FileTile extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;
  final bool isExisting;

  const _FileTile({
    required this.name,
    required this.onRemove,
    required this.isExisting,
  });

  @override
  Widget build(BuildContext context) {
    //* Integrated Entrance Animation: Slide-up + Fade-in
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          //* Visual distinction: lighter/transparent background for existing cloud files
          color: isExisting ? Colors.blueGrey.withAlpha(15) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.secondary.withAlpha(30)),
        ),
        child: ListTile(
          dense: true,
          leading: Icon(name.fileIcon, color: name.fileColor),
          title: Text(
            name,
            style: AppStyles.mobileLabelMediumRg,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: isExisting
              ? const Text(
                  'Existing Content',
                  style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                )
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.close, color: StatusColors.red, size: 20),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
