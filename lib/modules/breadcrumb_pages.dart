import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/models/models.dart';

enum BreadcrumbPages {
  users,
  settings;

  BreadcrumbPage build({Map<String, dynamic> data = const {}}) {
    switch (this) {
      case BreadcrumbPages.users:
        return BreadcrumbPage(
          title: 'Users',
          linkTo: RouteName.Users.fullPath,
        );
      case BreadcrumbPages.settings:
        return BreadcrumbPage(
          title: 'Settings',
          linkTo: RouteName.Settings.fullPath,
        );
    }
  }
}
