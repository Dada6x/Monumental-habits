import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:monumental_habits/introductionScreens.dart';

import 'package:monumental_habits/util/sizedconfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context); // Initialize screen size
          return const Intropages();
        },
      ),
    );
  }
}
