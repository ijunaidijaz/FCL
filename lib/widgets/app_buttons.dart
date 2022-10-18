import 'package:fcl/utils/app_colors.dart';
import 'package:fcl/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:fcl/utils/app_sizes.dart';

Widget raisedBtnLg(
    {Color textColor,
    Color bgColor,
    bool isContainerPadding = true,
    double borderRadius = 10.0,
    double btnHeight = 7.0,
    bool isScreenWidthBtn = true,
    double btnWidth,
    @required GestureTapCallback onPressed,
    IconData iconData,
    @required String text,
    BuildContext context}) {
  return Padding(
    padding: isContainerPadding
        ? EdgeInsets.symmetric(vertical: AppSizes.blockSizeHorizontal * 5)
        : EdgeInsets.symmetric(vertical: AppSizes.blockSizeHorizontal * 0),
    child: Container(
      height: AppSizes.blockSizeVertical * btnHeight,
      width: isScreenWidthBtn ? AppSizes.screenWidth : btnWidth,
      child: RaisedButton(
        // elevation: AppSizes.blockSizeVertical * 0.0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppSizes.blockSizeVertical * borderRadius),
        ),
        color: bgColor ?? kColorAccent,
        textColor: textColor ?? Colors.black,
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            if (iconData != null) Icon(iconData) else emptyWidget,
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Center(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
