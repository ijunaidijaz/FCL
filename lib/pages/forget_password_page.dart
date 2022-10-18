import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/pages/verfify_code_page.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/spacer_widget.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/core/viewmodels/resetPassword_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    final _notifier = Provider.of<ResetPasswordViewmodel>(context);
    return BaseScaffold(
        isDrawer: false,
        centerTitle: "",
        isCenterLogo: false,
        isAction: false,
        body: Center(
          child: Form(
            key: _notifier.resetPasswordFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Enter Your Username or\nEmail to Continue.".tr,
                  textAlign: TextAlign.center,
                  style: textBody(),
                ),
                spacerWidget(height: AppSizes.blockSizeVertical * 4.0),
                TxtField(
                  titletxt: "Username or Email".tr,
                  hinttxt: "Username or Email".tr,
                  validationerrortxt: null,
                  keyboardtype: TextInputType.name,
                  onsaved: (value) => _notifier.resetEmail = value,
                  validator: (value) => value.isEmpty
                      ? "Username or Email Can't be empty".tr
                      : null,
                ),
                Align(
                  child: _notifier.state == ViewState.kBusy
                      ? progressIndicator()
                      : raisedBtnLg(
                      onPressed: () async {
                        await _notifier.validateAndSubmitResetEmailForm();

                        if (_notifier.isEmailSubmitted) {
                          // NavRouter.navigator
                          //     .pushNamed(NavRouter.verifyCodePage);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  VerifyCodePage(
                                    email: _notifier.resetEmail,
                                    isActivateEmail: false,
                                    isSignupEmail: false,
                                    onSubmit: () {
                                      Navigator.of(context)
                                          .popUntil((_) => count++ >= 2);
                                    },
                                  )));

                          showToast(
                              msg: "Verfication Code Sent Successfully".tr);
                        } else {
                          if (_notifier.authMsg != null) {
                            showToast(msg: _notifier.authMsg);
                          }
                        }
                      },
                      text: "Continue".tr),
                ),
              ],
            ),
          ),
        ));
  }
}
