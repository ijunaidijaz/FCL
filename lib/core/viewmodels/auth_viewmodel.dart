import 'dart:convert';
import 'package:fcl/core/viewmodels/cloud_messaging_viewmodel.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fcl/utils/app_login_token.dart';
import 'base_viewmodel.dart';

class AuthApi {
  bool isSignupApi;
  AuthApi({@required this.isSignupApi});

  postData(data) async {
    return await _http.post(
      isSignupApi ? Uri.parse(kSignupApi) : Uri.parse(kSigninApi),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}

class ActivateEmailApi {
  postActivateEmailData(data) async {
    return await _http.post(
      Uri.parse(kActivateAccountApi),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  postResendEmailData(data) async {
    return await _http.post(
      Uri.parse(kResendActivateAccountApi),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}

class AuthViewmodel extends BaseViewmodel {
  String
      // signupFirstName,
      // signupLastName,
      // signupBirth,
      // signupEmail,
      // signupUsername,
      // signupCountryCode,
      // signupMobileNumber,
      // signupPassword,
      // signupConfirmPassword,
      // signinEmail,
      // signinPassword,
      emailActivateCode,
      changePasswordOld,
      changePasswordNew,
      changePasswordConfirm,
      authMsg;
  bool authError = true;
  bool isSignin = false;
  bool isSignup = false;
  bool isPasswordChanged = false;
  bool isEmailVerified = true;
  bool isActivateCodeSubmitted = false;
  bool isResendEmailSubmitted = false;
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInpassword = TextEditingController();

//dskdklskddddddddddd
  TextEditingController signUpFirstName = TextEditingController();
  TextEditingController signUpLastName = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpUsername = TextEditingController();
  TextEditingController signUpCountryCode = TextEditingController();
  TextEditingController signUpMobileNumber = TextEditingController();
  TextEditingController signUpBirth = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpConfirmPassword = TextEditingController();

  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> activateEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  bool validateAndSave({
    @required FormState formstate,
  }) {
    final form = formstate;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future _saveToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('data', json.encode(token));
  }

  Future<void> validateAndSubmitSignup() async {
    authMsg = null;
    isSignup = false;
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: signupFormKey.currentState)) {
        var data = {
          'fname': signUpFirstName.text,
          'lname': signUpLastName.text,
          'email': signUpEmail.text,
          'username': signUpUsername.text,
          'countryCode': signUpCountryCode.text,
          'phone': signUpMobileNumber.text,
          'dob': signUpBirth.text,
          'password': signUpPassword.text,
          'password_confirmation': signUpConfirmPassword.text,
        };

        var res = await AuthApi(
          isSignupApi: true,
        ).postData(data);

        print("--------------------Hello here ia am -------------------------");
        var body = jsonDecode(res.body);
        // var body = json.decode(res.body);
        print(
            "------------------------Body is $body-----------------------------------------------");
        if (body["status"]) {
          isSignup = true;
        } else {
          authError = true;
          authMsg = body['errorMessage'];
        }
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
    setState(ViewState.kIdle);
  }

  Future<void> validateAndSubmitSignin() async {
    authMsg = null;
    isSignin = false;
    isEmailVerified = true;
    setState(ViewState.kBusy);

    try {
      if (validateAndSave(formstate: signinFormKey.currentState)) {
        var data = {
          'email': signInEmail.text,
          'password': signInpassword.text,
        };
        var res = await AuthApi(
          isSignupApi: false,
        ).postData(data);
        var body = json.decode(res.body);
        print(body);
        if (body['status']) {
          String deviceToken = await CloudMessaging().getToken();

          print(
              "==========================Device Token is $deviceToken========");
          print(deviceToken);
          await _saveToken(body['data']);

          await validateAndSubmitFCLToken(
              fclToken: deviceToken,
              onSuccess: () {
                isSignin = true;
                authError = false;
              });

          signInpassword.clear();
        } else {
          if (body['isEmailVerified'] == false) {
            isEmailVerified = false;
            print("======Email is not verified ======");
            var data = {'email': signInEmail.text};
            var res = await ActivateEmailApi().postResendEmailData(data);
            var body = json.decode(res.body);
            print("$body");

            // if (body['status']) {
            //   signInEmail.clear();
            //   signInpassword.clear();
            //   // isResendEmailSubmitted = true;
            // } else {
            //   authError = true;
            //   authMsg = body['errorMessage'];
            // }
          }
          authError = true;
          authMsg = body['errorMessage'];
        }
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
    setState(ViewState.kIdle);
  }

  Future<void> validateAndSubmitActivateEmail(
      {@required bool isSignupEmail, @required String email}) async {
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: activateEmailFormKey.currentState)) {
        var data = {
          'code': emailActivateCode,
          'email': isSignupEmail ? signUpEmail.text : signInEmail.text,
        };

        var res = await ActivateEmailApi().postActivateEmailData(data);
        var body = json.decode(res.body);

        if (body['status']) {
          // signUpEmail.clear();
          // signInEmail.clear();
          // signInpassword.clear();
          isActivateCodeSubmitted = true;
        } else {
          authMsg = body['errorMessage'];
          authError = true;
        }
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
    setState(ViewState.kIdle);
  }

  Future<void> validateAndSubmitResendEmail(
      {@required bool isSignupEmail}) async {
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: activateEmailFormKey.currentState)) {
        var data = {
          'email': isSignupEmail ? signUpEmail.text : signInEmail.text
        };

        var res = await ActivateEmailApi().postResendEmailData(data);
        var body = json.decode(res.body);
        print("$body");
        if (body['status']) {
          isResendEmailSubmitted = true;
        } else {
          authError = true;
          authMsg = body['errorMessage'];
        }
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
    setState(ViewState.kIdle);
  }

//====================================Change Password============================================
  Future<void> validateAndSubmitChangePassword() async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: changePasswordFormKey.currentState)) {
        print(changePasswordOld);
        print(changePasswordNew);
        print(changePasswordConfirm);
        var data = {
          'oldPassword': changePasswordOld,
          'password': changePasswordNew,
          'password_confirmation': changePasswordConfirm,
        };

        var res = await _http.post(
          Uri.parse(kChangePasswordApi),
          body: data,
          headers: _setHeaders(),
        );
        var body = json.decode(res.body);
        print("$body");
        if (body['status']) {
          isPasswordChanged = true;
        } else {
          authError = true;
          authMsg = body['errorMessage'];
        }
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
    setState(ViewState.kIdle);
  }

  //====================================Insert Update FCL Token============================================
  Future<void> validateAndSubmitFCLToken(
      {@required String fclToken, @required Function onSuccess}) async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };

    try {
      var data = {
        'fcm_token': fclToken,
      };

      var res = await _http.post(
        Uri.parse(kFCMTokenApi),
        body: data,
        headers: _setHeaders(),
      );
      var body = json.decode(res.body);
      print("$body");
      if (body['status']) {
        signInEmail.clear();
        signInpassword.clear();
        onSuccess();
        print("=================Token Saved Successfully=======");
      } else {
        authError = true;
        authMsg = body['errorMessage'];
      }
    } catch (e) {
      print("TRACE: FCL TOKEN API ERROR $e");
    }
  }
}
