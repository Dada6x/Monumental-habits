import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/dashboard/new_habit_page.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

class HabitInfoPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final habit;
  final HabitController habitController =
      Get.find<HabitController>(); // Access the HabitController

  HabitInfoPage({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButton(
            style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(10, 10)),
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondaryContainer,
                )),
            color: Get.isDarkMode ? Colors.white : const Color(darkPurple),
          ),
        ),
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${habit.name}",
          style: manropeFun(context),
        ),
        actions: [
          //! EDIT BUTTON
          IconButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.secondaryContainer,
            )),
            onPressed: () {},
            icon: Icon(
              Icons.edit_outlined,
              color: Get.isDarkMode ? Colors.white : const Color(darkPurple),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/images/tent.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: " ${habit.name}",
                                          style: klasikFun(context)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(
                                            Icons.notifications_outlined,
                                            size: 20,
                                            color: Color(darkOrange)),
                                      ),
                                      TextSpan(
                                        text:
                                            " Repeat : ${getSelectedDays(habit.selectedDays)}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: "manrope",
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(Icons.restart_alt_outlined,
                                            size: 20, color: Color(darkOrange)),
                                      ),
                                      //! Should display the reminder Time
                                      TextSpan(
                                        text: "Reminder :${habit.chosenTime}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: "manrope",
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //! THE CALENDER 📅
              Container(
                height: 600,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text("THE Calendar"),
                ),
              ),
              //! the Analytics TABLE
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Text(
                      "Analytics",
                      style: manropeFun(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                          height: 260,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  customWidget("20 Days ", "Longest Streak",
                                      "assets/images/Fire.svg"),
                                  customWidget("98 %", "Completion Rate",
                                      "assets/images/EllipseDiagrams.svg"),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  customWidget("0 Days", "Current Streak",
                                      "assets/images/LightningIcon.svg"),
                                  customWidget("7", "Average Easiness \nScore",
                                      "assets/images/Leaf.svg"),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),

              Button("Delete This Habit?", () {
                _deleteHabit(context);
              }),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to delete habit
  void _deleteHabit(BuildContext context) {
    habitController.deleteHabit(habit);
    Get.back();
  }

//! to display the selected days
  String getSelectedDays(Map<String, bool> days) {
    List<String> selected = days.entries
        .where((entry) => entry.value) // Filter selected days
        .map((entry) => entry.key) // Get day names
        .toList();

    if (selected.length == days.length) {
      return "Everyday"; // If all days are selected
    } else if (selected.length > 3) {
      return "${selected.take(4).join(', ')}...";
    }
    return selected.join(', ');
  }
}

Widget customWidget(String bigText, String smallText, String assets) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center align content
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text left
        children: [
          Text(
            bigText,
            style: klasik,
          ),
          Text(
            smallText,
            softWrap: true, // Prevents overflow
            textAlign: TextAlign.left,
          ),
        ],
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        height: 40, // Restrict SVG size
        width: 40,
        child: SvgPicture.asset(assets),
      ),
    ],
  );
}
