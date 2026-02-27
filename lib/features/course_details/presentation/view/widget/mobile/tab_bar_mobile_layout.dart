import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/widgets/mobile_coures_header_card.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/mobile/custom_mobile_tab_bar.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';

class TabBarMobileLayout extends StatelessWidget {
  const TabBarMobileLayout({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseNavigationCubit>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              MobileCoursesHeaderCard(
                cardModel: CourseHeaderCardModel(
                  title: 'Database',
                  instructor: 'Julie Watson',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomMobileTabBar(
                  tabs: cubit.tabs,
                  onTap: (index) {
                    navigationShell.goBranch(index);
                  },
                  currentIndex: navigationShell.currentIndex,
                ),
              ),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      ),
    );
  }
}
