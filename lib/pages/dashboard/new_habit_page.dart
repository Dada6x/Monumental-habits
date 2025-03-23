import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class NewHabit extends StatelessWidget {
  final HabitController habitController = Get.put(HabitController());

  NewHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //! Habit Name
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
          //!  Habit reminder
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () async {
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
        ],
      ),
    );
  }
}

//! habit frequency Widget
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
//!  Habit reminder Widget

class Reminder extends StatelessWidget {
  // Reactive state variables
  final RxInt selectedHour = 1.obs;
  final RxInt selectedMinute = 0.obs;
  final RxString selectedPeriod = 'AM'.obs;

  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();

  Reminder({super.key});

  void _saveReminder() {
    String formattedTime =
        "${selectedHour.value.toString().padLeft(2, '0')}:${selectedMinute.value.toString().padLeft(2, '0')} ${selectedPeriod.value}";
    Get.back(result: formattedTime);
    //! SEND IT TO THE NOTIFICATIONS
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiary,
      height: SizeConfig.screenHeight * 0.5,
      width: SizeConfig.screenHeight,
      child: Column(
        children: [
          _buildHeader(context),
          _buildTimeWheel(),
          _buildAMPMSelector(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
            style: manropeOrangeAndPurple(context),
          ),
        ),
        const Spacer(),
        Text(
          "Add Reminder",
          style: manropeFun(context),
        ),
        const Spacer(),
        TextButton(
          onPressed: _saveReminder,
          child: Text(
            "Save",
            style: manropeOrangeAndPurple(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeWheel() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWheelSelector(
              controller: _hourController,
              onSelectedItemChanged: (index) => selectedHour.value = index + 1,
              itemCount: 12,
              builder: (index) => _TimeUnitText(value: index + 1),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(":", style: clockStyle),
            ),
            _buildWheelSelector(
              controller: _minuteController,
              onSelectedItemChanged: (index) => selectedMinute.value = index,
              itemCount: 60,
              builder: (index) => _TimeUnitText(value: index, isMinute: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWheelSelector({
    required FixedExtentScrollController controller,
    required Function(int) onSelectedItemChanged,
    required int itemCount,
    required Widget Function(int) builder,
  }) {
    return SizedBox(
      width: 70,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) => builder(index),
          childCount: itemCount,
        ),
      ),
    );
  }

  Widget _buildAMPMSelector() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['AM', 'PM'].map((period) {
          bool isSelected = selectedPeriod.value == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => selectedPeriod.value = period,
              child: Container(
                color: isSelected
                    ? Get.isDarkMode
                        ? const Color(darkPurple)
                        : const Color(orange)
                    : Get.isDarkMode
                        ? const Color(lavander)
                        : const Color(background),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    period,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Klasik",
                      color: isSelected
                          ? Get.isDarkMode
                              ? Colors.white
                              : const Color(darkPurple)
                          : Get.isDarkMode
                              ? Colors.white
                              : const Color(darkOrange),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TimeUnitText extends StatelessWidget {
  final int value;
  final bool isMinute;
  const _TimeUnitText({required this.value, this.isMinute = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        isMinute ? value.toString().padLeft(2, '0') : value.toString(),
        style: clockStyle,
      ),
    );
  }
}
