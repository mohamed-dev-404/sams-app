import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_app/core/utils/assets/app_branding.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

/// Animated logo widget with a breathing glow halo effect.
///
/// Renders the white AcademiaX logo with:
/// - Fade-in + scale (0.8 → 1.0) driven by [logoAnimation]
/// - A repeating pulsing glow driven by [glowAnimation]
class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({
    super.key,
    required this.logoAnimation,
    required this.glowAnimation,
    required this.isMobile,
  });

  /// Controls the logo's opacity (0→1) and scale (0.8→1.0).
  final Animation<double> logoAnimation;

  /// Controls the pulsing glow intensity behind the logo (repeating).
  final Animation<double> glowAnimation;

  /// Whether the current layout is mobile.
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final double logoSize = isMobile
        ? 200.w.clamp(140, 260)
        : 400.w.clamp(160, 400);

    return AnimatedBuilder(
      animation: Listenable.merge([logoAnimation, glowAnimation]),
      builder: (context, child) {
        return Transform.scale(
          // Scale from 0.8 → 1.0 following the logo animation curve
          scale: 0.8 + (0.2 * logoAnimation.value),
          child: Opacity(
            opacity: logoAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withValues(
                      alpha: 0.12 + (0.18 * glowAnimation.value),
                    ),
                    blurRadius: 70 + (30 * glowAnimation.value),
                    spreadRadius: 20 + (15 * glowAnimation.value),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        );
      },
      child: Image.asset(
        AppBranding.logoWhiteCenter,
        width: logoSize,
        height: logoSize,
        fit: BoxFit.contain,
      ),
    );
  }
}
