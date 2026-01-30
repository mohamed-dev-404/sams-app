import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

class AppAnimatedLoadingIndicator extends StatelessWidget {
  const AppAnimatedLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: AppColors.primary,
        rightDotColor: AppColors.secondary,
        size: 50,
      ),
    );
  }
}