import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/dashboard/reminder_page.dart';
import 'package:monumental_habits/util/helper.dart';

class NewHabit extends StatelessWidget {
  final HabitController habitController = Get.put(HabitController());

  NewHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: habitController.textFieldController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.tertiary,
              filled: true,
              prefixIconColor: Get.isDarkMode
                  ? const Color(orange)
                  : const Color(darkPurple),
              labelText: "Enter new Habit ",
              labelStyle: klasikHint,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Get.isDarkMode ? altPurple : const Color(orange)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onChanged: (value) => habitController.habitName.value = value,
          ),
          //! habit frequency
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: customContainer(context),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          "Habit Frequency",
                          style: manropeFun(context),
                        ),
                        const Spacer(),
                        Text(
                          "Custom",
                          style: manropeOrangeAndPurple(context),
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
                decoration: customContainer(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Reminder",
                        style: manropeFun(context),
                      ),
                      const Spacer(),
                      Obx(() => Text(
                            habitController.chosenTime.value.toString(),
                            style: manropeOrangeAndPurple(context),
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
              decoration: customContainer(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Notifications",
                      style: manropeFun(context),
                    ),
                    const Spacer(),
                    Obx(() => Switch(
                        activeColor: const Color(darkOrange),
                        inactiveThumbColor: const Color(darkPurple),
                        inactiveTrackColor: const Color(lavander),
                        trackOutlineColor:
                            const WidgetStatePropertyAll(Colors.transparent),
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

  HabitFrequencyRadioButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          String day = weekDays[index].toLowerCase();
          bool isSelected = habitFrequencyController.selectedDays[day] ??
              false; // Use the map to get the status for the day

          return GestureDetector(
            onTap: () {
              // Toggle the selection for the selected day
              habitFrequencyController.selectedDays[day] =
                  !(habitFrequencyController.selectedDays[day] ?? false);
            },
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
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 31,
                                height: 31,
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? const Color(darkPurple)
                                      : const Color(darkOrange),
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
