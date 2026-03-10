import 'package:flutter/material.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/mobile/mobile_home_app_bar.dart';
import 'package:sams_app/features/home/presentation/views/home/widgets/mobile/mobile_home_view_body.dart';

//* The mobile layout for the home screen
class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //TODO add name and imagePath
      appBar: MobileHomeAppBar(
        userName: 'Mohamed Mustafa',
        imagePath: 'https://d2hxnekkydd0t2.cloudfront.net/profiles/6999cca059fa76e5255bf86d_9b33a4.png',
      ),
      body: MobileHomeViewBody(),
    );
  }
}
