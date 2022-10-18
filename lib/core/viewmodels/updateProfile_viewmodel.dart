import 'dart:convert';
import 'dart:io';

import 'package:fcl/utils/app_api_ref.dart';
import 'package:fcl/utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class UpdateProfileApi {
  postData(data) async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    return await _http.post(
      Uri.parse(kUserUpdateProfileApi),
      body: data,
      headers: _setHeaders(),
    );
  }
}

class UpdateProfileViewmodel extends BaseViewmodel {
  String updateProfileFirstName,
      updateProfileLastName,
      updateProfileBirth,
      updateProfileUsername,
      updateProfileCountryCode,
      updateProfilePhoneNumber,
      updateProfileEmail,
      updateProfileUserName,
      imgUrl,
      authMsg;
  bool authError = true;
  File changeProfilePic;
  bool isProfileUpdated = false;
  bool isProfilePicUpdated = false;

  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();

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

  Future<void> validateAndSubmitUpdateProfile() async {
    print(updateProfileFirstName);
    print(updateProfileLastName);
    print(updateProfileCountryCode);
    print(updateProfilePhoneNumber);
    print(updateProfileBirth);
    setState(ViewState.kBusy);
    try {
      if (validateAndSave(formstate: updateProfileFormKey.currentState)) {
        var data = {
          'fname': updateProfileFirstName,
          'lname': updateProfileLastName,
          "countryCode": updateProfileCountryCode,
          'phone': updateProfilePhoneNumber,
          'dob': updateProfileBirth,
          'email': updateProfileEmail,
          'username': updateProfileUserName,
        };

        var res = await UpdateProfileApi().postData(data);
        var body = json.decode(res.body);
        print("$body");
        if (body['status']) {
          isProfileUpdated = true;
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

  //====================Update Profile Pic=======================================
  Future<void> validateAndSubmitUpdateProfilePic() async {
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };

    setState(ViewState.kBusy);

    try {
      if (changeProfilePic != null) {
        final file =
            await _http.MultipartFile.fromPath('image', changeProfilePic.path);
        final uploadImageRequest = _http.MultipartRequest(
            'POST',
            Uri.parse(
              kChangeProfilePictureApi,
            ));

        uploadImageRequest.files.add(file);
        uploadImageRequest.headers.addAll(_setHeaders());
        final streamedResponse = await uploadImageRequest.send();
        final response = await _http.Response.fromStream(streamedResponse);
        var body = json.decode(response.body);
        print("Body is -----------$body");

        if (response.statusCode != 200) {
          return null;
        } else {
          isProfilePicUpdated = true;
          final String responseString = response.body;

          print(responseString);
        }
      } else {
        authMsg = "You have not selected any image";
      }
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
      return null;
    }

    setState(ViewState.kIdle);
  }
}
