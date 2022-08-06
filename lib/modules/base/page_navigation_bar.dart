import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18),
    );
  }
}

class _NavigationBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: greenColorLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 48,
            width: 64,
            child: AppImage(image: AppImagesAsset.logo),
          ),
          Text(
            'Boilerplate',
            style: Theme.of(context).primaryBold.copyWith(
                  color: AppColors.dark,
                ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarTabletDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: greenColorLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                height: 64,
                width: 100,
                child: AppImage(image: AppImagesAsset.logo),
              ),
              Text(
                'Boilerplate',
                style: Theme.of(context).primaryBold.copyWith(
                      color: AppColors.dark,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              _NavBarItem('Episodes'),
              SizedBox(
                width: 60,
              ),
              _NavBarItem('About'),
            ],
          )
        ],
      ),
    );
  }
}

class PageNavigationBar extends StatelessWidget {
  const PageNavigationBar({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _NavigationBarMobile(),
      tablet: _NavigationBarTabletDesktop(),
    );
  }
}
