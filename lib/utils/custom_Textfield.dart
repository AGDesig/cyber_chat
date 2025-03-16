

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/utils/app_colors.dart';

Widget customTextField(
{required TextEditingController controller,
  bool? obscureText,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  Color? cursorColor,
  String? hintText,
  bool? filled,
  Color? fillColor,
  Widget? prefixIcon,
  Widget? suffixIcon,

}
    ){
  return   TextFormField(
    controller: controller,
    obscureText: true,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    cursorColor: cursorColor,

    decoration: InputDecoration(
      hintText: hintText??"",
      filled: filled,
      fillColor: fillColor??AppColors.gray1,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none, // No border color
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none, // No border color when focused
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: prefixIcon, // Prefix icon
      suffixIcon: suffixIcon, // Suffix icon (can be used for toggling password visibility)
    ),
  );
}