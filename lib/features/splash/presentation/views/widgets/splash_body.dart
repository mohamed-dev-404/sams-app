import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/assets/app_branding.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/features/splash/presentation/views/splash_controller.dart';
import 'package:sams_app/features/splash/presentation/views/widgets/splash_logo_widget.dart';
import 'package:sams_app/features/splash/presentation/views/widgets/splash_slogan_widget.dart';

/// The main splash screen composition with a sequenced animation pipeline.
///
/// **Animation Timeline:**
/// - `0 → 600ms` : Background gradient fades in
/// - `400 → 1200ms`: Logo fades in + scales (0.8 → 1.0)
/// - `1000ms → ∞`  : Glow pulsing begins (repeating)
/// - `1600 → 2300ms`: Slogan slides up + fades in
/// - `2500ms+`      : Navigation fires once init completes
class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  // ─────────────────────────── Controllers ───────────────────────────

  /// Master controller driving the entire animation sequence (3.2s total).
  late final AnimationController _sequenceController;

  /// Independent repeating controller for the glow pulse effect.
  late final AnimationController _glowController;

  // ─────────────────────────── Animations ────────────────────────────

  /// Background gradient opacity: 0 → 1 during [0, 0.19] of sequence.
  late final Animation<double> _backgroundAnimation;

  /// Logo opacity + scale factor: 0 → 1 during [0.125, 0.375] of sequence.
  late final Animation<double> _logoAnimation;

  /// Slogan opacity + translate offset: 0 → 1 during [0.5, 0.72] of sequence.
  late final Animation<double> _sloganAnimation;

  /// Glow pulse intensity: 0 → 1 → 0 (repeating sinusoidal).
  late final Animation<double> _glowAnimation;

  // ─────────────────────────── State ─────────────────────────────────

  /// The resolved route after init completes (null while loading).
  String? _targetRoute;

  /// Whether the minimum animation duration has elapsed.
  bool _animationComplete = false;

  /// Guard to prevent double-navigation.
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _initAnimations();
    _startInitialization();
    _sequenceController.forward();
  }

  void _initAnimations() {
    // Master sequence: 5000ms covers the entire entry animation
    _sequenceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..addStatusListener(_onSequenceComplete);

    // Glow pulse: 2s per cycle, starts after logo appears
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // ── Background: 0 → 600ms (0.0 → 0.1875 of 3200ms) ──
    _backgroundAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _sequenceController,
        curve: const Interval(0, 0.1875, curve: Curves.easeOut),
      ),
    );

    // ── Logo: 400 → 1200ms (0.125 → 0.375 of 3200ms) ──
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _sequenceController,
        curve: const Interval(0.125, 0.375, curve: Curves.easeOutCubic),
      ),
    );

    // ── Slogan: 1600 → 2300ms (0.5 → 0.72 of 3200ms) ──
    _sloganAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _sequenceController,
        curve: const Interval(0.5, 0.72, curve: Curves.easeOutQuart),
      ),
    );

    // ── Glow pulse: independent repeating 0 → 1 → 0 ──
    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Start glow after logo begins appearing (delayed by 1000ms)
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _glowController.repeat(reverse: true);
      }
    });
  }

  void _onSequenceComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationComplete = true;

      //! 🛑 FOR TESTING: Loop the animation automatically
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          _sequenceController.reset();
          _sequenceController.forward();
        }
      });
      //!--------------------------------------

      _tryNavigate();
    }
  }

  /// Runs auth check in parallel with the animation.
  Future<void> _startInitialization() async {
    final route = await SplashController.initializeAndGetRoute();

    if (!mounted) return;

    _targetRoute = route;

    // Ensure minimum 4.5s of splash visibility
    await Future.delayed(const Duration(milliseconds: 4500));

    if (mounted) {
      _animationComplete = true;
      _tryNavigate();
    }
  }

  /// Navigates once both conditions are met: animation done + route resolved.
  void _tryNavigate() {
    if (_hasNavigated) return;
    if (_targetRoute == null || !_animationComplete) return;

    _hasNavigated = true;
    context.go(_targetRoute!);
  }

  @override
  void dispose() {
    _sequenceController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  // ─────────────────────────── Build ─────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isMobile = SizeConfig.isMobile(context);

    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.lerp(
              const Color(0xFF000508),
              AppColors.primaryActive,
              _backgroundAnimation.value,
            ),
          ),
          child: child,
        );
      },
      child: _buildContent(isMobile),
    );
  }

  Widget _buildContent(bool isMobile) {
    return Stack(
      children: [
        // ── Left Background Watermark (Monogram) ──
        AnimatedBuilder(
          animation: _backgroundAnimation,
          builder: (context, _) {
            return Positioned(
              bottom: isMobile ? -50.h : -110.h,
              left: isMobile ? 5.w : -120.w,
              child: Opacity(
                opacity: _backgroundAnimation.value * 0.2,
                child: Image.asset(
                  AppBranding.monogramASymbolOnly,
                  width: isMobile ? 300 : 500.w,
                  fit: BoxFit.contain,
                  color: Colors.white,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            );
          },
        ),

        // ── Main centered content ──
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo with glow
              SplashLogoWidget(
                logoAnimation: _logoAnimation,
                glowAnimation: _glowAnimation,
                isMobile: isMobile,
              ),

              SizedBox(height: isMobile ? 24.h : 32.h),

              // Slogan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SplashSloganWidget(
                  sloganAnimation: _sloganAnimation,
                  isMobile: isMobile,
                ),
              ),
            ],
          ),
        ),

        // ── Bottom loading indicator ──
        _buildLoadingIndicator(isMobile),
      ],
    );
  }

  /// Subtle animated loading bar at the bottom of the screen.
  Widget _buildLoadingIndicator(bool isMobile) {
    return Positioned(
      bottom: isMobile ? 48.h : 40.h,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _sloganAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _sloganAnimation.value * 0.5,
            child: child,
          );
        },
        child: Center(
          child: SizedBox(
            width: isMobile ? 120.w : 160.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                minHeight: 2,
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
