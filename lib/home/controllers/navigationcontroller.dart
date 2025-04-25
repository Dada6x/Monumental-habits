import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:monumental_habits/pages/habit/dashboard_homepage/dashboard_page.dart';
import 'package:monumental_habits/pages/habit/new/new_habit_page.dart';
import 'package:monumental_habits/util/widgets/soon.dart';
import 'package:monumental_habits/pages/settings_profile/settings.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  RxBool darkTheme = false.obs;
  // List of pages
  final List<Widget> pages = [
    const Dashboard(), //0
    SoonWidget(
      widgetName: "Road Maps",
      image1path: "assets/images/Screenshot_1745589378.png",
      image2path: "assets/images/Screenshot_1745589597.png",
    ), //1
    SoonWidget(
      widgetName: "Community",
      image1path: "assets/images/Screenshot_1745589378.png",
      image2path: "assets/images/Screenshot_1745589597.png",
    ), //2
    const Settings(), //3
    NewHabit(), //4
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
