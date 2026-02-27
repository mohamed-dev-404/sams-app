import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';

class CustomMobileTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTap;
  const CustomMobileTabBar({
    super.key,
    required this.tabs,
    required this.onTap,
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
          buttonMargin: const EdgeInsets.only(right: 10, left: 4),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          backgroundColor: AppColors.secondary,
          unselectedBackgroundColor: Colors.transparent,
          labelStyle: const TextStyle(
            color: AppColors.whiteLight,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.primaryDarkHover,
            fontWeight: FontWeight.bold,
          ),
          borderWidth: 1,
          unselectedBorderColor: AppColors.primaryDarkHover,
          radius: 8,
          tabs: tabs.map((title) => Tab(text: title)).toList(),
        ),
      ),
    );
  }
}
