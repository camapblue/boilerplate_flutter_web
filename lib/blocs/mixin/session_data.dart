import 'package:repository/model/model.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:common/core/core.dart';

mixin SessionData {
  bool get isGuest =>
      EventBus()
          .blocFromKey<SessionBloc>(Keys.Blocs.sessionBloc)
          ?.state
          .loggedInUser ==
      null;

  User? get currentUser => EventBus()
      .blocFromKey<SessionBloc>(Keys.Blocs.sessionBloc)
      ?.state
      .loggedInUser;
}
