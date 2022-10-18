import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/router/router.gr.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/core/viewmodels/resetPassword_viewmodel.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<ResetPasswordViewmodel>(context);
    return BaseScaffold(
        isDrawer: false,
        isAction: false,
        isCenterLogo: false,
        centerTitle: "Change Password".tr,
        isCenterTitle: false,
        body: Center(
          child: Form(
            key: _notifier.newPasswordFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TxtField(
                  titletxt: "New Password".tr,
                  hinttxt: "New Password".tr,
                  validationerrortxt: null,
                  ishidden: true,
                  keyboardtype: TextInputType.visiblePassword,
                  onsaved: (value) => _notifier.newPassword = value,
                  validator: (value) =>
                      value.isEmpty ? "New Password Can\'t be empty".tr : null,
                ),
                Align(
                  child: _notifier.state == ViewState.kBusy
                      ? progressIndicator()
                      : raisedBtnLg(
                          onPressed: () async {
                            await _notifier.validateAndSubmitNewPasswordForm();

                            if (_notifier.isNewPasswordSubmitted) {
                              NavRouter.navigator
                                  .pushNamed(NavRouter.passwordSuccessPage);
                              showToast(
                                  msg: "Password Changed Successfully".tr);
                            } else {
                              showToast(msg: _notifier.authMsg);
                            }
                          },
                          text: "Change".tr),
                ),
              ],
            ),
          ),
        ));
  }
}
