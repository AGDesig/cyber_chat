

import 'package:flutter/material.dart';
import 'package:social_app/utils/app_colors.dart';


Scaffold baseScaffold({
  FloatingActionButtonLocation? floatingActionButtonLocation,
  Widget? floatingActionButton,
  Widget? bottomNavigationBar,
  PreferredSizeWidget? appBar,
  Color? backgroundColor,
  Widget? body,
  Widget? bottomSheet
}) {
  return Scaffold(
    bottomSheet: bottomSheet,
    backgroundColor: backgroundColor??AppColors.white.withValues(alpha: 0.95),
    appBar: appBar,
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
    body: body,
  );
}