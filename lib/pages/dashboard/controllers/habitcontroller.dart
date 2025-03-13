import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void delete() {
    texTFiledController.clear();
    habitName.value = '';
    chosenTime.value = "01:00 Am";
    notificationsEnabled.value = false;
    selectedDays.value = RxList<bool>(List.generate(7, (_) => false));
  }

  void edit() {
    //! take the habit name and put it here
    texTFiledController.clear();
    habitName.value = '';
    //! take the habit chosenTime and put it here
    chosenTime.value = "01:00 Am";
    //! take the habit notificationChoice and put it here
    notificationsEnabled.value = false;
    //! take the habit selectedDays and put it here
    selectedDays.value = RxList<bool>(List.generate(7, (_) => false));
  }
}
