import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

/// A reusable wrapper that provides interactive animations (Scale & Hover)
/// for any child widget using the Builder pattern to expose hover state.
class InteractiveWrapper extends StatefulWidget {
  const InteractiveWrapper({
    super.key,
    required this.builder,
    required this.onTap,
    this.showHoverEffect = true,
    this.hoverColor,
  });

  /// Function that builds the child widget, providing the current hover state.
  /// Use [isHovered] to toggle visibility of sub-widgets (like edit icons).
  final Widget Function(bool isHovered) builder;

  /// Callback triggered when the widget is tapped.
  final VoidCallback onTap;

  /// Whether to show a background color change during hover.
  final bool showHoverEffect;

  /// Optional custom color for the hover background effect.
  /// Defaults to [AppColors.primaryDarkHover] with 10% opacity.
  final Color? hoverColor;

  @override
  State<InteractiveWrapper> createState() => _InteractiveWrapperState();
}

class _InteractiveWrapperState extends State<InteractiveWrapper> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Determine the background color to use during hover
    final Color effectiveHoverColor =
        widget.hoverColor ?? AppColors.primaryDarkHover.withValues(alpha: 0.1);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        // Handle press states to trigger scale down animation (Physical Feedback)
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          // Logic: Shrink on press (0.96), Expand slightly on hover (1.02), Default (1.0)
          scale: _isPressed ? 0.96 : (_isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            // Smoothly add horizontal padding during hover to emphasize the selection
            padding: _isHovered
                ? const EdgeInsets.symmetric(horizontal: 8)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (widget.showHoverEffect && _isHovered)
                  ? effectiveHoverColor
                  : Colors.transparent,
            ),
            // Rebuilds the child whenever _isHovered changes
            child: widget.builder(_isHovered),
          ),
        ),
      ),
    );
  }
}
