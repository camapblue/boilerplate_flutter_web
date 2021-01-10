import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';
import 'package:flutter/material.dart';

class _NavigationRowItem extends StatelessWidget {
  final String title;
  final Function onNavigateTo;
  final bool isSelected;

  _NavigationRowItem({
    @required this.title,
    @required this.onNavigateTo,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 44,
      padding: const EdgeInsets.all(4),
      child: InkWellButton(
        onTap: isSelected ? null : onNavigateTo,
        child: Text(
          title,
          style: isSelected
          ? Theme.of(context).primaryBold.copyWith(color: AppColors.pink)
          : Theme.of(context).primaryRegular.copyWith(color: grayColor),
        ),
      ),
    );
  }
}

class NavigationMenu extends StatefulWidget {
  const NavigationMenu();

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        children: [
          _NavigationRowItem(
            title: 'Home',
            onNavigateTo: () {
              AppNavigator().navigateTo(Pages.home);
              setState(() {
                _selectedIndex = 0;
              });
            },
            isSelected: _selectedIndex == 0,
          ),
          _NavigationRowItem(
            title: 'League',
            onNavigateTo: () {
              AppNavigator().navigateTo(Pages.league);
              setState(() {
                _selectedIndex = 1;
              });
            },
            isSelected: _selectedIndex == 1,
          )
        ],
      ),
    );
  }
}
