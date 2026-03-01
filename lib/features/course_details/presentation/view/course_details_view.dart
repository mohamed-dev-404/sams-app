import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/mobile/tab_bar_mobile_layout.dart';
import 'package:sams_app/features/course_details/presentation/view/widget/web/tab_bar_web_layout.dart';
import 'package:sams_app/features/course_details/presentation/view_models/course_navigation/course_navigation_cubit.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_course_card.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({
    super.key,
    required this.child,
    required this.headerModel,
    required this.courseId,
  });

  final Widget child;
  final String courseId;
  final CourseHeaderCardModel headerModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseNavigationCubit(userRole: UserRole.student),
      child: AdaptiveLayout(
        mobileLayout: (context) => TabBarMobileLayout(
          child: child,
          headerModel: headerModel,
          courseId: courseId,
        ),
        webLayout: (context) => TabBarWebLayout(
          child: child,
          courseId: courseId,
          headerModel: headerModel,
        ),
      ),
    );
  }
}
