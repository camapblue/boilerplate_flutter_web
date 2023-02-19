import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/models/models.dart';
import 'package:repository/model/model.dart';

enum BreadcrumbPages {
  users,
  settings,
  userDetail;

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
      case BreadcrumbPages.userDetail:
        final userId = data['userId'];
        final user = data['user'] as User?;
        return BreadcrumbPage(
          title: user?.name ?? userId,
          linkTo: RouteName.UserDetail.fullPath(userId),
          params: {'user': user},
        );
    }
  }
}
