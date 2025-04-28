import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:dio/dio.dart';
import 'package:collection/collection.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/pages/habit/info/habit_Info.dart';
import 'package:monumental_habits/util/helper.dart';

final GlobalKey<_HabitTableState> habitTableKey = GlobalKey<_HabitTableState>();

class HabitTable extends StatefulWidget {
  const HabitTable({super.key});

  @override
  _HabitTableState createState() => _HabitTableState();
}

class _HabitTableState extends State<HabitTable> {
  Future<Map<String, dynamic>>? habitDataFuture;

  void refreshTable() {
    setState(() {
      habitDataFuture = fetchHabitData();
    });
  }

  final List<Color> randomRowColors = const [
    Color(0xFFFF8C00),
    Color(0xFFF65B4E),
    Color(0xFF29319F),
    Color(0xFF973456),
  ];

  @override
  void initState() {
    super.initState();
    habitDataFuture = fetchHabitData();
  }

  Future<Map<String, dynamic>> fetchHabitData() async {
    String apiUrl = 'http://10.0.2.2:8000/api/homepage?order=0';
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
        return response.data;
      } else {
        throw Exception("Failed to load data from server");
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: FutureBuilder<Map<String, dynamic>>(
        future: habitDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Column(
              children: [
                SizedBox(height: 20),
                CircularProgressIndicator(),
                SizedBox(height: 20),
              ],
            ));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          } else if (snapshot.hasData) {
            var habits = snapshot.data?['habits'];
            if (habits == null || habits.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animations/ghost.json",
                      filterQuality: FilterQuality.high,
                    ),
                    const Text(
                      "No Habits yet\nAdd something!",
                      textAlign: TextAlign.center,
                      style: manrope,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              );
            }

            final firstHabitLogs = habits.first['habit_logs'] as List<dynamic>;
            final orderedDays = <String>{};
            for (var log in firstHabitLogs) {
              orderedDays.add(log['day_of_week']);
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DataTable(
                    headingRowHeight: 60,
                    dataRowMinHeight: 50,
                    dataRowMaxHeight: 80,
                    showBottomBorder: false,
                    dividerThickness: double.infinity,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(
                          label: Text('Habit', style: klasikFun(context))),
                      ...orderedDays.mapIndexed((index, day) {
                        final label = index == 0
                            ? 'Today\n${day.substring(0, 3).toUpperCase()}'
                            : day.substring(0, 3).toUpperCase();
                        return DataColumn(
                          label: Text(label, style: klasikFun(context)),
                        );
                      }),
                    ],
                    rows: habits.map<DataRow>((habit) {
                      int rowIndex = habits.indexOf(habit);
                      return DataRow(
                        cells: [
                          DataCell(
                            onTap: () {
                              Get.to(HabitInfoPage(id: habit['id']));
                            },
                            // onLongPress: () {
                            //   Get.to(HabitInfoPage(id: habit['id']));
                            // },
                            Text(habit['name'], style: klasikFun(context)),
                          ),
                          ...orderedDays.mapIndexed((index, day) {
                            final logs = habit['habit_logs'] as List<dynamic>;
                            final log = logs.firstWhere(
                              (l) => l['day_of_week'] == day,
                              orElse: () => null,
                            );

                            Color? boxColor;
                            if (log == null || log['status'] == null) {
                              boxColor = Colors.transparent;
                            } else if (log['status'] == 1) {
                              boxColor = randomRowColors[rowIndex % 4];
                            } else if (log['status'] == 0) {
                              boxColor =
                                  Theme.of(context).colorScheme.onTertiary;
                            }

                            Future<void> sendHabitLogs() async {
                              if (log == null) return;
                              String apiUrl =
                                  'http://10.0.2.2:8000/api/habit_logs/${log['id']}';
                              try {
                                final response = await dio.post(
                                  apiUrl,
                                  data: {"status": "1"},
                                  options: Options(
                                    headers: {
                                      'Authorization':
                                          'Bearer ${token!.getString("token")}',
                                      'Accept': 'application/json',
                                    },
                                  ),
                                );
                                if (response.statusCode == 200) {
                                  refreshTable();
                                } else {
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      title: "Error",
                                      message:
                                          "Something went wrong, try again later.",
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } catch (e) {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    title: "Exception",
                                    message:
                                        "Something went wrong, try again later.",
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }

                            final cellBox = Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(
                                color: boxColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            );

                            if (index == 0 && log != null) {
                              return DataCell(
                                GestureDetector(
                                  onTap: () async {
                                    if (log['status'] == 0) {
                                      await sendHabitLogs();
                                    }
                                  },
                                  child: cellBox,
                                ),
                              );
                            } else {
                              return DataCell(cellBox);
                            }
                          }),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
