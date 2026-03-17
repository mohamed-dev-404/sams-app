import 'package:flutter/material.dart';
import 'package:sams_app/core/utils/styles/app_styles.dart';
import 'package:sams_app/core/utils/colors/app_colors.dart';
import 'package:sams_app/core/widgets/shared/tab_body_view.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/web/web_home_header.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/material_content_grid.dart';
import 'package:sams_app/features/materials/presentation/view/material_details/widget/web/material_details_side_card.dart';

class WebMaterialDetailsViewBody extends StatelessWidget {
  const WebMaterialDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WebHomeHeader(),
        Expanded(
          child: TabBodyView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                // This will force the children (SideCard and the Column) 
                // to have the same height
                crossAxisAlignment: CrossAxisAlignment.stretch, 
                children: [
                  // Sidebar info
                  const Expanded(
                    flex: 2,
                    child: MaterialDetailsSideCard(),
                  ),

                  // Main content
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            'Material Content',
                            style: AppStyles.webTitleMediumSb.copyWith(
                              color: AppColors.primaryDarkHover,
                              fontSize: MediaQuery.sizeOf(context).width * 0.022,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: MaterialContentGrid(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
