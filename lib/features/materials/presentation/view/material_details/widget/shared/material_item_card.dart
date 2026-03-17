import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/shine_overlay.dart';

enum CourseMaterialType { pdf, video }

class MaterialItemCard extends StatefulWidget {
  final String fileName;
  final String description;
  final CourseMaterialType materialType;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const MaterialItemCard({
    super.key,
    required this.fileName,
    required this.description,
    required this.materialType,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  State<MaterialItemCard> createState() => _MaterialItemCardState();
}

class _MaterialItemCardState extends State<MaterialItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isShining = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() async {
    // Start Scale animation
    _controller.forward().then((_) => _controller.reverse());

    // Trigger Shine effect
    setState(() => _isShining = true);

    // Delay to let the shine finish before executing logic
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() => _isShining = false);

    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final String iconPath = widget.materialType == CourseMaterialType.video
        ? AppIcons.iconsVideoMaterial
        : AppIcons.iconsPdfMaterials;

    // Use AppColors.primary as fallback for video, AppColors.red for PDF
    final Color finalIconColor =
        widget.iconColor ??
        (widget.materialType == CourseMaterialType.video
            ? AppColors.primary
            : AppColors.red);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _handleTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteLight, // Your App Color
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    // Using your brand color for the shadow to keep it premium
                    color: AppColors.primaryDarkHover.withAlpha(12),
                    blurRadius: _controller.isAnimating ? 20 : 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  widget.icon != null
                      ? Icon(widget.icon, size: 40, color: finalIconColor)
                      : SvgPicture.asset(
                          iconPath,
                          width: 44,
                          height: 44,
                          colorFilter: ColorFilter.mode(
                            finalIconColor,
                            BlendMode.srcIn,
                          ),
                        ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.mobileTitleSmallSb.copyWith(
                            color: AppColors.primaryDarkHover,
                          ),
                        ),
                        if (widget.description.isNotEmpty)
                          Text(
                            widget.description,
                            style: AppStyles.mobileBodySmallRg.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Shine Overlay using AppColors.whiteLight with opacity
            if (_isShining)
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const ShineOverlay(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
