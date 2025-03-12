import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:monumental_habits/pages/community/community.dart';
import 'package:monumental_habits/pages/dashboard/dashboard.dart';
import 'package:monumental_habits/pages/dashboard/new_habit.dart';
import 'package:monumental_habits/pages/maps/maps.dart';
import 'package:monumental_habits/pages/settings_profile/settings.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs; 

  // List of pages
  final List<Widget> pages = [
    const Dashboard(), //0
    const Maps(), //1
    const Community(), //2
    const Settings(), //3
    NewHabit(), //4
  ];

  void changePage(int index) {
    currentIndex.value = index;
    
  }
}
