import 'package:flutter/material.dart';

import 'app_sizes.dart';

final double textLg = AppSizes.blockSizeHorizontal * 6;
final double textMd = AppSizes.blockSizeHorizontal * 5;
final double textSm = AppSizes.blockSizeHorizontal * 4;
final double textXS = AppSizes.blockSizeHorizontal * 3;

TextStyle textTitle({FontWeight fontWeight, Color color, double fontSize}) =>
    TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize ?? textLg,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w600);

TextStyle textSubTitle(
        {FontWeight fontWeight,
        Color color,
        double fontSize,
        TextDecoration decoration}) =>
    TextStyle(
        fontSize: fontSize ?? textMd,
        decoration: decoration ?? null,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w600);

TextStyle textBody(
        {FontWeight fontWeight,
        TextDecoration textDecoration,
        Color color,
        double fontSize}) =>
    TextStyle(
        decoration: textDecoration,
        fontSize: fontSize ?? textSm,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w400);
