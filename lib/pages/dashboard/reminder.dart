import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';

class Reminder extends StatelessWidget {
  // Use Rx variables to make the time data reactive
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
      color: Colors.white,
      height: SizeConfig.screenHeight * 0.5,
      width: SizeConfig.screenHeight,
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel", style: manropeOrange),
              ),
              const Spacer(),
              const Text("Add Reminder", style: manrope),
              const Spacer(),
              TextButton(
                onPressed: _saveReminder,
                child: const Text("Save", style: manropeOrange),
              ),
            ],
          ),
          //! Time Whleel
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //! Hour Selector
                  SizedBox(
                    width: 70,
                    child: ListWheelScrollView.useDelegate(
                      controller: _hourController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        selectedHour.value = index + 1;
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) => Hours(hrs: index + 1),
                        childCount: 12,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(":", style: clockText),
                  ),
                  //! Minute Selector
                  SizedBox(
                    width: 70,
                    child: ListWheelScrollView.useDelegate(
                      controller: _minuteController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        selectedMinute.value = index;
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) => Minutes(mins: index),
                        childCount: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //! AM/PM
          AMPMSelector(
            onSelected: (period) {
              selectedPeriod.value = period;
            },
          ),
        ],
      ),
    );
  }
}

//! minutes
class Minutes extends StatelessWidget {
  final int mins;
  const Minutes({super.key, required this.mins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(mins.toString().padLeft(2, '0'), style: clockText),
    );
  }
}

//! hours
class Hours extends StatelessWidget {
  final int hrs;
  const Hours({super.key, required this.hrs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(hrs.toString(), style: clockText),
    );
  }
}

const clockText = TextStyle(
  fontFamily: "Klasik",
  fontSize: 40,
  color: Color(darkPurple),
);

//! AM/PM period Selector
class AMPMSelector extends StatefulWidget {
  final Function(String) onSelected;
  const AMPMSelector({super.key, required this.onSelected});

  @override
  _AMPMSelectorState createState() => _AMPMSelectorState();
}

class _AMPMSelectorState extends State<AMPMSelector> {
  String selected = 'AM';
  bool isSelected = false; // Track if the container is selected

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = 'AM';
                isSelected = true; // Set to true when AM is tapped
              });
              widget.onSelected('AM');
            },
            child: Container(
              color: isSelected
                  ? const Color(orange)
                  : const Color(background), // Green when tapped
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "AM",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Klasik",
                    color: isSelected
                        ? const Color(darkPurple)
                        : const Color(darkOrange), // White text when selected
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = 'PM';
                isSelected = false; // Reset to false when PM is tapped
              });
              widget.onSelected('PM');
            },
            child: Container(
              color: isSelected
                  ? const Color(background)
                  : const Color(darkOrange), // Green when tapped
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "PM",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Klasik",
                    color: !isSelected
                        ? const Color(darkPurple) // White text when selected

                        : const Color(darkOrange),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
