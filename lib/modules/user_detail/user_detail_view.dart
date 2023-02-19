import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/model/model.dart';

class UserDetailView extends StatefulWidget {
  final User? user;
  final String userId;

  const UserDetailView({
    super.key,
    this.user,
    required this.userId,
  });

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.user != null) {
        EventBus().event(
          Keys.Blocs.userDetailBloc(widget.userId),
          UserDetailsSet(user: widget.user!),
        );
      } else {
        EventBus().event(
          Keys.Blocs.userDetailBloc(widget.userId),
          UserDetailsLoaded(userId: widget.userId),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: context.backgroundSubdued,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child:
          BlocBuilder<UserDetailsBloc, UserDetailsState>(builder: (_, state) {
        if (state is UserDetailsLoadSuccess) {
          final user = state.user;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              XText.headlineSmall(user.name),
              const SizedBox(
                height: 16,
              ),
              XText.bodySmall(user.email),
              const SizedBox(
                height: 8,
              ),
              XText.bodySmall(user.role.name),
            ],
          );
        }
        return const SizedBox();
      }),
    );
  }
}
