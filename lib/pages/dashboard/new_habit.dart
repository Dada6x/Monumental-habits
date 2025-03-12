import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/dashboard/reminder.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/text_fields.dart';

class NewHabit extends StatelessWidget {
  final HabitController habitController = Get.put(HabitController());

  NewHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: habitController.texTFiledController,
              decoration: customTextFieldDecoration(
                  hint: "Enter Habit name ", prefixIcon: null, isWhite: true),
              onChanged: (value) => habitController.habitName.value = value,
            ),
          ),
          //! habit frequency
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: containerDecoration,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          "Habit Frequency",
                          style: manrope,
                        ),
                        Spacer(),
                        Text(
                          "Custom",
                          style: manropeOrange,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: HabitFrequencyRadioButtons(),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          //! reminder
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () async {
                //! Open Reminder bottom sheet and wait for the selected time
                final time = await Get.bottomSheet(
                  Reminder(),
                  isScrollControlled: true,
                );
                if (time != null) {
                  habitController.chosenTime.value = time;
                }
              },
              child: Container(
                height: 60,
                decoration: containerDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        "Reminder",
                        style: manrope,
                      ),
                      const Spacer(),
                      Obx(() => Text(
                            habitController.chosenTime.value.toString(),
                            style: manropeOrange,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          //! notifications toggle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 60,
              decoration: containerDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Notifications",
                      style: manrope,
                    ),
                    const Spacer(),
                    Obx(() => Switch(
                        activeColor: const Color(darkOrange),
                        inactiveThumbColor: const Color(darkPurple),
                        inactiveTrackColor: const Color(lavander),
                        value: habitController.notificationsEnabled.value,
                        onChanged: (notificationsValue) {
                          habitController.notificationsEnabled.value =
                              notificationsValue;
                        }))
                  ],
                ),
              ),
            ),
          ),
          //! Save button
        ],
      ),
    );
  }
}

class HabitFrequencyRadioButtons extends StatelessWidget {
  final HabitController habitFrequencyController = Get.find<HabitController>();
  static const List<String> weekDays = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          bool isSelected = habitFrequencyController.selectedDays[index];
          return GestureDetector(
            onTap: () => habitFrequencyController.selectedDays[index] =
                !habitFrequencyController.selectedDays[index],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  Text(
                    weekDays[index],
                    style: manropeLavander,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(lightOrange),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 31,
                                height: 31,
                                decoration: BoxDecoration(
                                  color: const Color(darkOrange),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
