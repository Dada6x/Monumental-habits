import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/services/notifications/notifications_service.dart';
import 'package:monumental_habits/pages/habit/dashboard_homepage/habitTable.dart';
import 'package:monumental_habits/pages/habit/model/habit_model.dart';
import 'package:monumental_habits/util/helper.dart';

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
//! adding habit
  void addHabit() async {
    habits.add(Habit(
      name: habitName.value,
      chosenTime: chosenTime.value,
      notificationsEnabled: notificationsEnabled.value,
      selectedDays: [''],
    ));
    //! adding the habit to the GetX controller
    if (habitName.value.isNotEmpty) {
      NotificationsService().habitScheduleNotification(
        HabitName: habitName.value,
        timeString: chosenTime.value,
      );

//! backend
      try {
        var response = await Dio().post(
          "http://10.0.2.2:8000/api/habits",
          data: {
            'name': habitName.value,
            "days": selectedDays.map((d) => fullDayNames[d]!).toList(),
            "reminder_time": "10:15 AM",
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token!.getString("token")}',
              'Accept': 'application/json',
            },
          ),
        );

        if (response.data["status"]) {
          Get.showSnackbar(
            const GetSnackBar(
              icon: Icon(Icons.celebration),
              title: "Success",
              message: "Habit added successfully 🎉",
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          // print("Something went wrong: ${response.data}");
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(Icons.error),
              title: "Error",
              message: response.data["message"] ?? "Something went wrong",
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        Get.showSnackbar(
          const GetSnackBar(
            icon: Icon(Icons.error),
            title: "Exception",
            message: 'Something Went Wrong please Try Again Later',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Validation Error",
          message: "Please enter a habit name",
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }
    //! REFRESH THE TABLE
    habitTableKey.currentState?.refreshTable();
    reset();
  }

//! Delete Habit Request
  void deleteHabit(int id) async {
    try {
      String apiUrl = 'http://10.0.2.2:8000/api/habits/$id';
      var response = await dio.delete(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token!.getString("token")}',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Habit deleted successfully! ',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: const Color(darkOrange),
            icon: const Icon(Icons.delete));
        Get.off(() => HomePage());
        habitTableKey.currentState?.refreshTable();
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete habit. Try again later. ❌',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something Went Wrong please Try Again Later',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

//! resetting the fields
  void reset() {
    textFieldController.clear();
    habitName.value = '';
    chosenTime.value = "10:00 AM";
    notificationsEnabled.value = false;
    selectedDays.clear();
  }

//! edit Habits
  // void editHabit({
  //   required String name,
  //   required String time,
  //   required bool notifications,
  //   required List<String> days,
  // }) {
  //   habits.assign(Habit(
  //     name: habitName.value,
  //     chosenTime: chosenTime.value,
  //     notificationsEnabled: notificationsEnabled.value,
  //     selectedDays: List<String>.from(selectedDays),
  //   ));
  //   reset();
  // }
}
