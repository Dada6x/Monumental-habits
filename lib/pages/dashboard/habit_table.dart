import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/dashboard/habit_Info.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class HabitTable extends StatelessWidget {
  final HabitController habitController = Get.find<HabitController>();

  final List<Color> randomRowColors = const [
    Color(darkOrange),
    Color(0xFFF65B4E),
    Color(0xFF29319F),
    Color(0xFF973456),
  ];

  HabitTable({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<String> weekDays = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
    List<String> formattedWeekDays = List.generate(7, (index) {
      DateTime day = today
          .subtract(Duration(days: today.weekday % 7))
          .add(Duration(days: index));
      return "${DateFormat('E').format(day)} ${day.day}";
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(() {
          if (habitController.habits.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                    color: Colors.transparent,
                    width: 300,
                    height: 300,
                    child: const Text("Please add Habits  ⚠")),
              ),
            );
          }
          return Card(
            color: Get.isDarkMode ? Colors.transparent : Colors.white,
            child: DataTable(
              headingRowHeight: 60,
              dataRowMinHeight: 50,
              dataRowMaxHeight: 80,
              showBottomBorder: false,
              dividerThickness: double.infinity,
              showCheckboxColumn: false,
              border: const TableBorder(
                horizontalInside: BorderSide.none,
                verticalInside: BorderSide.none,
                borderRadius: BorderRadius.zero,
                bottom: BorderSide.none,
                left: BorderSide.none,
                right: BorderSide.none,
                top: BorderSide.none,
              ),
              columnSpacing: SizeConfig.screenWidth * 0.09,
              columns: [
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text(
                    "Habit",
                    style: klasikFun(context),
                  ),
                ),
                ...formattedWeekDays.map(
                  (day) {
                    List<String> parts = day.split(" ");
                    String dayOfWeek = parts[0];
                    String date = parts[1];
                    return DataColumn(
                      label: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayOfWeek,
                                style: manropeFun(context),
                              ),
                              Text(
                                date,
                                style: klasikFun(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              rows: habitController.habits.map(
                (habit) {
                  int rowIndex = habitController.habits.indexOf(habit);
                  return DataRow(
                    onSelectChanged: (value) {
                      Get.to(
                        () => HabitInfoPage(habit: habit),
                      );
                    },
                    cells: [
                      DataCell(
                        placeholder: false,
                        Center(
                          child: Text(
                            habit.name,
                            style: manropeFun(context),
                          ),
                        ),
                      ), // Habit name
                      ...List.generate(
                        7,
                        (index) {
                          String dayKey = weekDays[index];
                          bool isSelected = habit.selectedDays[dayKey] ?? false;
                          if (isSelected) {
                            return DataCell(
                                placeholder: false,
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Center(
                                    child: Container(
                                      width: 43,
                                      height: 43,
                                      decoration: BoxDecoration(
                                        color: randomRowColors[rowIndex % 4],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ));
                          } else {
                            return const DataCell(SizedBox());
                          }
                        },
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          );
        }),
      ),
    );
  }
}
