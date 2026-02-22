import 'package:flutter/material.dart';
import 'package:sams_app/core/widgets/adaptive_layout.dart';
import 'package:sams_app/features/members_list/presentation/view/widget/members_list_mobile_layout.dart';
import 'package:sams_app/features/members_list/presentation/view/widget/members_list_web_layout.dart';

class MembersListTabView extends StatelessWidget {
  const MembersListTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (BuildContext context) {
        return const MembersListMobileLayout();
      },
      webLayout: (BuildContext context) {
        return const MembersListWebLayout();
      },
    );
  }
}
