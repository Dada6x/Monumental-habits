import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/Middleware/auth_middleware.dart';
import 'package:monumental_habits/Theme/themes.dart';
import 'package:monumental_habits/auth/pages/landing_page.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/introduction_splashscreen/introductionScreens.dart';
import 'package:monumental_habits/locale/locale.dart';
import 'package:monumental_habits/locale/locale_controller.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/f_a_q_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monumental_habits/notifications/notifications_service.dart';
import 'firebase_options.dart';

// status bar color in the app dammmnscc
// SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Color(orange)));
SharedPreferences? introSP;
SharedPreferences? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  introSP = await SharedPreferences.getInstance();
  token = await SharedPreferences.getInstance();
  Get.put(FAQController());
//! init Notifications
  NotificationsService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LocaleController());
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: "/",
          page: () => const Intropages(),
        ),
        GetPage(
          name: "/Auth",
          page: () => const Auth(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(name: "/Home", page: () => HomePage()),
      ],
      debugShowCheckedModeBanner: false,
      theme: Themes().lightMode,
      locale: Get.deviceLocale,
      translations: MyLocale(),
      initialRoute: introSP!.getString("intro") != null ? "Auth" : "/",
    );
  }
}
