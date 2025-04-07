import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/Middleware/auth_middleware.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/pages/settings_profile/customization.dart';
import 'package:monumental_habits/pages/settings_profile/settings.dart';
import 'package:monumental_habits/pages/settings_profile/support/profile_details.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/widgets/customappBar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  String returnedData = "";
  bool isLoggedOut = false;
  Future<void> logout() async {
    print('Token: ${token?.getString("token")}');

    final response = await Dio().request(
      "http://10.0.2.2:8000/api/logout",
      options: Options(
        followRedirects: false,
        method: 'POST',
        headers: {
          'Accept': "application/json",
          'Authorization': "Bearer ${token!.getString("token")}"
        },
      ),
    );
    print("headers ${response.headers["Location"]}");
    print(response.data);
    if (response.data["status"]) {
      isLoggedOut = true;
    }
  }

  static Future<String> getProfile(String returnedData) async {
    final request = await Dio().get("http://10.0.2.2:8000/api/profile",
        options: Options(headers: {
          "Accept": 'application/json',
          "Authorization": "Bearer ${token!.getString("token")}"
        }));
    if (request.statusCode == 200) {
      returnedData = jsonEncode(request.data);
      return returnedData;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).colorScheme.scrim;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: customappBar([
        IconButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.secondaryContainer,
            )),
            onPressed: () async {
              await logout();
              if (isLoggedOut) {
                AuthMiddleware.isRedirectedAuth = false;
                token!.remove("token");
                Get.offNamed("/Auth");
              }
            },
            icon: Icon(
              Icons.logout_sharp,
              color: Get.isDarkMode ? Colors.white : const Color(darkPurple),
            )),
        const SizedBox(
          width: 20,
        )
      ], "Profile".tr, context),
      body: FutureBuilder(
          future: getProfile(returnedData),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var returnedData = jsonDecode(snapshot.data!);
              return Column(
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
                                leading: CircleAvatar(
                                  radius: 35,
                                  foregroundImage: NetworkImage(
                                      returnedData["user"]["photo"]),
                                ),
                                title: Text(
                                  returnedData["user"]["name"],
                                  style: TextStyle(
                                      color: mainColor,
                                      fontFamily: "manrope",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  returnedData["user"]["email"],
                                  style: const TextStyle(
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
                                      Get.to(() => ProfileDetails(),
                                          arguments: {"data": returnedData});
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
                                            returnedData["longest_streak"] ==
                                                    null
                                                ? "0"
                                                : "${returnedData["longest_streak"]}",
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                      "${returnedData["achievements"]}",
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
                                        color: Colors.red,
                                        icon: Icons.emoji_events),
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
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Sunday"],
                                      numOfAllHabits: 4,
                                      numOfDoneHabits: 1,
                                      day: "Sunday".tr,
                                    ),
                                    progressWheel(
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Monday"],
                                      numOfAllHabits: 10,
                                      numOfDoneHabits: 3,
                                      day: "Monday".tr,
                                    ),
                                    progressWheel(
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Tuesday"],
                                      numOfAllHabits: 6,
                                      numOfDoneHabits: 4,
                                      day: "Tuesday".tr,
                                    ),
                                    progressWheel(
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Wednesday"],
                                      numOfAllHabits: 6,
                                      numOfDoneHabits: 6,
                                      day: "Wednesday".tr,
                                    ),
                                    progressWheel(
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Thursday"],
                                      numOfAllHabits: 10,
                                      numOfDoneHabits: 2,
                                      day: "Thursday".tr,
                                    ),
                                    progressWheel(
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Friday"],
                                      numOfAllHabits: 10,
                                      numOfDoneHabits: 20,
                                      day: "Friday".tr,
                                    ),
                                    progressWheel(
                                      centerText:
                                          returnedData["habits_completion"]
                                              ["Saturday"],
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
              );
            }
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Getting Your Profile Deatils...",
                    style: klasik,
                  ),
                )
              ],
            );
          }),
    );
  }
}

class progressWheel extends StatefulWidget {
  const progressWheel(
      {super.key,
      required this.numOfAllHabits,
      required this.numOfDoneHabits,
      required this.day,
      required this.centerText});
  final double numOfAllHabits;
  final double numOfDoneHabits;
  final String day;
  final String centerText;

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
