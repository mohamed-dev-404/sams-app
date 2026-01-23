//todo A general error page widget that displays a general error message

import 'package:flutter/material.dart';

class GeneralErrorPage extends StatelessWidget {
  const GeneralErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('404 page not found')));
  }
}
