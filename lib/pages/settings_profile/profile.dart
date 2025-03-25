import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/pages/settings_profile/customization.dart';
import 'package:monumental_habits/pages/settings_profile/settings.dart';
import 'package:monumental_habits/pages/settings_profile/support/profile_details.dart';
import 'package:monumental_habits/util/helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.scrim;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile".tr,
          style: manropeFun(context),
        ),
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
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
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.tertiary,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 35,
                          foregroundImage:
                              NetworkImage("https://picsum.photos/200/300.jpg"),
                        ),
                        title: Text(
                          "Ward Ekhtiar",
                          style: TextStyle(
                              color: mainColor,
                              fontFamily: "manrope",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          "Wardekr@gmail.com",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "manrope",
                              fontSize: 12),
                        ),
                        trailing: IconButton(
                            style: IconButton.styleFrom(
                                shape: CircleBorder(
                                    side: BorderSide(
                                        width: 3.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryFixed))),
                            onPressed: () {
                              Get.to(() => const ProfileDetails());
                            },
                            icon: Expanded(
                              child: Icon(
                                color: mainColor,
                                Icons.more_horiz,
                                size: 24,
                              ),
                            )),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      height: 0,
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ListTile(
                                  title: Text(
                                    "Top Streak".tr,
                                    style: manropeLavander,
                                    overflow: TextOverflow.clip,
                                  ),
                                  subtitle: Text(
                                    "34",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .scrim, // Uses context-based color
                                    ),
                                  ),
                                  trailing: CustomIcons(
                                      color: Colors.green,
                                      icon: Icons.access_time_filled))),
                          VerticalDivider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Expanded(
                              child: ListTile(
                            title: SizedBox(
                              child: Text(
                                "Milestones".tr,
                                style: manropeLavander,
                              ),
                            ),
                            subtitle: Text(
                              "6",
                              style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .scrim, // Uses context-based color
                              ),
                            ),
                            trailing: CustomIcons(
                                color: Colors.red, icon: Icons.emoji_events),
                          ))
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      height: 0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            progressWheel(
                              numOfAllHabits: 4,
                              numOfDoneHabits: 1,
                              day: "Sunday".tr,
                            ),
                            progressWheel(
                              numOfAllHabits: 10,
                              numOfDoneHabits: 3,
                              day: "Monday".tr,
                            ),
                            progressWheel(
                              numOfAllHabits: 6,
                              numOfDoneHabits: 4,
                              day: "Tuesday".tr,
                            ),
                            progressWheel(
                              numOfAllHabits: 6,
                              numOfDoneHabits: 6,
                              day: "Wednesday".tr,
                            ),
                            progressWheel(
                              numOfAllHabits: 10,
                              numOfDoneHabits: 2,
                              day: "Thursday".tr,
                            ),
                            progressWheel(
                              numOfAllHabits: 10,
                              numOfDoneHabits: 20,
                              day: "Friday".tr,
                            ),
                            progressWheel(
                              numOfAllHabits: 10.0,
                              numOfDoneHabits: 20.0,
                              day: "Saturday".tr,
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
          SettingsTabs(
            title: "Billing methods".tr,
            subTitle: null,
            leadIcon: Icons.credit_card,
            targetPage: CustomizePage(),
          )
        ],
      ),
    );
  }
}

class progressWheel extends StatefulWidget {
  progressWheel(
      {super.key,
      required this.numOfAllHabits,
      required this.numOfDoneHabits,
      required this.day});
  final double numOfAllHabits;
  final double numOfDoneHabits;
  final String day;

  @override
  State<progressWheel> createState() => _progressWheelState();
}

class _progressWheelState extends State<progressWheel> {
  Color progressColor(double value) {
    if (value >= 0 && value <= 0.25) {
      return Colors.red;
    }
    if (value >= 0.26 && value <= 0.5) {
      return Colors.orange;
    }
    if (value >= 0.51 && value <= 0.75) {
      return Colors.yellow;
    }
    if (value >= 0.76 && value <= 1) {
      return Colors.green;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.scrim;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: progressColor(
                      widget.numOfDoneHabits / widget.numOfAllHabits),
                  strokeWidth: 2.5,
                  value: (widget.numOfDoneHabits / widget.numOfAllHabits) == 0
                      ? 0.1
                      : (widget.numOfDoneHabits / widget.numOfAllHabits),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "0/1",
                  style: TextStyle(color: mainColor, fontFamily: "klasik"),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.00),
            child: Text(
              widget.day,
              style: TextStyle(color: mainColor, fontFamily: "klasik"),
            ),
          )
        ],
      ),
    );
  }
}
