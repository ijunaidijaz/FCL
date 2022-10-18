import 'dart:convert';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;

import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class ContactusViewmodel extends BaseViewmodel {
  String contactFullName, contactEmail, contactMsg, authMsg;
  bool authError = true;
  bool isFormSubmitted = false;

  final GlobalKey<FormState> contactusFormKey = GlobalKey<FormState>();

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

  Future<void> validateAndSubmitContactusForm() async {
    isFormSubmitted = false;
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: contactusFormKey.currentState)) {
        var data = {
          "fullname": contactFullName,
          "email": contactEmail,
          "message": contactMsg,
        };

        var res = await _http.post(
          Uri.parse(kContactusApi),
          body: data,
          headers: _setHeaders(),
        );

        var body = json.decode(res.body);

        if (body['status']) {
          isFormSubmitted = true;
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
