import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

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
    print(formattedTime);
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
            // style: manropeOrangeAndPurple(context),
          ),
        ),
        const Spacer(),
        Text(
          "Add Reminder",
          // style: manropeFun(context),
        ),
        const Spacer(),
        TextButton(
          onPressed: _saveReminder,
          child: Text(
            "Save",
            // style: manropeOrangeAndPurple(context),
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
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

const TextStyle clockStyle = TextStyle(
  fontFamily: "Klasik",
  fontSize: 40,
);
