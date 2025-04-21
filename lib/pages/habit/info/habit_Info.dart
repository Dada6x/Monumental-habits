import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/home/homePage.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/pages/habit/controllers/habitcontroller.dart';

import 'package:monumental_habits/pages/habit/dashboard_homepage/habitTable.dart';
import 'package:monumental_habits/pages/habit/edit/editHabit.dart';
import 'package:monumental_habits/pages/habit/info/calander.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/widgets/Buttons.dart';

class HabitInfoPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;

  const HabitInfoPage({super.key, required this.id});
  @override
  State<HabitInfoPage> createState() => _HabitInfoPageState();
}

class _HabitInfoPageState extends State<HabitInfoPage> {
  final HabitController habitController = Get.find<HabitController>();

  var reminderTime = '';
  var longestStreak = 0;
  var currentStreak = 0;
  var completionRate = 0.0;
  var easiness = '';

  @override
  void initState() {
    super.initState();
    fetchHabitData();
  }

  void deleteHabit(int id) async {
    try {
      String apiUrl = 'http://10.0.2.2:8000/api/habits/$id';
      var response = await dio.delete(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token!.getString("token")}',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Habit deleted successfully! ',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: const Color(darkOrange),
            icon: const Icon(Icons.delete));
        Get.off(() => HomePage());
        habitTableKey.currentState?.refreshTable();
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete habit. Try again later. ❌',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error: Unable to delete habit. Please check your connection. ❌',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  Future<String> fetchHabitData() async {
    String apiUrl = 'http://10.0.2.2:8000/api/habits/${widget.id}';
    try {
      final response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token!.getString("token")}',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return jsonEncode(response.data);
      } else {
        print('error');
      }
    } catch (e) {
      print('exception $e');
    }
    return "";
  }

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
        // title: Text(
        //   name,
        //   style: manropeFun(context),
        //   overflow: TextOverflow.ellipsis,
        // ),
        actions: [
          IconButton(
            onPressed: () {
              // !!! EDIT HABIT
              Get.to(() => EditHabit());
            },
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).colorScheme.scrim,
            ),
          ),
        ], //
      ),
      body: FutureBuilder(
        future: fetchHabitData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var returnedData = jsonDecode(snapshot.data!);
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(SizeConfig.screenWidth * 0.04),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! Habit Info
                        Container(
                          padding:
                              EdgeInsets.all(SizeConfig.screenWidth * 0.025),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(19),
                                child: Image.asset(
                                  "assets/images/tent.png",
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.27,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.12,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.03),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    returnedData['habit']['name'],
                                    style: klasikFun(context),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.notifications_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      Text(
                                        "Reminder Time : ${returnedData['habit']['reminder_time']}",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.restart_alt_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      //TODO wait for abdo to fix this
                                      const Text("Repeat : days "),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
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
                              vertical:
                                  MediaQuery.sizeOf(context).height * 0.02),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Analytics",
                                  style: manropeFun(context))),
                        ),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).width * 0.025),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.sizeOf(context).width * 0.04),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              analyticsColumn([
                                customWidget(
                                    "${returnedData['longest_streak']} Days",
                                    "Longest Streak",
                                    "assets/images/Fire.svg"),
                                customWidget(
                                    "${returnedData['current_streak']} %",
                                    "Completion Rate",
                                    "assets/images/EllipseDiagrams.svg"),
                              ]),
                              analyticsColumn([
                                customWidget(
                                    "${returnedData['complete_rate']}",
                                    "Current Streak",
                                    "assets/images/LightningIcon.svg"),
                                customWidget(
                                    returnedData['easiness'],
                                    "Average Easiness Score",
                                    "assets/images/Leaf.svg"),
                              ]),
                            ],
                          ),
                        ),
                        //! Delete Button
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.sizeOf(context).height * 0.02,
                              horizontal:
                                  MediaQuery.sizeOf(context).height * 0.02),
                          child:
                              Button(context, "Delete This Habit ?", () async {
                            // Show a confirmation dialog before deletion
                            bool? confirmDelete = await Get.dialog(
                              AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    'Do you want to delete this habit? This action cannot be undone.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                            if (confirmDelete == true) {
                              deleteHabit(widget.id);
                            } else {
                              Get.snackbar(
                                'Cancelled',
                                'Habit deletion was cancelled. 🔒',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.blue,
                                colorText: Colors.white,
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget analyticsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

//TODO make it look nicer :D @Ward-ikhtiyar plz @
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
        SvgPicture.asset(assets, height: 30, width: 30),
      ],
    );
  }
}
