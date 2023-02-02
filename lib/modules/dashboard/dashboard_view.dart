import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/modules/user_list/user_list_view.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/core/blocs/blocs.dart';
import 'package:flutter/material.dart';

part 'user_info_widget.dart';
part 'menu_item_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends XResponsiveTemplateWidget<DashboardView> {
  late ValueNotifier<Widget> _selectMenuNotifier;
  int _currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectMenuNotifier = ValueNotifier(
      const UserListView(),
    );
  }

  @override
  void dispose() {
    _selectMenuNotifier.dispose();
    super.dispose();
  }

  @override
  Widget mobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const XText.titleLarge('Dashboard'),
      ),
      drawer: Drawer(
        backgroundColor: context.primaryColor,
        child: _menuItemWidget(shouldPop: true),
      ),
      body: AnimatedBuilder(
        animation: _selectMenuNotifier,
        builder: (_, __) {
          AppRouting().goBack();
          return _selectMenuNotifier.value;
        },
      ),
    );
  }

  @override
  Widget webLayout(BuildContext context) {
    return AnimatedBuilder(
      animation: _selectMenuNotifier,
      builder: (_, __) {
        return Row(
          children: [
            Container(
              height: double.infinity,
              width: 250.0,
              color: context.primaryColor,
              child: _menuItemWidget(),
            ),
            Expanded(child: _selectMenuNotifier.value),
          ],
        );
      },
    );
  }

  Widget _menuItemWidget({bool shouldPop = false}) {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        const UserInfoWidget(),
        const SizedBox(height: 24.0),
        MenuItemWidget(
          title: 'Dashboard',
          isFirst: true,
          isParent: true,
          isSelected: _currentSelectedIndex == 0,
          onTap: () {
            _currentSelectedIndex = 0;
            shouldPop ? Navigator.pop(context) : null;
            _selectMenuNotifier.value = const UserListView();
          },
        ),
        const Spacer(),
        MenuItemWidget(
          title: 'Log Out',
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
            size: 20,
          ),
          isParent: false,
          isSelected: false,
          onTap: () {
            EventBus().event<SessionBloc>(
              Keys.Blocs.sessionBloc,
              const SessionLoggedOut(),
            );
          },
        ),
      ],
    );
  }
}
