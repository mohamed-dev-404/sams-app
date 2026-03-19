import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/extentions/filter_files_helper.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class CourseMaterialSection extends StatefulWidget {
  const CourseMaterialSection({super.key});

  @override
  State<CourseMaterialSection> createState() => CourseMaterialSectionState();
}

class CourseMaterialSectionState extends State<CourseMaterialSection> {
  final List<XFile> _pickedVideos = [];
  final List<XFile> _pickedDocuments = [];

  List<XFile> get allPickedFiles => [..._pickedVideos, ..._pickedDocuments];

  // Handle file picking for both videos and documents
  Future<void> _handleFileSelection({required bool isVideo}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: isVideo ? FileType.video : FileType.custom,
      allowedExtensions: isVideo ? null : ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        final newFiles = result.files.map(
          (f) => XFile(f.path ?? f.name, name: f.name),
        );
        if (isVideo) {
          _pickedVideos.addAll(newFiles);
        } else {
          _pickedDocuments.addAll(newFiles);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Material', style: AppStyles.mobileBodyLargeSb),
          const SizedBox(height: 20),

          // Video selection card
          FilePickerCard(
            iconPath: AppIcons.iconsVideo,
            title: 'Material Videos',
            subTitle: 'Upload MP4, MKV or AVI',
            files: _pickedVideos,
            onTap: () => _handleFileSelection(isVideo: true),
            onRemove: (file) => setState(() => _pickedVideos.remove(file)),
          ),

          const SizedBox(height: 16),

          // Document selection card
          FilePickerCard(
            iconPath: AppIcons.iconsPdf,
            title: 'Material Documents',
            subTitle: 'Upload PDF, PPTX or DOCX',
            files: _pickedDocuments,
            onTap: () => _handleFileSelection(isVideo: false),
            onRemove: (file) => setState(() => _pickedDocuments.remove(file)),
          ),
        ],
      ),
    );
  }
}

class FilePickerCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subTitle;
  final List<XFile> files;
  final VoidCallback onTap;
  final Function(XFile) onRemove;

  const FilePickerCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
    required this.files,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Smoothly animates the card height when files are added/removed
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
              if (files.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: files
                        .map(
                          (file) => _PickedFileTile(
                            file: file,
                            onRemove: () => onRemove(file),
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickedFileTile extends StatelessWidget {
  final XFile file;
  final VoidCallback onRemove;

  const _PickedFileTile({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    // Subtle slide-up and fade-in animation for each file entry
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.secondary.withAlpha(30)),
        ),
        child: ListTile(
          dense: true,
          leading: Icon(
            file.name.fileIcon,
            color: file.name.fileColor,
          ),
          title: Text(
            file.name,
            style: AppStyles.mobileLabelMediumRg,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: StatusColors.red, size: 20),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
