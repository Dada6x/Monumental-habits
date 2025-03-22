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

//! adding habits
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

//! deleting habits
  void deleteHabit(Habit habit) {
    habits.remove(habit); // Removes the habit from the list
  }

//! resetting the fields
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

//! edit
  void habitUpDate({
    required String name,
    required String time,
    required bool notifications,
    required Map<String, bool> days,
  }) {
    habits.assign(Habit(
      name: habitName.value,
      chosenTime: chosenTime.value,
      notificationsEnabled: notificationsEnabled.value,
      selectedDays: Map<String, bool>.from(selectedDays),
    ));
    reset();
  }
}
