import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/Theme/themes.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/introduction_splashscreen/introductionScreens.dart';

import 'package:monumental_habits/util/sizedconfig.dart';

void main() {
  // status bar color in the app dammmnscc
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Color(orange)));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//Ward checking shit 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes().lightMode,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context); // Initialize screen size
          return const Intropages();
        },
      ),
    );
  }
}
