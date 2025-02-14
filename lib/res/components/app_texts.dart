


import 'package:flutter/material.dart';

Text appText(
    String text,
    {
  TextStyle? style,
  TextAlign? textAlign,
  TextDirection? textDirection,
  TextOverflow? overflow,
  int? maxLines,
  Color? textColor,
  Color? underlineColor,
  TextDecoration? decoration,
  FontWeight? fontWeight,
  double? fontSize,
  String? fontFamily,
}){
  return Text(text,
  style: TextStyle(color: textColor,fontWeight: fontWeight??FontWeight.w500,fontSize: fontSize,decoration: decoration,decorationColor: underlineColor),
  );
}