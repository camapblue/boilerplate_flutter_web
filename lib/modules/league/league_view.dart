import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/material.dart';

class LeagueView extends StatelessWidget {
  const LeagueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: const Center(
        child: Text('League view'),
      ),
    );
  }
}
