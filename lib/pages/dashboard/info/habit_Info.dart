import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/dashboard/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/dashboard/info/calander.dart';
import 'package:monumental_habits/pages/dashboard/edit/editHabit.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

class HabitInfoPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final habit;
  final HabitController habitController = Get.find<HabitController>();
  HabitInfoPage({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.scrim,
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          habit.name,
          style: manropeFun(context),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              //! EDIT HABIT
              Get.to(() => EditHabit(
                    habitAAA: habit,
                  ));
            },
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).colorScheme.scrim,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(SizeConfig.screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! Habit Info
                Container(
                  padding: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenWidth * 0.04),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.screenWidth * 0.04),
                        child: Image.asset(
                          "assets/images/tent.png",
                          width: MediaQuery.sizeOf(context).width * 0.27,
                          height: MediaQuery.sizeOf(context).height * 0.12,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(habit.name,
                                style: klasikFun(context),
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.005),
                            infoRow(
                                Icons.notifications_outlined,
                                //function to print everyday if the user selected it all
                                "Repeat: ${getSelectedDays(habit.selectedDays)}"),
                            infoRow(Icons.restart_alt_outlined,
                                "Reminder: ${habit.chosenTime}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                //! Calendar
                Container(
                  height: constraints.maxWidth > 600
                      ? MediaQuery.sizeOf(context).height * 0.5
                      : MediaQuery.sizeOf(context).height * 0.65,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.sizeOf(context).width * 0.04),
                  ),
                  child: const Center(child: HabitCalendar()),
                ),
                //! Analytics Section
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.02),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Analytics", style: manropeFun(context))),
                ),
                Container(
                  padding:
                      EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.025),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.sizeOf(context).width * 0.04),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      analyticsColumn([
                        customWidget("20 Days", "Longest Streak",
                            "assets/images/Fire.svg"),
                        customWidget("98%", "Completion Rate",
                            "assets/images/EllipseDiagrams.svg"),
                      ]),
                      analyticsColumn([
                        customWidget("0 Days", "Current Streak",
                            "assets/images/LightningIcon.svg"),
                        customWidget("7", "Average Easiness Score",
                            "assets/images/Leaf.svg"),
                      ]),
                    ],
                  ),
                ),
                //! Delete Button
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.02,
                      horizontal: MediaQuery.sizeOf(context).height * 0.02),
                  child: Button(context, "Delete This Habit ?",
                      () => _deleteHabit(context)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _deleteHabit(BuildContext context) {
    habitController.deleteHabit(habit);
    Get.back();
  }

  String getSelectedDays(Map<String, bool> days) {
    List<String> selected = days.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return selected.length == days.length ? "Everyday" : selected.join(', ');
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon,
            size: SizeConfig.screenWidth * 0.05,
            color: const Color(darkOrange)),
        SizedBox(width: SizeConfig.screenWidth * 0.02),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.035,
                fontFamily: "manrope",
                color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget analyticsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget customWidget(String bigText, String smallText, String assets) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(bigText, style: klasik),
            Text(smallText, softWrap: true, textAlign: TextAlign.left),
          ],
        ),
        SvgPicture.asset(assets, height: 20, width: 20),
      ],
    );
  }
}
