import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:monumental_habits/home/pages/community.dart';
import 'package:monumental_habits/home/pages/dashboard.dart';
import 'package:monumental_habits/home/pages/maps.dart';
import 'package:monumental_habits/home/pages/settings.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs; // Observable index for selected tab

  // List of pages
  final List<Widget> pages = [
    Dashboard(),
    Maps(),
    Community(),
    Settings(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
