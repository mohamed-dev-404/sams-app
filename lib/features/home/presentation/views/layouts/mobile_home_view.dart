import 'package:flutter/material.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_home_app_bar.dart';
import 'package:sams_app/features/home/presentation/views/widgets/mobile_home_view_body.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileHomeAppBar(userName: 'Mohamed Mustafa'),
      body: MobileHomeViewBody(),
    );
  }
}
