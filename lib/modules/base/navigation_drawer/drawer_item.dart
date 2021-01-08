import 'package:flutter/material.dart';

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(this.title);

  @override

  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 30),
          _NavBarItem(title),
        ],
      ),
    );
  }
}