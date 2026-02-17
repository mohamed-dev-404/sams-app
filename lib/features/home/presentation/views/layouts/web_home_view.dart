import 'package:flutter/material.dart';
import 'package:sams_app/features/home/presentation/views/widgets/web_home_view_body.dart';

class WebHomeView extends StatelessWidget {
  const WebHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: WebHomeViewBody(),
    );
  }
}
