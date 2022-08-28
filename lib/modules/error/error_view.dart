import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, Exception? exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: XText.headlineLarge('404 not found'),
      ),
    );
  }
}
