

import 'package:flutter/material.dart';


Widget baseScaffold({
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
    backgroundColor: backgroundColor??Colors.grey.withOpacity(0.1),
    appBar: appBar,
    bottomNavigationBar: bottomNavigationBar,
    floatingActionButton: floatingActionButton,
    floatingActionButtonLocation: floatingActionButtonLocation,
    body: body,
  );
}