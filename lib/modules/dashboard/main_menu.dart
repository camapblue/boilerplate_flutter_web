part of 'dashboard_view.dart';

enum MainMenuItem {
  users,
  settings;

  String get title {
    switch (this) {
      case MainMenuItem.users:
        return Strings.Dashboard.mainMenuUsers;
      case MainMenuItem.settings:
        return Strings.Dashboard.mainMenuSettings;
    }
  }

  String get path {
    switch (this) {
      case MainMenuItem.users:
        return RouteName.Users.fullPath;
      case MainMenuItem.settings:
        return RouteName.Settings.fullPath;
    }
  }

  bool isSelected(String location) {
    return location.contains(path);
  }

  static List<MainMenuItem> allItems() {
    return <MainMenuItem>[
      MainMenuItem.users,
      MainMenuItem.settings,
    ];
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with SessionData {
  late String _currentPath;

  @override
  void initState() {
    super.initState();

    _currentPath = AppRouting().currentPath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      buildWhen: (_, current) => current is SessionUserLogInSuccess,
      builder: (_, state) {
        return Column(
          children: [
            const SizedBox(height: 24.0),
            IconButton(
              onPressed: () {
                AppRouting().goToName(RouteName.Dashboard.name);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: AppImage.appIcon(),
            ),
            const SizedBox(height: 12),
            ...MainMenuItem.allItems().map(
              (e) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: MenuItemWidget(
                    title: e.title,
                    isSelected: e.isSelected(_currentPath),
                    onTap: () {
                      setState(() {
                        _currentPath = e.path;
                      });
                      AppRouting().go(e.path);
                    },
                  ),
                );
              },
            ).toList(),
            const Spacer(),
            MenuItemWidget(
              title: 'Log Out',
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.logout, size: 20),
              ),
              isSelected: false,
              titleStyle: context.headlineSmall?.copyWith(
                color: AppColors.gray,
              ),
              onTap: () {
                EventBus().event<SessionBloc>(
                  Keys.Blocs.sessionBloc,
                  const SessionLoggedOut(),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }
}
