import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/modules/common/common.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';

part 'user_table_view.dart';
part 'user_row_item.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(24),
      child: LoadList<User>(
        blocKey: Keys.Blocs.userListBloc,
        loadingIndicatorColor: Colors.black54,
        needPullToRefresh: false,
        itemSeparatorBuilder: (index) => Column(
          children: const [
            SizedBox(height: 6),
            Divider(height: 0, thickness: 0.5),
            SizedBox(height: 6),
          ],
        ),
        listRender: (users) => Row(
          children: [
            SizedBox(
              width: 800,
              child: UserTableView(users: users),
            ),
            const Spacer(),
          ],
        ),
        autoStart: true,
        emptyWidget: Center(
          child: Text(
            S.of(context).translate(Strings.Home.noUsers),
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
        ),
        needLoadMore: false,
      ),
    );
  }
}
