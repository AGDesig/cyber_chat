import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/res/components/app_texts.dart';
import 'package:social_app/utils/screen_size.dart';

Widget appButton(
    {Function()? onTap,
    String text = "",
    Color? color,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    bool haveSize = false,
    bool havePrefix = true,
      Widget icon = const SizedBox(),
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? height,
    double? width,
     AlignmentGeometry alignment = Alignment. center,
      BorderRadiusGeometry? borderRadius,
      BoxShape shape = BoxShape. rectangle,
      BoxBorder? border,
      Gradient? gradient,
      List<BoxShadow>? boxShadow
    }) {
  return GestureDetector(
    onTap: onTap,
    child: haveSize ==true
        ? Container(
            height:  percentageHeight(value: height!),
            width:  percentageWidth(value: width!),
            decoration: BoxDecoration(
                color: color ?? Colors.blue,
                shape: shape,
                border: border,
                gradient: gradient,
                boxShadow: boxShadow,
                borderRadius: borderRadius),
            child: Align(
              alignment: alignment,
              child: Row( mainAxisSize: MainAxisSize.min,
                children: [
                  if(havePrefix)icon,
                  appText(
                    text,
                    fontSize: fontSize??12,
                    textColor: textColor??Colors.white,
                    fontWeight: fontWeight??FontWeight.w500
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
                color: color ?? Colors.blue,
                shape: shape,
                border: border,
                gradient: gradient,
                boxShadow: boxShadow,
                borderRadius: borderRadius??BorderRadius.all(Radius.circular(100))),
            child: Align(
              alignment: alignment,
              child: Row( mainAxisSize: MainAxisSize.min,
                children: [
                  if(havePrefix)icon,
                  appText(
                      text,
                      fontSize: fontSize??12,
                      fontWeight: fontWeight??FontWeight.w500,

                      textColor: textColor??Colors.white
                  ),
                ],
              ),
            ),
          ),
  );
}
