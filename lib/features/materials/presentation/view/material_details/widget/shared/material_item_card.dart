import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/shine_overlay.dart';

//* Defines the type of material .
enum CourseMaterialType { pdf, video }

//* A custom card widget used to display course materials (PDFs or Videos).
// * Hover effects for web/desktop.
// * Pulse animation on tap.
// * Visual feedback with [ShineOverlay].
class MaterialItemCard extends StatefulWidget {
  final String fileName;
  final String description;
  final CourseMaterialType materialType;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const MaterialItemCard({
    super.key,
    required this.fileName,
    required this.description,
    required this.materialType,
    this.icon,
    this.iconColor,
    this.onTap,
    this.onDelete,
  });

  @override
  State<MaterialItemCard> createState() => _MaterialItemCardState();
}

class _MaterialItemCardState extends State<MaterialItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isShining = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    //* Initialize controller for the pulse scale effect.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles the tap interaction including animation and shine effect.
  void _handleTap() {
    //* Trigger scale pulse animation.
    _controller.forward().then((_) => _controller.reverse());
    setState(() => _isShining = true);

    Future.delayed(const Duration(milliseconds: 200), () {
      widget.onTap?.call();
      if (mounted) setState(() => _isShining = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    //? Select icon path based on material type.
    final String iconPath = widget.materialType == CourseMaterialType.video
        ? AppIcons.iconsVideoMaterial
        : AppIcons.iconsPdfMaterials;

    //? Determine icon color based on material type if not explicitly provided.
    final Color finalIconColor =
        widget.iconColor ??
        (widget.materialType == CourseMaterialType.video
            ? AppColors.primary
            : AppColors.red);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double pulseScale = 1.0 - (_controller.value * 0.03);
          return Transform.scale(
            scale: _controller.isAnimating ? pulseScale : 1.0,
            child: child,
          );
        },
        child: SizedBox(
          //* Fixed height maintains list stability when internal container expands on hover.
          height: 70,
          child: Stack(
            //! Clip.none is essential for the hover expansion to overlay adjacent widgets.
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: _handleTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  //_ Constraints allow the card to expand vertically for long titles on hover.
                  constraints: const BoxConstraints(minHeight: 70),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered ? AppColors.white : AppColors.greenLight,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryDarkHover.withAlpha(
                          _isHovered ? 30 : 12,
                        ),
                        blurRadius: _isHovered ? 25 : 15,
                        offset: Offset(0, _isHovered ? 8 : 4),
                      ),
                    ],
                    border: Border.all(
                      color: _isHovered
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: _isHovered
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      _buildIcon(finalIconColor, iconPath),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AutoSizeText(
                              widget.fileName,
                              minFontSize: 16,
                              maxFontSize: 24,
                              maxLines: _isHovered ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.mobileBodyLargeMd.copyWith(
                                color: AppColors.primaryDarkHover,
                                height: 1.2,
                              ),
                            ),
                            //_ Hide description during hover to focus on the full title.
                            if (widget.description.isNotEmpty &&
                                !_isHovered) ...[
                              const SizedBox(height: 2),
                              Text(
                                widget.description,
                                maxLines: 1,
                                style: AppStyles.mobileBodySmallRg.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: widget.onDelete,
                      ),
                    ],
                  ),
                ),
              ),
              if (_isShining)
                Positioned.fill(
                  child: IgnorePointer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: const ShineOverlay(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the leading icon for the card, supporting both IconData and SVG.
  Widget _buildIcon(Color color, String path) {
    return Container(
      //? Slightly offset the icon when the card expands on hover.
      margin: EdgeInsets.only(top: _isHovered ? 4 : 0),
      child: widget.icon != null
          ? Icon(widget.icon, size: 36, color: color)
          : SvgPicture.asset(
              path,
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
    );
  }
}
