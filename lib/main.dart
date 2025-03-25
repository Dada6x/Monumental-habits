import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/Theme/themes.dart';
import 'package:monumental_habits/auth/pages/Auth.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/introduction_splashscreen/introductionScreens.dart';
import 'package:monumental_habits/locale/locale.dart';
import 'package:monumental_habits/locale/locale_controller.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/f_a_q_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? introSP;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  introSP = await SharedPreferences.getInstance();
  Get.put(FAQController());
  // status bar color in the app dammmnscc
  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Color(orange)));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//Ward checking shit
//LocaleController localeController = Get.find();
  @override
  Widget build(BuildContext context) {
    Get.put(LocaleController());
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/", page: () => const Intropages()),
        GetPage(name: "/Auth", page: () => const Auth()),
        GetPage(name: "/Home", page: () => HomePage()),
      ],
      debugShowCheckedModeBanner: false,
      theme: Themes().lightMode,
      locale: Get.deviceLocale,
      translations: MyLocale(),
      initialRoute: "/",
    );
    
  }
}
