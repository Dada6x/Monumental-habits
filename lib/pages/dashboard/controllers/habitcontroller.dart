import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/notifications/notifications_service.dart';
import 'package:monumental_habits/pages/dashboard/model/habit_model.dart';

class HabitController extends GetxController {
  RxList<Habit> habits = <Habit>[].obs;
  final TextEditingController textFieldController = TextEditingController();
  var habitName = ''.obs;
  var chosenTime = "10:00 AM".obs;
  var notificationsEnabled = false.obs;
  RxList<String> selectedDays = <String>[].obs;

  Map<String, String> fullDayNames = {
    'sun': 'Sunday',
    'mon': 'Monday',
    'tue': 'Tuesday',
    'wed': 'Wednesday',
    'thu': 'Thursday',
    'fri': 'Friday',
    'sat': 'Saturday',
  };

  // the selected days should be an array of unselected days then the user select them
//! adding habitsun
  void addHabit() async {
    //! adding the habit to the GetX controller
    if (habitName.value.isNotEmpty) {
      habits.add(Habit(
        name: habitName.value,
        chosenTime: chosenTime.value,
        notificationsEnabled: notificationsEnabled.value,
        selectedDays: List<String>.from(selectedDays),
      ));
      NotificationsService().habitScheduleNotification(
          HabitName: habitName.value, timeString: chosenTime.value);
    }
    try {
      print({List<String>.from(selectedDays)});
      print("new HABIT ADD 🔴 ");
      print(
        selectedDays.map((d) => fullDayNames[d]!).toList(),
      );
      var response = await Dio().post(
        "http://10.0.2.2:8000/api/habits",
        data: {
          'name': habitName.value,
          "days": selectedDays.map((d) => fullDayNames[d]!).toList(),
          "reminder_time": null,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token!.getString("token")}',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data["status"]) {
        print("Habit added successfully");
      } else {
        print("Something went wrong: ${response.data}");
      }
    } catch (e) {
      print("Unexpected error: $e");
    }
    reset();
  }

//! deleting habits
  void deleteHabit(Habit habit) {
    habits.remove(habit);
  }

//! resetting the fields
  void reset() {
    textFieldController.clear();
    habitName.value = '';
    chosenTime.value = "01:00 AM";
    notificationsEnabled.value = false;
    selectedDays.clear();
  }

//! edit Habits
  void editHabit({
    required String name,
    required String time,
    required bool notifications,
    required List<String> days,
  }) {
    habits.assign(Habit(
      name: habitName.value,
      chosenTime: chosenTime.value,
      notificationsEnabled: notificationsEnabled.value,
      selectedDays: List<String>.from(selectedDays),
    ));
    reset();
  }
}
