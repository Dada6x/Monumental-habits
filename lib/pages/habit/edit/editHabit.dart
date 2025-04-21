import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';

class Edithabit extends StatefulWidget {
  final String name;
  final List<String> habitFreq;
  final String reminder;
  final bool noti;

  const Edithabit(
      {super.key,
      required this.name,
      required this.habitFreq,
      required this.reminder,
      required this.noti});

  @override
  State<Edithabit> createState() => _EdithabitState();
}

void updateHabit(String name, dynamic habitFreq) async {
  try {
    var response = await Dio().post(
      "http://10.0.2.2:8000/api/habits",
      data: {'name': name, "days": habitFreq, "reminder_time": null},
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
          title: "Success",
          message: "Habit Updated successfully ",
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: response.data["message"] ?? "Something went wrong",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    print("Unexpected error: $e");
    Get.showSnackbar(
      GetSnackBar(
        title: "Exception",
        message: e.toString(),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _EdithabitState extends State<Edithabit> {
  late TextEditingController nameController;
  late RxList<String> selectedDays;
  late RxString chosenTime;
  late RxBool notificationsEnabled;
  static const List<String> weekDays = [
    "SUN",
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT"
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    selectedDays = widget.habitFreq.map((e) => e.toLowerCase()).toList().obs;
    chosenTime = widget.reminder.obs;
    notificationsEnabled = widget.noti.obs;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void handleSave() {
    final updatedName = nameController.text;
    final updatedFreq = selectedDays.toList();
    final updatedReminder = chosenTime.value;
    final updatedNoti = notificationsEnabled.value;

    // Here you can trigger your update request with these updated values
    print("Saving updated habit:");
    print("Name: $updatedName");
    print("Freq: $updatedFreq");
    print("Reminder: $updatedReminder");
    print("Notification: $updatedNoti");

    // Just pop for now
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit", style: manropeFun(context)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: handleSave,
            icon: const Icon(Icons.save_alt),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //! Habit Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.tertiary,
                filled: true,
                labelText: "Habit Name",
                labelStyle: klasikHint,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Get.isDarkMode ? altPurple : const Color(orange),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            //! Habit Frequency
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
                          Text("Habit Frequency", style: manropeFun(context)),
                          const Spacer(),
                          Text("Custom", style: manropeOrangeAndPurple(context))
                        ],
                      ),
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(7, (index) {
                            String day = weekDays[index].toLowerCase();
                            bool isSelected = selectedDays.contains(day);
                            return GestureDetector(
                              onTap: () {
                                if (isSelected) {
                                  selectedDays.remove(day);
                                } else {
                                  selectedDays.add(day);
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Column(
                                  children: [
                                    Text(weekDays[index],
                                        style: manropeLavander),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: isSelected
                                            ? Center(
                                                child: Container(
                                                  width: 31,
                                                  height: 31,
                                                  decoration: BoxDecoration(
                                                    color: Get.isDarkMode
                                                        ? const Color(
                                                            darkPurple)
                                                        : const Color(
                                                            darkOrange),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
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
                        )),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            //! Reminder
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () async {
                  final time = await Get.bottomSheet(
                    Reminder(initial: chosenTime.value),
                    isScrollControlled: true,
                  );
                  if (time != null) chosenTime.value = time;
                },
                child: Container(
                  height: 60,
                  decoration: customContainer(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Reminder", style: manropeFun(context)),
                        const Spacer(),
                        Obx(() => Text(chosenTime.value,
                            style: manropeOrangeAndPurple(context)))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //! Notifications
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 60,
                decoration: customContainer(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Notifications", style: manropeFun(context)),
                      const Spacer(),
                      Obx(() => Switch(
                          activeColor: const Color(darkOrange),
                          inactiveThumbColor: const Color(darkPurple),
                          inactiveTrackColor: const Color(lavander),
                          trackOutlineColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          value: notificationsEnabled.value,
                          onChanged: (value) =>
                              notificationsEnabled.value = value))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reminder Widget - same as before but accepts initial value
class Reminder extends StatelessWidget {
  final RxInt selectedHour = 1.obs;
  final RxInt selectedMinute = 0.obs;
  final RxString selectedPeriod = 'AM'.obs;
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();

  Reminder({super.key, required String initial}) {
    if (initial.isNotEmpty) {
      final parts = initial.split(RegExp(r'[: ]'));
      if (parts.length == 3) {
        selectedHour.value = int.parse(parts[0]);
        selectedMinute.value = int.parse(parts[1]);
        selectedPeriod.value = parts[2];
        _hourController.jumpToItem(selectedHour.value - 1);
        _minuteController.jumpToItem(selectedMinute.value);
      }
    }
  }

  void _saveReminder() {
    String formattedTime =
        "${selectedHour.value.toString().padLeft(2, '0')}:${selectedMinute.value.toString().padLeft(2, '0')} ${selectedPeriod.value}";
    Get.back(result: formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiary,
      height: MediaQuery.sizeOf(context).height * 0.5,
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
          child: Text("Cancel", style: manropeOrangeAndPurple(context)),
        ),
        const Spacer(),
        Text("Add Reminder", style: manropeFun(context)),
        const Spacer(),
        TextButton(
          onPressed: _saveReminder,
          child: Text("Save", style: manropeOrangeAndPurple(context)),
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
