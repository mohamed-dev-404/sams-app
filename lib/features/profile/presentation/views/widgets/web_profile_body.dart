import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/configs/size_config.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_header.dart';
import 'package:sams_app/features/profile/presentation/views/widgets/profile_main_layout_body.dart';

class WebProfileViewBody extends StatelessWidget {
  const WebProfileViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        // Sliver app bar
        const SliverToBoxAdapter(
          child: WebHomeHeader(),
        ),
        
        // Spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 5),
        ),

        // Title
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Profile',
              style: AppStyles.webTitleMediumMd.copyWith(
                color: AppColors.primaryDarkHover,
                fontSize: (width < 900) ? 30 : width * .024,
              ),
            ),
          ),
        ),

        // Spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),

        // Body
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300,
                maxWidth: 700,
              ),
              child: SizedBox(
                height: SizeConfig.isMobile(context)
                    ? SizeConfig.screenHeight(context) * .7
                    : SizeConfig.screenHeight(context) * .9,
                width: SizeConfig.screenWidth(context) * .27,

                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: AppColors.primary,
                  ),
                  child: const ProfileMainLayoutBody(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
