import 'package:flutter/material.dart';
import 'package:monumental_habits/util/helper.dart';

AppBar customappBar(
    List<Widget> actionsList, String title, BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: manropeFun(context),
      textDirection: TextDirection.ltr,
    ),
    scrolledUnderElevation: 0.0,
    surfaceTintColor: Colors.transparent,
    forceMaterialTransparency: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: actionsList,
  );
}
