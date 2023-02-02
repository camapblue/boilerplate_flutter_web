import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends XResponsiveTemplateWidget<SplashView> {
  @override
  void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EventBus().event<SessionBloc>(
        Keys.Blocs.sessionBloc,
        const SessionLoaded(),
      );
    });

    super.initState();
  }

  @override
  Widget mobileLayout(BuildContext context) {
    return const XOneColumnResponsive(
      headerLayout: SizedBox(),
      contentLayout: Center(
        child: XText.bodyMedium('Not support mobile resolution'),
      ),
    );
  }

  @override
  Widget webLayout(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (_, state) {
        AppRouting().go(state.loggedInUser != null
            ? RouteName.Dashboard.path
            : RouteName.LogIn.path);
      },
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
