import 'package:flutter/widgets.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/widgets/web_course_header_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/courses_sliver_grid.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_header.dart';

class WebHomeViewBody extends StatelessWidget {
  const WebHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: WebHomeHeader()),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          sliver: SliverToBoxAdapter(
            child: WebCourseHeaderCard(
              cardModel: CourseHeaderCardModel(
                description:
                    'Stay informed about important campus news, academic updates, and events.',
                title: 'Courses',
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          sliver: SliverToBoxAdapter(
            child: Text('My Courses', style: AppStyles.webTitleMediumSb),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        const CoursesSliverGrid(),

        const SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }
}
