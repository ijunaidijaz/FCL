import 'package:fcl/pages/verfify_code_page.dart';
import 'package:fcl/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:fcl/pages/master_views/base_scaffold.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';
import 'package:fcl/utils/app_date_format.dart';
import 'package:fcl/core/viewmodels/auth_viewmodel.dart';
import 'package:fcl/widgets/app_buttons.dart';
import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:fcl/widgets/app_toast.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:fcl/widgets/text_fields.dart';
import 'package:fcl/widgets/app_calendar_filed.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  AuthViewmodel authViewmodel;
  DateTime picker;
  DateTime dob;
  @override
  Widget build(BuildContext context) {
    int count = 0;
    final _notifier = Provider.of<AuthViewmodel>(context);
    return BaseScaffold(
        isDrawer: false,
        isAction: false,
        isCenterLogo: false,
        centerTitle: "Create Account".tr,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _notifier.signupFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizes.blockSizeVertical * 3.0),
                    child: Text(
                      "Enter Your Information".tr,
                      style: textSubTitle(),
                    ),
                  ),
                  TxtField(
                    titletxt: "First Name".tr,
                    hinttxt: "First Name".tr,
                    validationerrortxt: "First Nome Can't be empty".tr,
                    keyboardtype: TextInputType.name,
                    // onsaved: (value) => _notifier.signupFirstName = value,
                    controller: _notifier.signUpFirstName,
                    validator: (value) =>
                        value.isEmpty ? "First Nome Can't be empty".tr : null,
                  ),
                  TxtField(
                    titletxt: "Last Name",
                    hinttxt: "Last Name",
                    validationerrortxt: "Last Nome Can't be empty".tr,
                    keyboardtype: TextInputType.name,
                    // onsaved: (value) => _notifier.signupLastName = value,
                    controller: _notifier.signUpLastName,
                    validator: (value) =>
                        value.isEmpty ? "Last Nome Can't be empty".tr : null,
                  ),
                  InkWell(
                      onTap: () async {
                        picker = await calendarWidget(context: context);

                        setState(() {
                          dob = picker;
                          // _notifier.signupBirth =
                          //     dateFormatYearBefore(dob).toString();

                          _notifier.signUpBirth.text =
                              dateFormatYearBefore(dob).toString();
                        });
                        print(picker);
                      },
                      child: calendarFiled(
                          dateTxt: dob != null
                              ? dateFormat(dob)
                              : "Date of Birth".tr)),
                  TxtField(
                    titletxt: "Email",
                    hinttxt: "Email",
                    validationerrortxt: "Email Can't be empty".tr,
                    keyboardtype: TextInputType.emailAddress,
                    // onsaved: (value) => _notifier.signupEmail = value,
                    controller: _notifier.signUpEmail,
                    validator: (value) =>
                        value.isEmpty ? "Email Can't be empty".tr : null,
                  ),
                  TxtField(
                    titletxt: "Username".tr,
                    hinttxt: "Username".tr,
                    validationerrortxt: "Username Can't be empty".tr,
                    keyboardtype: TextInputType.name,
                    // onsaved: (value) => _notifier.signupUsername = value,
                    controller: _notifier.signUpUsername,
                    validator: (value) =>
                        value.isEmpty ? "Username Can't be empty".tr : null,
                  ),
                  txtFieldContactNumber(
                    notifier: _notifier,
                    validator: (value) => value.isEmpty
                        ? "Contact Number Can't be empty".tr
                        : null,
                    // onsaved: (value) => _notifier.signupMobileNumber = value,
                    controller: _notifier.signUpMobileNumber,
                  ),
                  TxtField(
                    titletxt: "Password".tr,
                    hinttxt: "Password".tr,
                    ishidden: true,
                    validationerrortxt: "Password Can't be empty".tr,
                    keyboardtype: TextInputType.visiblePassword,
                    // onsaved: (value) => _notifier.signupPassword = value,
                    controller: _notifier.signUpPassword,
                    validator: (value) =>
                        value.isEmpty ? "Password Can't be empty".tr : null,
                  ),
                  TxtField(
                    titletxt: "Confirm Password".tr,
                    hinttxt: "Confirm Password".tr,
                    ishidden: true,
                    validationerrortxt: "Confirm Password Can't be empty".tr,
                    keyboardtype: TextInputType.visiblePassword,
                    // onsaved: (value) => _notifier.signupConfirmPassword = value,
                    controller: _notifier.signUpConfirmPassword,
                    validator: (value) => value.isEmpty
                        ? "Confirm Password Can't be empty".tr
                        : null,
                  ),
                  Align(
                    child: _notifier.state == ViewState.kBusy
                        ? progressIndicator()
                        : raisedBtnLg(
                            onPressed: () async {
                              await _notifier.validateAndSubmitSignup();
                              if (_notifier.isSignup) {
                                print("=======i am here =====");
                                // _notifier.signUpEmail.clear();
                                _notifier.signUpFirstName.clear();
                                _notifier.signUpLastName.clear();
                                _notifier.signUpUsername.clear();
                                _notifier.signUpPassword.clear();
                                _notifier.signUpConfirmPassword.clear();
                                _notifier.signUpBirth.clear();
                                _notifier.signUpMobileNumber.clear();

                                // NavRouter.navigator
                                //     .pushNamed(NavRouter.activateEmailPage);
                                // showToast(msg: "Signup Successfully");

                                // Navigator.pop(context);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VerifyCodePage(
                                          isSignupEmail: true,
                                          onSubmit: () {
                                            Navigator.of(context)
                                                .popUntil((_) => count++ >= 3);
                                          },
                                        )));
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
          ),
        ));
  }

  Widget txtFieldContactNumber({
    Function(String) onsaved,
    TextEditingController controller,
    @required String Function(String) validator,
    @required AuthViewmodel notifier,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.blockSizeHorizontal * 2.0,
          vertical: AppSizes.blockSizeHorizontal * 2.0),
      child: Container(
        decoration: BoxDecoration(
            color: kColorContainer,
            borderRadius:
            BorderRadius.circular(AppSizes.blockSizeHorizontal * 7.0)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: AppSizes.blockSizeHorizontal * 25,
                  child: CountryCodePicker(
                      initialSelection: "+965",
                      countryFilter: [
                        "+965",
                        "+966",
                        "+968",
                        "+973",
                        "+971",
                        "+964",
                        "+974"
                      ],
                      onChanged: (code) {
                        print(code.toString());
                        setState(() {
                          notifier.signUpCountryCode.text = code.dialCode;
                          // notifier.signupCountryCode = code.dialCode;
                        });
                      },
                      onInit: (code) {
                        // notifier.signupCountryCode = code.dialCode;
                        notifier.signUpCountryCode.text = code.dialCode;
                        print(
                            "on init ${code.name} ${code.dialCode} ${code.name}");
                      }),
                ),
                Expanded(
                  child: TextFormField(
                      controller: controller,
                      onSaved: onsaved,
                      validator: validator,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "+1 320 45214 444",
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            gapPadding: 10.0,
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
