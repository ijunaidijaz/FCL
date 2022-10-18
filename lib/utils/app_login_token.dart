import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<String> getLoginToken() async {
  String token = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if ( prefs.getString('data') != null) {
    token = jsonDecode(prefs.getString('data'));
  } else {
    token = "";
  }

  return token;
}
