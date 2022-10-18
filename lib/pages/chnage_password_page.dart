import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/core/viewmodels/auth_viewmodel.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/pages/edit_profile_submit_page.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<AuthViewmodel>(context);
    return BaseScaffold(
        body: Center(
      child: Form(
        key: _notifier.changePasswordFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TxtField(
                ishidden: true,
                titletxt: "Old Password".tr,
                hinttxt: "Old Password".tr,
                validationerrortxt: null,
                keyboardtype: TextInputType.visiblePassword,
                onsaved: (value) => _notifier.changePasswordOld = value,
                validator: (value) =>
                    value.isEmpty ? "Old Password Can't be empty".tr : null,
              ),
              TxtField(
                ishidden: true,
                titletxt: "New Password".tr,
                hinttxt: "New Password".tr,
                validationerrortxt: null,
                keyboardtype: TextInputType.visiblePassword,
                onsaved: (value) => _notifier.changePasswordNew = value,
                validator: (value) =>
                    value.isEmpty ? "New Password Can't be empty".tr : null,
              ),
              TxtField(
                ishidden: true,
                titletxt: "Repeat Password".tr,
                hinttxt: "Repeat Password".tr,
                validationerrortxt: null,
                keyboardtype: TextInputType.visiblePassword,
                onsaved: (value) => _notifier.changePasswordConfirm = value,
                validator: (value) =>
                    value.isEmpty ? "Repeat Password Can't be empty".tr : null,
              ),
              Align(
                child: _notifier.state == ViewState.kBusy
                    ? progressIndicator()
                    : raisedBtnLg(
                        onPressed: () async {
                          await _notifier.validateAndSubmitChangePassword();
                          if (_notifier.isPasswordChanged) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return EditProfileSubmitPage();
                            }));
                            showToast(msg: "Password Changed Successfully".tr);

                            // Navigator.pop(context);
                          } else {
                            showToast(msg: _notifier.authMsg);
                          }
                        },
                        text: "Change".tr),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
