import 'package:fcl/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_text_styles.dart';

Widget textWithLinkWidget(
    {bool isprimarycolorlink = true,
    @required String text,
    @required String linkText,
    @required GestureTapCallback onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "$text  ",
        style: textBody(
            color: Colors.white, fontSize: AppSizes.blockSizeVertical * 1.8),
      ),
      InkWell(
        onTap: onTap,
        child: Text(
          linkText,
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 15.0,
            color: kColorAccent,
          ),
        ),
      )
    ],
  );
}
