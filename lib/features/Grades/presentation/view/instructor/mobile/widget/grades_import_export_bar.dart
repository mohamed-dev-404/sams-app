import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class GradesImportExportBar extends StatelessWidget {
  const GradesImportExportBar({
    super.key,
    this.onExport,
    this.onImport,
  });

  final VoidCallback? onExport;
  final VoidCallback? onImport;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: _ActionButton(
            label: 'Export',
            icon: Icons.file_download_outlined,
            color: AppColors.primary,
            onPressed: onExport,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionButton(
            label: 'Import',
            icon: Icons.file_upload_outlined,
            color: AppColors.secondary,
            onPressed: onImport,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onPressed,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 0,
      ),
      icon: Icon(icon, size: 18..clamp(16, 20)),
      label: Text(
        label,
        style: AppStyles.mobileBodyXsmallMd.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
