import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends XResponsiveTemplateWidget<LogInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  int _emailFocusTimes = 0;
  int _passwordFocusTimes = 0;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {
        _emailFocusTimes++;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordFocusTimes++;
      });
    });
  }

  AutovalidateMode _handleOutFocus(bool hasFocus, int focusTimes) {
    if (!hasFocus && focusTimes > 1) {
      return AutovalidateMode.always;
    }

    return AutovalidateMode.disabled;
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          XTextFormField(
            controller: emailTextController,
            labelText: 'Email',
            hintText: 'Enter your email...',
            validator: _validateEmail,
            prefixWidget: const Icon(
              Icons.email,
              size: 15,
            ),
            focusNode: _emailFocusNode,
            autoValidateMode: _handleOutFocus(
              _emailFocusNode.hasFocus,
              _emailFocusTimes,
            ),
          ),
          const SizedBox(height: 24.5),
          XPasswordTextFormField(
            controller: passwordTextController,
            labelText: 'Password',
            hintText: 'Enter your password...',
            validator: _validatePassword,
            showForgotPwd: false,
            errorIcon: Icon(
              Icons.warning_amber_rounded,
              color: context.errorColor,
            ),
            focusNode: _passwordFocusNode,
            autoValidateMode: _handleOutFocus(
              _passwordFocusNode.hasFocus,
              _passwordFocusTimes,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              XButton.negative(
                title: 'Log In',
                onPressed: () {
                  final form = _formKey.currentState!;
                  if (!form.validate()) {
                    return;
                  }
                },
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 24),
          BlocListener<SessionBloc, SessionState>(
            listenWhen: (previous, current) =>
                current is SessionLoadFailure || current is SessionLoadSuccess,
            listener: (_, state) {
              if (state is SessionLoadFailure) {
              } else if (state is SessionLoadSuccess) {
                AppNavigator().go('/${RouteName.dashboard}');
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
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
    return Center(
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (_, state) {
            log.info('Super Admin Logged In Success');
            if (state is SignInFailure) {
              
            }
          },
          child: _buildForm(),
        ),
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value.isNullOrEmpty()) {
      return 'Password is empty';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value.isNullOrEmpty()) {
      return 'Email is empty';
    }
    if (!value!.isEmail()) {
      return 'Email is invalid';
    }
    return null;
  }
}
