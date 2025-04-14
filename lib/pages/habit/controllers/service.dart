import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';

class HabitService {
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
        'Error: Unable to delete habit. Please check your connection. ❌',
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
}
