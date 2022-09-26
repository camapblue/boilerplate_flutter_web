import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends XResponsiveTemplateWidget<LogInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
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
    return SizedBox(
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            XTextFormField(
              controller: _emailTextController,
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
              controller: _passwordTextController,
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
                XLinkButton(
                  title: S.of(context).translate(Strings.Button.forgotPassword),
                ),
                const Spacer(),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (_, state) {
                    final isSubmitting = state is SignInRequestInProgress;

                    return XButton.primary(
                      title: S.of(context).translate(Strings.Button.logIn),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      loading: isSubmitting,
                      onPressed: () {
                        final form = _formKey.currentState!;
                        if (!form.validate()) {
                          return;
                        }
                        EventBus().event<SignInBloc>(
                          Keys.Blocs.signInBloc,
                          SignInFormSubmitted(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            BlocListener<SessionBloc, SessionState>(
              listenWhen: (previous, current) =>
                  current is SessionLoadFailure ||
                  current is SessionLoadSuccess,
              listener: (_, state) {
                if (state is SessionLoadFailure) {
                }
              },
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  Widget _buildWelcomeWidget(
    BuildContext context, {
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppIcon(
              width: 111.0, height: 111.0, icon: AppIcons.placeholder),
          const SizedBox(height: 20.0),
          XText.displayMedium(
            S.of(context).translate(Strings.LogIn.welcomeTitle),
          ),
          const SizedBox(height: 16.0),
          XText.bodySmall(
            S.of(context).translate(Strings.LogIn.welcomeSubtitle),
          ),
          const SizedBox(height: 16.0),
          XText.bodyMedium(
            S.of(context).translate(Strings.LogIn.welcomeDescription),
          ),
        ],
      ),
    );
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
    return XTwoColumnResponsive(
      headerLayout: _buildWelcomeWidget(context),
      contentLayout: BlocListener<SignInBloc, SignInState>(
        listener: (_, state) {
          log.info('Super Admin Logged In Success');
          if (state is SignInFailure) {}
        },
        child: _buildForm(),
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
