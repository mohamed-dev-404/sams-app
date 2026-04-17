import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/shared/shine_overlay.dart';

/// Defines the supported categories of course content.
enum CourseMaterialType { pdf, video }

/// An interactive card component for displaying course materials.
/// Features:
/// - Dynamic icon/color selection based on file type.
/// - Pulse scale animation on tap using [AnimationController].
/// - Elevation and color shifting on hover for Web/Desktop environments.
/// - Integrated [ShineOverlay] for high-end visual feedback during actions.
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
    //* Pulse Effect: Short duration to ensure the feedback feels snappy.
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

  /// Manages the visual and functional sequence of a tap event.
  void _handleTap() {
    //* Phase 1: Animation Feedback.
    _controller.forward().then((_) => _controller.reverse());
    setState(() => _isShining = true);

    //* Phase 2: Action Execution after a brief delay to allow the effect to be seen.
    Future.delayed(const Duration(milliseconds: 200), () {
      widget.onTap?.call();
      if (mounted) setState(() => _isShining = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    //* Logic: Resource selection based on enum state.
    final String iconPath = widget.materialType == CourseMaterialType.video
        ? AppIcons.iconsVideoMaterial
        : AppIcons.iconsPdfMaterials;

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
          //? Subtle scale down (3%) during the pulse to mimic a physical button press.
          double pulseScale = 1.0 - (_controller.value * 0.03);
          return Transform.scale(
            scale: _controller.isAnimating ? pulseScale : 1.0,
            child: child,
          );
        },
        child: SizedBox(
          height: 70, // Maintains constant spacing in the ListView.
          child: Stack(
            clipBehavior: Clip
                .none, // Allows expanded hover state to bleed out of bounds.
            children: [
              GestureDetector(
                onTap: _handleTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: double.infinity,
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
                              maxLines: _isHovered
                                  ? 2
                                  : 1, // Expand title view on hover.
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.mobileBodyLargeMd.copyWith(
                                color: AppColors.primaryDarkHover,
                                height: 1.2,
                              ),
                            ),
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
                      //* Destructive Action: Item deletion trigger.
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
              //* Overlay Layer: Activated on tap to show the shine movement.
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

  Widget _buildIcon(Color color, String path) {
    return Container(
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
