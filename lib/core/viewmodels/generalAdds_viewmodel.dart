import 'dart:convert';

import 'package:fcl/core/datamodels/generalAdds_datamodel.dart';
import 'package:fcl/core/viewmodels/device_info.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

class GeneralAddsViewModel extends BaseViewmodel {
  bool authError;
  String authMsg;
  var generalAddsData;
  Future<GeneralAddsDatamodel> getGeneralAddsData() async {
    String loginToken = await getLoginToken() ?? "";
    print("Token is $loginToken");
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };
    final _http.Client client = _http.Client();

    if (generalAddsData == null) {
      try {
        final response = await client.get(
          Uri.parse(kGeneralAddsApi),
          headers: _setHeaders(),
        );
        final _generalAddsData = generalAddsDatamodelFromJson(response.body);

        return _generalAddsData;
      } catch (e) {
        print("Track::GeneralAddsAPI error $e");
      }
    }
    return generalAddsData;
  }

  Future<void> validateAndSubmitGeneralAddsStat(
      {@required isGeneralAdd,
      @required bool wasClicked,
      @required int generalAddId}) async {
    await getDeviceInfo();
    // print("==========Device Brand is $deviceBrand================");
    // print("==========Device Model is $deviceModel================");
    // print("==========App Version is $appVersion================");
    // print("==========App Build is $appBuildNumber================");
    print("========Now add is $generalAddId==========");
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
          "Content-Type": "application/json",
        };

    try {
      var data = isGeneralAdd
          ? {
              "type": 'General',
              "deviceType": deviceBrand,
              "deviceModel": deviceModel,
              "appVersion": appVersion,
              "appBuild": appBuildNumber,
              "wasClicked": wasClicked,
              "general_ad_id": generalAddId
            }
          : {
              "type": 'Competition',
              "deviceType": deviceBrand,
              "deviceModel": deviceModel,
              "appVersion": appVersion,
              "appBuild": appBuildNumber,
              "wasClicked": wasClicked,
              "competition_native_ad_id": generalAddId
            };

      var res = await _http.post(
        Uri.parse(kGeneralAddsStatApi),
        body: json.encode(data),
        headers: _setHeaders(),
      );

      print(res);
      var body = json.decode(res.body);

      if (body['status']) {
        isGeneralAdd
            ? print("Successfully Submitted statistics for General Add ")
            : print("Successfully Submitted statistics for Native Add ");
      } else {
        isGeneralAdd
            ? print("Not Successfully Submitted statistics for General Add ")
            : print("Not Successfully Submitted statistics for Native Add ");
        print(body['errorMessage']);
      }
      authError = false;
    } catch (e) {
      print("Trace:: Add stats Api error $e");
      // authMsg = e.message.toString();
      authError = true;
    }
  }
}
