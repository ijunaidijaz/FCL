import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/welcome_page.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/core/viewmodels/resetPassword_viewmodel.dart';
import 'package:fcl/core/viewmodels/auth_viewmodel.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class VerifyCodePage extends StatelessWidget {
  final bool isActivateEmail;
  final Function onSubmit;
  final isSignupEmail;
  final String email;

  VerifyCodePage({
    this.isActivateEmail = true,
    @required this.onSubmit,
    @required this.isSignupEmail,
    @required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final _notifierActivateEmail = Provider.of<AuthViewmodel>(context);
    final _notifierResetPassword = Provider.of<ResetPasswordViewmodel>(context);
    return BaseScaffold(
        isAction: false,
        isCenterLogo: false,
        isDrawer: false,
        centerTitle: "",
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: isActivateEmail
                  ? _notifierActivateEmail.activateEmailFormKey
                  : _notifierResetPassword.resetCodeFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // "Please enter the verification code you\nreceived on the registered email" +
                    //     "\n${isActivateEmail ? _notifierActivateEmail.signUpEmail.text : _notifierResetPassword.resetEmail}" +
                    //     "to verify"
                    "Please enter the Verification Code that you received in your registered Email",
                    textAlign: TextAlign.center,
                    style: textBody(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizes.blockSizeVertical * 3),
                    child: PinCodeTextField(
                      onDone: (value) {
                        isActivateEmail
                            ? _notifierActivateEmail.emailActivateCode = value
                            : _notifierResetPassword.resetCode = value;
                      },
                      pinBoxOuterPadding: EdgeInsets.symmetric(
                          horizontal: AppSizes.blockSizeVertical * 1.2),
                      pinBoxRadius: AppSizes.blockSizeVertical * 0.8,
                      pinBoxWidth: AppSizes.blockSizeHorizontal * 10.0,
                      pinBoxColor: kColorContainer,
                      hasTextBorderColor: Colors.transparent,
                      defaultBorderColor: Colors.transparent,
                      highlightPinBoxColor: kColorContainer,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  isActivateEmail
                      ? Align(
                    child: _notifierActivateEmail.state == ViewState.kBusy
                        ? progressIndicator()
                        : raisedBtnLg(
                        onPressed: () async {
                          await _notifierActivateEmail
                              .validateAndSubmitActivateEmail(
                              email: email,
                              isSignupEmail:
                              isSignupEmail ? true : false);

                          if (_notifierActivateEmail
                              .isActivateCodeSubmitted) {
                            _notifierActivateEmail.signInEmail
                                .clear();
                            _notifierActivateEmail.signUpEmail
                                .clear();
                            _notifierActivateEmail.signInpassword
                                .clear();
                            showToast(
                                msg:
                                "Verfication Code Submitted Successfully"
                                    .tr);

                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        WelcomePage(
                                          onSubmit: onSubmit,
                                        )));
                          } else {
                            if (_notifierActivateEmail.authMsg !=
                                null) {
                              showToast(
                                  msg:
                                  _notifierActivateEmail.authMsg);
                            }
                          }
                        },
                        text: "Verify Now".tr),
                  )
                      : Align(
                    child: _notifierResetPassword.state == ViewState.kBusy
                        ? progressIndicator()
                        : raisedBtnLg(
                        onPressed: () async {
                          await _notifierResetPassword
                              .validateAndSubmitResetCodeForm();

                          if (_notifierResetPassword
                              .isCodeSubmitted) {
                            NavRouter.navigator
                                .pushNamed(NavRouter.newPasswordPage);
                            showToast(
                                msg:
                                "Verfication Code Submitted Successfully"
                                    .tr);
                          } else {
                            if (_notifierResetPassword.authMsg !=
                                null) {
                              showToast(
                                  msg:
                                  _notifierResetPassword.authMsg);
                            }
                          }
                        },
                        text: "Verify Now".tr),
                  ),
                  InkWell(
                    onTap: () async {
                      if (isActivateEmail) {
                        await _notifierActivateEmail
                            .validateAndSubmitResendEmail(
                            isSignupEmail: isSignupEmail);

                        if (_notifierActivateEmail.isResendEmailSubmitted) {
                          showToast(
                              msg: "Verfication Code Sent Successfully".tr);
                        } else {
                          showToast(msg: _notifierActivateEmail.authMsg);
                        }
                      } else {
                        await _notifierResetPassword
                            .validateAndSubmitResetEmailForm();

                        if (_notifierResetPassword.isEmailSubmitted) {
                          showToast(
                              msg: "Verfication Code Sent Successfully".tr);
                        } else {
                          if (_notifierResetPassword.authMsg != null) {
                            showToast(msg: _notifierResetPassword.authMsg);
                          }
                        }
                      }
                    },
                    child: Text(
                      "Resend Code".tr,
                      textAlign: TextAlign.center,
                      style: textBody(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
