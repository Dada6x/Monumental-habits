import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:monumental_habits/pages/community.dart';
import 'package:monumental_habits/pages/dashboard.dart';
import 'package:monumental_habits/pages/maps.dart';
import 'package:monumental_habits/pages/settings.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs; // Observable index for selected tab

  // List of pages
  final List<Widget> pages = const [
    Dashboard(),
    Maps(),
    Community(),
    Settings(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
