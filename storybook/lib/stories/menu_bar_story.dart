import 'package:common/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';

import '../storybook.dart';

class MenuBarStory extends Story {
  final List<String> data = [
    'Bean',
    'Beverage',
    'Meat',
    'Vegetable',
    'Noodle',
    'Baby',
    'Clothes',
    'Jewery'
  ];

  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Menu Bar - Text',
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          int pageIndex = 0;
          String pageTitle = data[pageIndex];
          Function renderFunction = () {};
          final MenuBarController menuController = MenuBarController();

          return Container(
            color: lightColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MenuBar(
                  menuController: menuController,
                  backgroundColor: redColorLight,
                  totalItem: data.length,
                  itemBuilder: (index, selected) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Text(
                      data[index],
                      style: selected
                          ? Theme.of(context).primaryBold.copyWith(
                                color: darkColor,
                                fontSize: 19,
                              )
                          : Theme.of(context).primaryRegular.copyWith(
                                color: grayColor,
                                fontSize: 19,
                              ),
                    ),
                  ),
                  onItemChanged: (int itemIndex) {
                    pageIndex = itemIndex;
                    pageTitle = data[itemIndex];

                    renderFunction();
                  },
                ),
                Expanded(
                  child: StatefulStory(
                    builder: () => Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Text(
                        '''Page ${pageIndex + 1} - $pageTitle''',
                        style: TextStyle(
                          color: ColorExtension.randomColor(),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    renderFunction: (render) {
                      renderFunction = render;
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    ];
  }
}
