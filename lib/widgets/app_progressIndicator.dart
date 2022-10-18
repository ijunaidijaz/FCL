import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget progressIndicator() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: AppSizes.blockSizeVertical * 2.0),
    child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(kColorAccent),
    ),
  );
}
