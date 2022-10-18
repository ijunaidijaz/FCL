import 'dart:convert';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;

import 'base_viewmodel.dart';

class ResetPasswordApi {
  postResetEmail(data) async {
    return await _http.post(
      Uri.parse(kRequestResetPasswordApi),
      body: data,
      headers: _setHeaders(),
    );
  }

  postResetCode(data) async {
    return await _http.post(
      Uri.parse(kRequestResetValidationApi),
      body: data,
      headers: _setHeaders(),
    );
  }

  postNewPassword(data) async {
    return await _http.post(
      Uri.parse(kResetPasswordApi),
      body: data,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Accept': 'application/json',
      };
}

class ResetPasswordViewmodel extends BaseViewmodel {
  String resetEmail, authMsg, resetCode, newPassword;
  bool authError = true;
  bool isEmailSubmitted = false;
  bool isCodeSubmitted = false;
  bool isNewPasswordSubmitted = false;

  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetCodeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

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

  Future<void> validateAndSubmitResetEmailForm() async {
    isEmailSubmitted = false;
    print(
        "========================i am here=====================================");
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: resetPasswordFormKey.currentState)) {
        var data = {
          "email": resetEmail,
        };

        var res = await ResetPasswordApi().postResetEmail(data);
        var body = json.decode(res.body);

        print("=====Result is ${res.body} ===========");

        if (body['status']) {
          isEmailSubmitted = true;
        } else {
          authError = true;
          authMsg = body['errorMessage'];
          print("================${body['errorMessage']}");
        }
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
    setState(ViewState.kIdle);
  }

  Future<void> validateAndSubmitResetCodeForm() async {
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: resetCodeFormKey.currentState)) {
        var data = {
          "email": resetEmail,
          "code": resetCode,
        };

        var res = await ResetPasswordApi().postResetCode(data);
        var body = json.decode(res.body);

        print(body);

        if (body['status']) {
          isCodeSubmitted = true;
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

  Future<void> validateAndSubmitNewPasswordForm() async {
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: newPasswordFormKey.currentState)) {
        var data = {
          "email": resetEmail,
          "code": resetCode,
          "newPassword": newPassword,
        };

        var res = await ResetPasswordApi().postNewPassword(data);
        var body = json.decode(res.body);

        print(body);

        if (body['status']) {
          isNewPasswordSubmitted = true;
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
}
