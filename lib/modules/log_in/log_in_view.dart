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
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _validEmail = false;
  bool _validPassword = false;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  Widget _buildForm() {
    return SizedBox(
      width: double.infinity,
      child: BlocListener<SessionBloc, SessionState>(
        listener: (_, state) {
          if (state is SessionUserLogInSuccess) {
            AppRouting().goToName(RouteName.Dashboard.name);
          } else if (state is SessionLoadFailure) {}
        },
        child: BlocConsumer<SignInBloc, SignInState>(listener: (_, state) {
          if (state is SignInFailure) {
            if (state.error == SignInError.wrongEmail ||
                state.error == SignInError.notFoundUserByEmail) {
              setState(() {
                _emailErrorMessage =
                    context.translate(Strings.LogIn.errorEmailNotFound);
                _passwordErrorMessage = null;
              });
            } else if (state.error == SignInError.wrongPassword) {
              setState(() {
                _passwordErrorMessage =
                    context.translate(Strings.LogIn.errorWrongPassword);
                _emailErrorMessage = null;
              });
            }
          }
        }, builder: (_, state) {
          final loading = state is SignInRequestInProgress;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValidatorInput(
                title: context.translate(Strings.LogIn.emailTitle),
                placeholder: context.translate(Strings.LogIn.emailPlaceholder),
                onFieldSubmitted: print,
                textInputAction: TextInputAction.next,
                onValid: (value) {
                  setState(() {
                    _validEmail = value != null;
                    _emailErrorMessage = null;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                textController: _emailTextController,
                errorMessage: _emailErrorMessage,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.email_outlined,
                    color: AppColors.dark,
                    size: 20,
                  ),
                ),
                validatorRules: [
                  InputValidatorRule.require(
                    errorMessage: context.translate(
                      Strings.LogIn.validatorEmailIsRequired,
                    ),
                  ),
                  InputValidatorRule(
                    validator: (input) => input != null && input.isEmail(),
                    errorMessage: context.translate(
                      Strings.LogIn.validatorEmailIsInvalid,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              PasswordInput(
                title: context.translate(Strings.LogIn.passwordTitle),
                placeholder: context.translate(
                  Strings.LogIn.passwordPlaceholder,
                ),
                onFieldSubmitted: print,
                passwordRule: InputValidatorRule(
                  errorMessage: context.translate(
                    Strings.LogIn.validatorPasswordIsInvalid,
                  ),
                  validator: (input) => input != null && input.length > 6,
                ),
                textController: _passwordTextController,
                errorMessage: _passwordErrorMessage,
                onValid: (value) {
                  setState(() {
                    _validPassword = value != null;
                    _passwordErrorMessage = null;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: XLinkButton(
                  title: context.translate(Strings.LogIn.buttonForgotPassword),
                  fontSize: 13,
                  onPressed: () {
                    
                  },
                ),
              ),
              const SizedBox(height: 24),
              XButton.primary(
                title: context.translate(Strings.Button.logIn),
                onPressed: _validEmail && _validPassword
                    ? () {
                        EventBus().event<SignInBloc>(
                          Keys.Blocs.signInBloc,
                          SignInFormSubmitted(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          ),
                        );
                      }
                    : null,
                loading: loading,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Spacer(),
                  XText.bodyMedium(
                    context.translate(Strings.LogIn.dontHaveAccount),
                  ).customWith(
                    context,
                    color: AppColors.lightGray,
                    fontSize: 13,
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: XLinkButton(
                      title: context.translate(Strings.LogIn.buttonSignUpNow),
                      fontSize: 13,
                      onPressed: () {
                        
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          );
        }),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 720,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImagesAsset.logInBackground,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SizedBox(
              width: 360,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  XText.bodyMedium(context.translate(Strings.LogIn.subtitle)),
                  const SizedBox(height: 8),
                  XText.displayMedium(context.translate(Strings.LogIn.title)),
                  const SizedBox(height: 32),
                  _buildForm(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
