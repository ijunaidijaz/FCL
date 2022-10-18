import 'package:flutter/material.dart';
import 'package:fcl/utils/app_sizes.dart';
import 'package:fcl/utils/app_colors.dart';

calendarWidget({@required BuildContext context}) {
  return showDatePicker(
    context: context,
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: kColorPrimary,
          accentColor: kColorAccent,
          colorScheme: ColorScheme.light(primary: kColorPrimary),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child,
      );
    },
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
}

Widget calendarFiled({@required String dateTxt}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: AppSizes.blockSizeHorizontal * 2.0,
        horizontal: AppSizes.blockSizeHorizontal * 2.0),
    child: Container(
      height: AppSizes.blockSizeVertical * 7.5,
      decoration: BoxDecoration(
          color: kColorContainer,
          borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.blockSizeHorizontal * 7.0))),
      width: AppSizes.screenWidth,
      child: Center(
          child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppSizes.blockSizeHorizontal * 11.0),
            child: Text(dateTxt),
          ),
        ],
      )),
    ),
  );
}
