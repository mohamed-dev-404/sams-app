import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Animated slogan text with slide-up + fade-in effect.
///
/// Displays "The Future of Academic Management" with premium
/// letter-spacing and light weight typography.
class SplashSloganWidget extends StatelessWidget {
  const SplashSloganWidget({
    super.key,
    required this.sloganAnimation,
    required this.isMobile,
  });

  /// Controls both the opacity and vertical offset of the slogan.
  final Animation<double> sloganAnimation;

  /// Whether the current layout is mobile.
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sloganAnimation,
      builder: (context, child) {
        return Transform.translate(
          // Slide up from 24px below to final position
          offset: Offset(0, 24 * (1 - sloganAnimation.value)),
          child: Opacity(
            opacity: sloganAnimation.value,
            child: child,
          ),
        );
      },
      child: Text(
        'The Future of Academic Management',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: isMobile ? 14.sp.clamp(12, 16) : 18.sp.clamp(14, 22),
          fontWeight: FontWeight.w300,
          color: Colors.white.withValues(alpha: 0.72),
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}
