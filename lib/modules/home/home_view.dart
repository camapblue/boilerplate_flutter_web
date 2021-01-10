import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: const Center(
        child: Text('Home view'),
      ),
    );
  }
}
