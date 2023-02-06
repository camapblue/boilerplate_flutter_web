import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/blocs/mixin/mixin.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/modules/common/breadcrumb/breadcrumb.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/core/blocs/blocs.dart';
import 'package:flutter/material.dart';

part 'menu_item_widget.dart';
part 'main_menu.dart';

class DashboardView extends StatefulWidget {
  final Widget child;
  const DashboardView(this.child, {Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends XResponsiveTemplateWidget<DashboardView>
    with SessionData {
  @override
  Widget mobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const XText.titleLarge('Dashboard'),
      ),
      body: const Center(
        child: XText.titleMedium('Not support mobile layout'),
      ),
    );
  }

  @override
  Widget webLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          height: double.infinity,
          width: 280.0,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: const MainMenu(),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    BlocBuilder<SessionBloc, SessionState>(
                      buildWhen: (_, current) =>
                          current is SessionUserLogInSuccess,
                      builder: (_, state) {
                        return XText.titleLarge(
                          'Hi ${state.loggedInUser?.name ?? ''}',
                        );
                      },
                    ),
                    const Spacer(),
                    const Icon(Icons.search),
                    const SizedBox(width: 12),
                    const Icon(Icons.notifications),
                    const SizedBox(width: 12),
                    const CircleAvatar(
                      minRadius: 16,
                      backgroundImage: NetworkImage(
                        AppConstants.DefaultUserIconUrl,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: context.backgroundSubdued,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: const Breadcrumb(),
                        ),
                        Divider(
                          color: context.borderColor,
                          height: 2,
                          thickness: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              key: AppRouting().dashboardContentKeyForRender(),
                              child: widget.child,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
