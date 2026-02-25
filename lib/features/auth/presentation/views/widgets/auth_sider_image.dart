import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_images.dart';

class AuthSiderImage extends StatelessWidget {
  const AuthSiderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: AspectRatio(
        aspectRatio: 648 / 1024,
        child: SvgPicture.asset(
          AppImages.imagesWebAuthSider,
        ),
      ),
    );
  }
}
