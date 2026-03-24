import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/data/model/material_item_model.dart';
import 'package:sams_app/features/materials/presentation/view/manage_material/widget/shared/file_picker_card.dart';

class CourseMaterialSection extends StatefulWidget {
  const CourseMaterialSection({super.key, this.initialItems});
  final List<MaterialItemModel>? initialItems;
  @override
  State<CourseMaterialSection> createState() => CourseMaterialSectionState();
}

class CourseMaterialSectionState extends State<CourseMaterialSection> {
  final List<XFile> _pickedVideos = [];
  final List<XFile> _pickedDocuments = [];

  List<MaterialItemModel> _existingVideos = [];
  List<MaterialItemModel> _existingDocuments = [];

  List<XFile> get allPickedFiles => [..._pickedVideos, ..._pickedDocuments];

  //* Returns unique keys for items that were NOT removed by the user
  List<String> get remainingExistingIds => [
    ..._existingVideos.map((e) => e.key ?? ''),
    ..._existingDocuments.map((e) => e.key ?? ''),
  ].where((k) => k.isNotEmpty).toList();

  @override
  void initState() {
    super.initState();
    if (widget.initialItems != null) {
      for (var item in widget.initialItems!) {
        if (item.isVideoItem) {
          _existingVideos.add(item);
        } else {
          _existingDocuments.add(item);
        }
      }
    }
  }

  //* External sync method for Mixins/Controllers to update internal state
  void initializeWithExistingFiles(List<MaterialItemModel> items) {
    setState(() {
      _existingVideos = items.where((item) => item.isVideoItem).toList();
      _existingDocuments = items.where((item) => !item.isVideoItem).toList();
    });
  }

  //* Unified file picker for both media and documents
  Future<void> handleFileSelection({required bool isVideo}) async {
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

          //* Video Category Card
          FilePickerCard(
            iconPath: AppIcons.iconsVideo,
            title: 'Material Videos',
            subTitle: 'Upload MP4, MKV or AVI',
            existingFiles: _existingVideos,
            pickedFiles: _pickedVideos,
            onTap: () => handleFileSelection(isVideo: true),
            onRemovePicked: (file) =>
                setState(() => _pickedVideos.remove(file)),
            onRemoveExisting: (item) =>
                setState(() => _existingVideos.remove(item)),
          ),

          const SizedBox(height: 16),

          //* Document Category Card
          FilePickerCard(
            iconPath: AppIcons.iconsPdf,
            title: 'Material Documents',
            subTitle: 'Upload PDF, PPTX or DOCX',
            existingFiles: _existingDocuments,
            pickedFiles: _pickedDocuments,
            onTap: () => handleFileSelection(isVideo: false),
            onRemovePicked: (file) =>
                setState(() => _pickedDocuments.remove(file)),
            onRemoveExisting: (item) =>
                setState(() => _existingDocuments.remove(item)),
          ),
        ],
      ),
    );
  }
}
