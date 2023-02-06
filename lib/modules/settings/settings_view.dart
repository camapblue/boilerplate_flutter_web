import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: XText('Settings Page'),
      ),
    );
  }
}
