import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

abstract class XStateWidget<T extends StatefulWidget> extends State<T>
    with RouteAware {
  late StreamSubscription<bool> _keyboardSubscription;

  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildContentView(context),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget buildFloatingActionButton(BuildContext context) => Container();

  bool get resizeToAvoidBottomInset => true;

  Widget buildContentView(BuildContext context) => const Center(
        child: Text('Build your layout'),
      );

  @override
  void didPush() {}

  @override
  void didPopNext() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _keyboardSubscription.cancel();
    super.dispose();
  }
}
