import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/verfify_code_page.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/core/viewmodels/auth_viewmodel.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/widgets/text_link_widget.dart';
import 'package:flutter/material.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<AuthViewmodel>(context);
    int count = 0;
    AppSizes().init(context);
    return BaseScaffold(
        isAppbar: false,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _notifier.signinFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to".tr,
                    style: textSubTitle(),
                  ),
                  Text(
                    "Fans Champion League",
                    style: textSubTitle(color: kColorAccent),
                  ),
                  spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
                  TxtField(
                    titletxt: "Username or Email ID".tr,
                    hinttxt: "Username or Email ID".tr,
                    validationerrortxt: null,
                    keyboardtype: TextInputType.emailAddress,
                    // onsaved: (value) => _notifier.signInEmail.text = value,
                    controller: _notifier.signInEmail,
                    validator: (value) => value.isEmpty
                        ? "Email or Username Can't be empty".tr
                        : null,
                  ),
                  TxtField(
                    titletxt: "Password".tr,
                    hinttxt: "Password".tr,
                    validationerrortxt: null,
                    keyboardtype: TextInputType.visiblePassword,
                    ishidden: true,
                    controller: _notifier.signInpassword,
                    // onsaved: (value) => _notifier.signInpassword.text = value,
                    validator: (value) =>
                        value.isEmpty ? "Password Can't be empty".tr : null,
                  ),
                  Align(
                    child: _notifier.state == ViewState.kBusy
                        ? progressIndicator()
                        : raisedBtnLg(
                            onPressed: () async {

                              await _notifier.validateAndSubmitSignin();

                              if (_notifier.isSignin) {
                                // _notifier.signInEmail.clear();
                                // _notifier.signInpassword.clear();

                                NavRouter.navigator
                                    .pushNamed(NavRouter.onBoardingPage);
                                showToast(msg: "Login Successfully".tr);
                              } else {
                                if (_notifier.authMsg != null) {
                                  showToast(msg: _notifier.authMsg);
                                }

                                if (_notifier.isEmailVerified != true) {
                                  // NavRouter.navigator
                                  //     .pushNamed(NavRouter.activateEmailPage);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          VerifyCodePage(
                                            isSignupEmail: false,
                                            onSubmit: () {
                                              Navigator.of(context).popUntil(
                                                  (_) => count++ >= 2);
                                            },
                                          )));
                                }
                              }
                            },
                            text: "Login".tr),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppSizes.blockSizeHorizontal * 7.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => NavRouter.navigator
                            .pushNamed(NavRouter.forgetPasswordPage),
                        child: Text(
                          "Forget Password".tr,
                          style: textBody(),
                        ),
                      ),
                    ),
                  ),
                  spacerWidget(height: AppSizes.blockSizeVertical * 3.0),
                  textWithLinkWidget(
                      text: "Not Registered?".tr,
                      linkText: "Sign Up Now".tr,
                      onTap: () =>
                          NavRouter.navigator.pushNamed(NavRouter.signupPage)),
                ],
              ),
            ),
          ),
        ));
  }
}
