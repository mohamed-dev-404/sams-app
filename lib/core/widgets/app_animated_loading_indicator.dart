import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

class AppAnimatedLoadingIndicator extends StatelessWidget {
  const AppAnimatedLoadingIndicator({super.key,  this.size = 50});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: AppColors.primary,
        rightDotColor: AppColors.secondary,
        size: size.sp.clamp(25, 65),
      ),
    );
  }
}
