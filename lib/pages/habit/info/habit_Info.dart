import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/pages/habit/controllers/habitcontroller.dart';
import 'package:monumental_habits/pages/habit/edit/editHabit.dart';
import 'package:monumental_habits/pages/habit/info/log.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:monumental_habits/util/widgets/Buttons.dart';

class HabitInfoPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;

  const HabitInfoPage({super.key, required this.id});
  @override
  State<HabitInfoPage> createState() => _HabitInfoPageState();
}

class _HabitInfoPageState extends State<HabitInfoPage> {
  final HabitController habitController = Get.find<HabitController>();
  //?analytics
  var completionRate;
  var easiness;
  var longestStreak;
  var currentStreak;
// Editable info
  var reminderTime;
  var name;
  var days;
  var habitID;
  // bool notificationEnabled=false;

  final dayShortener = {
    "Sunday": "sun",
    "monday": "mon",
    "tuesday": "tue",
    "wednesday": "wed",
    "thursday": "thu",
    "friday": "fri",
    "saturday": "sat",
  };

  @override
  void initState() {
    super.initState();
    fetchHabitData();
  }

//! fetching Habits Data
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
        name = response.data['habit']['name'];
        reminderTime = response.data['habit']['reminder_time'];
        days = response.data['habit']['days'];
        habitID = response.data['habit']['id'];

        currentStreak = response.data['current_streak'];
        longestStreak = response.data['longest_streak'];
        completionRate = response.data['complete_rate'];
        easiness = response.data['easiness'];

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
              //!!! EDIT HABIT
              Get.to(
                () => editHabit(
                  id: widget.id,
                  name: name,
                  habitFreq: days
                      .map((d) => {
                            "Sunday": "sun",
                            "Monday": "mon",
                            "Tuesday": "tue",
                            "Wednesday": "wed",
                            "Thursday": "thu",
                            "Friday": "fri",
                            "Saturday": "sat"
                          }[d]!)
                      .toList(),
                  reminder: reminderTime,
                  noti: true,
                ),
              );
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
                        // Text("${habitID}"),
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
                                    name,
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
                                        overflow: TextOverflow.ellipsis,
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
                                      Text("Repeat: ${days.map((d) => {
                                            'Sunday': 'Sun',
                                            'Monday': 'Mon',
                                            'everyday': 'Everyday',
                                            'Tuesday': 'Tue',
                                            'Wednesday': 'Wed',
                                            'Thursday': 'Thu',
                                            'Friday': 'Fri',
                                            'Saturday': 'Sat'
                                          }[d.trim()]!).join(',')} "),
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
                          child: Center(child: HabitCalendar(id: widget.id)),
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
                                customWidget("${longestStreak} Days",
                                    "Longest Streak", "assets/images/Fire.svg"),
                                customWidget(
                                    "${currentStreak} %",
                                    "Completion Rate",
                                    "assets/images/EllipseDiagrams.svg"),
                              ]),
                              analyticsColumn([
                                customWidget(
                                    "${completionRate}",
                                    "Current Streak",
                                    "assets/images/LightningIcon.svg"),
                                customWidget(
                                    "${easiness}",
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
                            bool? confirmDelete = await Get.dialog(
                              AlertDialog(
                                title: const Center(
                                  child: Text(
                                    'Are you sure?',
                                    style: klasikHeader,
                                  ),
                                ),
                                content: const Text(
                                  'Do you want to delete this habit .This action cannot be undone.',
                                  style: manrope,
                                ),
                                actions: <Widget>[
                                  ButtonLighter(context, "Cancel", () {
                                    Get.back(result: false);
                                  }),
                                  Button(context, "Delete", () {
                                    Get.back(result: true);
                                  }),
                                ],
                              ),
                            );
                            if (confirmDelete == true) {
                              HabitController().deleteHabit(widget.id);
                            } else {}
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
