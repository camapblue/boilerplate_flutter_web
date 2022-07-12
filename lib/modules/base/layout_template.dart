import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/routes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:boilerplate_flutter_web/modules/base/navigation_drawer/navigation_drawer.dart';
import 'package:boilerplate_flutter_web/modules/base/centered_view.dart';
import 'package:boilerplate_flutter_web/modules/base/page_navigation_bar.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.isMobile ? const NavigationDrawer() : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              const PageNavigationBar(),
              Expanded(
                child: Container(
                  padding: sizingInformation.isMobile
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(16),
                  color: AppColors.light,
                  child: Navigator(
                    key: AppNavigator().navigatorKey,
                    onGenerateRoute: Routes.generateRoute,
                    initialRoute: Pages.home,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
