import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';

class AppAnimatedLoadingIndicator extends StatelessWidget {
  const AppAnimatedLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.isMobile(context) ? 35 : 50;
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: AppColors.primary,
        rightDotColor: AppColors.secondary,
        size: size.sp.clamp(35, 65),
      ),
    );
  }
}
