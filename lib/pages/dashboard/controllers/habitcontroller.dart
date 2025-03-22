import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/dashboard/model/habit_model.dart';

class HabitController extends GetxController {
  RxList<Habit> habits = <Habit>[].obs;
  final TextEditingController textFieldController = TextEditingController();

  var habitName = ''.obs;
  var chosenTime = "10:00 AM".obs;
  var notificationsEnabled = false.obs;

  RxMap<String, bool> selectedDays = RxMap({
    'sun': false,
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
    'sat': false,
  });

  void addHabit() {
    if (habitName.value.isNotEmpty) {
      habits.add(Habit(
        name: habitName.value,
        chosenTime: chosenTime.value,
        notificationsEnabled: notificationsEnabled.value,
        selectedDays: Map<String, bool>.from(selectedDays),
      ));
      reset();
    }
  }

  // void edit({
  //   required String name,
  //   required String time,
  //   required bool notifications,
  //   required Map<String, bool> days,
  // }) {
  //   textFieldController.text = name;
  //   habitName.value = name;
  //   chosenTime.value = time;
  //   notificationsEnabled.value = notifications;
  //   selectedDays.value = Map<String, bool>.from(days);
  // }

  void deleteHabit(Habit habit) {
    habits.remove(habit); // Removes the habit from the list
  }

  void reset() {
    textFieldController.clear();
    habitName.value = '';
    chosenTime.value = "01:00 AM";
    notificationsEnabled.value = false;
    selectedDays.value = {
      'sun': false,
      'mon': false,
      'tue': false,
      'wed': false,
      'thu': false,
      'fri': false,
      'sat': false,
    };
  }

  void saveUpdatedHabit(habit) {}
}
