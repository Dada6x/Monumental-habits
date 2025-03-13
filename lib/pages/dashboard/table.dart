import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/util/helper.dart';

class HabitTable extends StatelessWidget {
  const HabitTable({super.key});

  @override
  Widget build(BuildContext context) {
    final HabitController habitController = Get.put(HabitController());

    return const Center(
      child: Text(
        "table coming soon :D ",
        style: klasik,
      ),
    );
  }
}
