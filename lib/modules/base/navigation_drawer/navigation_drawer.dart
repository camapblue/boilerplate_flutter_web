import 'package:boilerplate_flutter_web/modules/base/navigation_drawer/navigation_drawer_header.dart';
import 'package:flutter/material.dart';

import 'drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)]),
      child: Column(
        children: const <Widget>[
          NavigationDrawerHeader(),
          DrawerItem('Episodes', Icons.videocam),
          DrawerItem('About', Icons.help),
        ],
      ),
    );
  }
}