import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HabitController extends GetxController {
  var habitName = 'Null'.obs;
  var chosenTime = "01:00 Am".obs;
  var notificationsEnabled = false.obs;
  RxList<bool> selectedDays = RxList<bool>(List.generate(7, (_) => false));
  final TextEditingController texTFiledController = TextEditingController();

  void saveHabit() {
    // Now, store this data in a habit model or send it to your database
    print("Habit Name: ${habitName.value}");
    print("Reminder Time: ${chosenTime.value}");
    print("Notifications: ${notificationsEnabled.value}");
    print("Selected Days: $selectedDays");

//! send the Habit to the shitty ahh dashBoard
    // You can add code here to save this data to your database or API
  }

  void reset() {
    texTFiledController.clear();
    habitName.value = '';
    chosenTime.value = "01:00 Am";
    notificationsEnabled.value = false;
    selectedDays.value = RxList<bool>(List.generate(7, (_) => false));
  }
}
