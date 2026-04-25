import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/assignments/data/model/assignment_item_model.dart';
import 'package:sams_app/features/assignments/presentation/view/create_assignment_view/widgets/shared/file_picker_card.dart';

class CourseAssignmentSection extends StatefulWidget {
  const CourseAssignmentSection({super.key, this.initialItems});

  final List<AssignmentItemModel>? initialItems;

  @override
  State<CourseAssignmentSection> createState() =>
      CourseAssignmentSectionState();
}

class CourseAssignmentSectionState extends State<CourseAssignmentSection> {
  final List<XFile> _pickedDocuments = [];
  List<AssignmentItemModel> _existingDocuments = [];

  List<XFile> get allPickedFiles => [..._pickedDocuments];

  List<String> get remainingExistingIds => [
    ..._existingDocuments.map((e) => e.key ?? ''),
  ].where((k) => k.isNotEmpty).toList();

  @override
  void initState() {
    super.initState();
    if (widget.initialItems != null) {
      _existingDocuments = widget.initialItems!.toList();
    }
  }

  void initializeWithExistingFiles(List<AssignmentItemModel> items) {
    setState(() {
      _existingDocuments = items.toList();
    });
  }

  Future<void> handleFileSelection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        final newFiles = result.files.map(
          (f) => XFile(f.path ?? f.name, name: f.name),
        );
        _pickedDocuments.addAll(newFiles);
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
          Text('Assignment Files', style: AppStyles.mobileBodyLargeSb),
          const SizedBox(height: 20),
          AssignmentFilePickerCard(
            iconPath: AppIcons.iconsPdf,
            title: 'Assignment Documents',
            subTitle: 'Upload PDF, PPTX or DOCX',
            existingFiles: _existingDocuments,
            pickedFiles: _pickedDocuments,
            onTap: handleFileSelection,
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
