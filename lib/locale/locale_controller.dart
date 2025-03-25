import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  bool isArabic = true;
  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}
