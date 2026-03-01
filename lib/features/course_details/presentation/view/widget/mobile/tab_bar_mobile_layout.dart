import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/widgets/mobile_coures_header_card.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/mobile/custom_mobile_tab_bar.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';

class TabBarMobileLayout extends StatelessWidget {
  const TabBarMobileLayout({
    super.key,
    required this.navigationShell,
    required this.headerModel,
    required this.courseId,
  });

  final StatefulNavigationShell navigationShell;
  final CourseHeaderCardModel headerModel;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseNavigationCubit>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
             MobileCoursesHeaderCard(cardModel: headerModel   ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: CustomMobileTabBar(
                  tabs: cubit.visibleTabs.map((e) => e.title).toList(),
                  onTap: (uiIndex) {
                    final targetBranchIndex =
                        cubit.visibleTabs[uiIndex].branchIndex;
                    navigationShell.goBranch(
                      targetBranchIndex,
                      initialLocation:
                          targetBranchIndex == navigationShell.currentIndex,
                    );
                  },
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
