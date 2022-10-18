import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future showToast({
  @required String msg,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}
