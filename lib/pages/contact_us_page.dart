import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/widgets/app_alerts.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:flutter/material.dart';

import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/core/viewmodels/contactus_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  DeviceInfoViewmodel deviceInfoViewmodel = DeviceInfoViewmodel();
  int count = 0;
  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  getDeviceInfo() async {
    await deviceInfoViewmodel.validateAndSubmitDeviceInfo(
        screenName: "Contact Us");
  }

  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<ContactusViewmodel>(context);
    return BaseScaffold(
        isAction: false,
        isCenterLogo: false,
        isCenterTitle: false,
        centerTitle: "Contact US".tr,
        isDrawer: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.blockSizeVertical * 6.0),
            child: Form(
              key: _notifier.contactusFormKey,
              child: Column(
                children: [
                  TxtField(
                    titletxt: "Full Name".tr,
                    hinttxt: "Full Name".tr,
                    validationerrortxt: null,
                    keyboardtype: TextInputType.name,
                    onsaved: (value) => _notifier.contactFullName = value,
                    validator: (value) =>
                        value.isEmpty ? "Full Name Can't be empty".tr : null,
                  ),
                  TxtField(
                    titletxt: "Email".tr,
                    hinttxt: "Email".tr,
                    validationerrortxt: null,
                    keyboardtype: TextInputType.emailAddress,
                    onsaved: (value) => _notifier.contactEmail = value,
                    validator: (value) =>
                        value.isEmpty ? "Email Can't be empty".tr : null,
                  ),
                  TxtField(
                    titletxt: "Message".tr,
                    hinttxt: "Message".tr,
                    validationerrortxt: null,
                    keyboardtype: TextInputType.multiline,
                    maxlines: 12,
                    onsaved: (value) => _notifier.contactMsg = value,
                    validator: (value) =>
                        value.isEmpty ? "Message Can't be empty".tr : null,
                  ),
                  Align(
                    child: _notifier.state == ViewState.kBusy
                        ? progressIndicator()
                        : raisedBtnLg(
                            onPressed: () async {
                              await _notifier.validateAndSubmitContactusForm();

                              if (_notifier.isFormSubmitted) {
                                // Navigator.pop(context);
                                showAlertDialogMessge(
                                    context,
                                    'Thank you for contacting us\nwe will reply as soon as possible'
                                        .tr, () {
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 2);
                                });
                                // Navigator.pop(context);
                                // showToast(msg: "Form Submitted Successfully");
                              } else {
                                if (_notifier.authMsg != null) {
                                  showToast(msg: _notifier.authMsg);
                                }
                              }
                            },
                            text: "Submit".tr),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
