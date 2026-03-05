import 'package:flutter/material.dart';
import 'package:sams_app/core/enums/enum_user_role.dart';
import 'package:sams_app/core/models/course_header_card_model.dart';
import 'package:sams_app/core/widgets/mobile_coures_header_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/course_sliver_list.dart';
import 'package:sams_app/features/home/presentation/views/widgets/new_course_card.dart';
import 'package:sams_app/features/home/presentation/views/widgets/section_title.dart';

class MobileHomeViewBody extends StatelessWidget {
  const MobileHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(top: 20)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: MobileCoursesHeaderCard(
                cardModel: CourseHeaderCardModel(
                  description: 'Explore Your Courses',
                  title: 'Courses',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: 'My Courses',
            ),
          ),
            const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 7),
              child: NewCourseCard(
                role: CurrentRole.role,
                isMobile: true,
              ),
            ),
          ),
          const CourseSliverList(),
         ],
      ),
    );
  }
}
