import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/auth/Middleware/auth_middleware.dart';
import 'package:monumental_habits/services/Theme/themes.dart';
import 'package:monumental_habits/auth/pages/landing_page.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/pages/introduction_splashscreen/introductionScreens.dart';
import 'package:monumental_habits/services/locale/locale.dart';
import 'package:monumental_habits/services/locale/locale_controller.dart';
import 'package:monumental_habits/pages/settings_profile/FAQ/f_a_q_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monumental_habits/services/notifications/notifications_service.dart';
import 'services/firebase/firebase_options.dart';

// status bar color in the app dammmnscc
// SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Color(orange)));
SharedPreferences? introSP;
SharedPreferences? token;
Dio dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setpreferredOrientations([Device])
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
          page: () => const IntroPages(),
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
      darkTheme: Themes().darkMode,
      locale: Get.deviceLocale,
      translations: MyLocale(),
      initialRoute: introSP!.getString("intro") != null ? "Auth" : "/",
    );
  }
}
//widgets with keyboard 

// edit Habit 
// contact us 