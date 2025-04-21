import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/Theme/themes.dart';
import 'package:monumental_habits/Theme/themes_contoller.dart';
import 'package:monumental_habits/home/controllers/navigationcontroller.dart';
import 'package:monumental_habits/locale/locale_controller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/customappBar.dart';
import 'package:monumental_habits/widgets/settings_comps.dart';

class CustomizePage extends StatelessWidget {
  CustomizePage({super.key});
  final NavigationController navController = Get.put(NavigationController());
  final ThemesContoller _themesContoller = Get.put(ThemesContoller());
  final LocaleController _localeController = Get.put(LocaleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar([], "Customize".tr, context),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SettingsComps(
            title: "Change Theme".tr,
            destination: () {},
            icon: Icon(
              Get.isDarkMode ? Icons.nightlight_round : Icons.sunny,
            ),
            trailing: Switch(
              activeColor: altPurple,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(darkOrange),
              // activeTrackColor: const Color(lavander),
              // focusColor: Colors.red,
              trackOutlineColor:
                  const WidgetStatePropertyAll(Colors.transparent),
              thumbIcon: WidgetStatePropertyAll(Get.isDarkMode
                  ? const Icon(
                      Icons.nightlight,
                      color: Color(darkPurple),
                    )
                  : const Icon(
                      Icons.sunny,
                      color: Color(darkOrange),
                    )),
              value: _themesContoller.isDarkMode.value,
              onChanged: (value) {
                _themesContoller.isDarkMode.value = value;
                Get.changeTheme(_themesContoller.isDarkMode.value
                    ? Themes().darkMode
                    : Themes().lightMode);
                navController.darkTheme.value =
                    _themesContoller.isDarkMode.value;
              },
            ),
          ),
          SettingsComps(
            icon: const Icon(Icons.language),
            title: "Change Language".tr,
            destination: () {
              _localeController.isArabic = !_localeController.isArabic;

              _localeController.isArabic
                  ? _localeController.changeLang("en")
                  : _localeController.changeLang("ar");
            },
            trailing: Text(
              _localeController.isArabic ? "En" : "عربي",
              style: manropeFun(context),
            ),
          ),
        ],
      ),
    );
  }  
}

/*
Show Case
[Habit]
add new Habit button. 
    set name, set Days want the habit to be invoked , set Reminder , set notifications , click the add new habit 
when habit Added.
    select the day
    ongtap for the Habit Info,
    edit Habit
    Delete Habit 
[Profile ]
*/