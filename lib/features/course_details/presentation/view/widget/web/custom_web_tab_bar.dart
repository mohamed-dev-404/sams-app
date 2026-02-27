import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';

class CustomWebTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTap;
  final int currentIndex;
  const CustomWebTabBar({
    super.key,
    required this.tabs,
    required this.onTap,
    required this.currentIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(side: null),
        ),
      ),
      child: SizedBox(
        height: 35,
        child: ButtonsTabBar(
          onTap: onTap,
          key: ValueKey(currentIndex),
          buttonMargin: const EdgeInsets.symmetric(horizontal: 10),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          borderWidth: 1,
          borderColor: Colors.transparent,
          unselectedBackgroundColor: Colors.transparent,
          unselectedBorderColor: AppColors.whiteLight,
          backgroundColor: AppColors.secondary,
          radius: 8,
          labelStyle: AppStyles.mobileBodySmallMd.copyWith(
            color: AppColors.whiteLight,
          ),
          unselectedLabelStyle: AppStyles.mobileBodySmallMd.copyWith(
            color: AppColors.whiteLight,
          ),
          tabs: tabs.map((title) => Tab(text: title)).toList(),
        ),
      ),
    );
  }
}
