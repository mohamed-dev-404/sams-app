import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_app/core/utils/assets/app_icons.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/features/profile/data/models/user_model.dart';

class ProfilePicSection extends StatelessWidget {
  const ProfilePicSection({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Center(
        child: SizedBox(
          width: SizeConfig.screenWidth(context) * .35,
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.bottomRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: FittedBox(
                    child: SvgPicture.asset(
                      AppIcons.iconsHomeProfileHeader,
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteLight,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 5,
                  right: 0,
                  left: 75,
                  child: Container(
                    width: SizeConfig.isMobile(context)
                        ? SizeConfig.screenWidth(context) * .10
                        : SizeConfig.screenWidth(context) * .023,
                    height: SizeConfig.isMobile(context)
                        ? SizeConfig.screenWidth(context) * .10
                        : SizeConfig.screenWidth(context) * .023,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.iconsEditMaterial,
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteLight,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
