import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/notifications/notifications_service.dart';
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
      NotificationsService().habitScheduleNotification(
          HabitName: habitName.value, timeString: chosenTime.value);
      reset();
    }
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

//! edit Habits
  void editHabit({
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


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:monumental_habits/notifications/notifications_service.dart';
import 'package:monumental_habits/pages/dashboard/model/habit_model.dart';

class HabitController extends GetxController {
  RxList<Habit> habits = <Habit>[].obs;
  final TextEditingController textFieldController = TextEditingController();
  var habitName = ''.obs;
  var chosenTime = "10:00 AM".obs;
  RxMap<String, bool> selectedDays = RxMap({
    'sun': false,
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
    'sat': false,
  });

  //! Add habit with a unique ID
  void addHabit() {
    if (habitName.value.isNotEmpty) {
      String habitId = Habit.generateUniqueId(); // Generate UUID

      Habit newHabit = Habit(
        id: habitId,
        name: habitName.value,
        chosenTime: chosenTime.value,
        selectedDays: Map<String, bool>.from(selectedDays),
      );

      habits.add(newHabit);

      // Schedule notification
      scheduleHabitNotification(newHabit);

      reset();
    }
  }

  //! Schedule notifications for a habit
  void scheduleHabitNotification(Habit habit) {
    DateTime dateTime = DateFormat("hh:mm a").parse(habit.chosenTime);
    int hour = int.parse(DateFormat("HH").format(dateTime));
    int minute = int.parse(DateFormat("mm").format(dateTime));

    NotificationsService().scheduledNotifications(
      id: habit.id.hashCode, // Convert UUID to an integer
      hour: hour,
      minute: minute,
      title: "Reminder for ${habit.name} ⏰",
      body: "It's time for your habit: ${habit.name}!",
    );
  }

  //! Delete habit and cancel its notification
  void deleteHabit(Habit habit) {
    habits.remove(habit);
    NotificationsService().cancelNotification(habit.id.hashCode);
  }

  //! Update habit and reschedule notification
  void habitUpdate({
    required String id,
    required String name,
    required String time,
    required Map<String, bool> days,
  }) {
    Habit updatedHabit = Habit(
      id: id,
      name: name,
      chosenTime: time,
      selectedDays: days,
    );

    int index = habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      habits[index] = updatedHabit;
    }

    NotificationsService().cancelNotification(id.hashCode);
    scheduleHabitNotification(updatedHabit);

    reset();
  }

  //! Reset fields
  void reset() {
    textFieldController.clear();
    habitName.value = '';
    chosenTime.value = "01:00 AM";
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
}


*/