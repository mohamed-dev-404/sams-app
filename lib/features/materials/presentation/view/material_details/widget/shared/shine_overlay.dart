import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

class ShineOverlay extends StatefulWidget {
  const ShineOverlay({super.key});

  @override
  State<ShineOverlay> createState() => _ShineOverlayState();
}

class _ShineOverlayState extends State<ShineOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shineController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _shineController.value - 0.4,
                _shineController.value,
                _shineController.value + 0.4,
              ],
              colors: [
                AppColors.whiteLight.withOpacity(0),
                AppColors.whiteLight.withOpacity(0.4), // Using your app's white
                AppColors.whiteLight.withOpacity(0),
              ],
            ),
          ),
        );
      },
    );
  }
}
