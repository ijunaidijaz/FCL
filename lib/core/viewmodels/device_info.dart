import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:fcl/utils/app_api_ref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:package_info/package_info.dart';
import 'base_viewmodel.dart';
import 'package:fcl/utils/app_login_token.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
String deviceBrand;
String deviceModel;
String appVersion;
String appBuildNumber;

getDeviceInfo() async {
  if (Platform.isAndroid) {
    // print('Running on ${androidInfo.id}');
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceBrand = androidInfo.brand;
    deviceModel = androidInfo.model;
    appVersion = androidInfo.version.sdkInt.toString();
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceBrand = iosInfo.model;
    deviceModel = iosInfo.name;
    appVersion = iosInfo.systemVersion;
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  // e.g. "Moto G (4)"

  appVersion = packageInfo.version;
  appBuildNumber = packageInfo.buildNumber;
}

class DeviceInfoViewmodel extends BaseViewmodel {
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

  Future<void> validateAndSubmitDeviceInfo(
      {@required String screenName}) async {
    await getDeviceInfo();
    print("==========Device Brand is $deviceBrand================");
    print("==========Device Model is $deviceModel================");
    print("==========App Version is $appVersion================");
    print("==========App Build is $appBuildNumber================");
    print("==========Screen is is $screenName================");
    String loginToken = await getLoginToken() ?? "";
    _setHeaders() => {
          'Authorization': 'Bearer $loginToken',
          'Accept': 'application/json',
        };

    try {
      var data = {
        "name": screenName,
        "deviceType": deviceBrand,
        "deviceModel": deviceModel,
        "appVersion": appVersion,
        "appBuild": appBuildNumber,
      };

      var res = await _http.post(
        Uri.parse(kAppStatsApi),
        body: data,
        headers: _setHeaders(),
      );

      var body = json.decode(res.body);

      if (body['status']) {
        print("Successfully Submitted statistics for $screenName");
      } else {
        print("Not Successfully Submitted statistics for $screenName");
        print(body['errorMessage']);
      }
      authError = false;
    } catch (e) {
      authMsg = e.message.toString();
      authError = true;
    }
  }
}
