import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/pages/habit/info/habit_Info.dart';
import 'package:monumental_habits/util/helper.dart';

class HabitTable extends StatefulWidget {
  const HabitTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitTableState createState() => _HabitTableState();
}

class _HabitTableState extends State<HabitTable> {
  final List<Color> randomRowColors = const [
    Color(darkOrange),
    Color(0xFFF65B4E),
    Color(0xFF29319F),
    Color(0xFF973456),
  ];

  final StreamController<Map<String, dynamic>> _streamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    fetchHabitData(); // Initial fetch
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void fetchHabitData() async {
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
        _streamController.add(response.data);
      } else {
        _streamController.addError('Failed to load data');
        Get.showSnackbar(
          const GetSnackBar(
            title: "Error",
            message: "Failed to load data from server",
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      _streamController.addError('Exception :Failed to load data: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: "Exception",
          message: e.toString(),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: StreamBuilder<Map<String, dynamic>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
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
            return InteractiveViewer(
              constrained: false,
              child: DataTable(
                headingRowHeight: 60,
                dataRowMinHeight: 50,
                dataRowMaxHeight: 80,
                showBottomBorder: false,
                dividerThickness: double.infinity,
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(label: Text('Habit', style: klasik)),
                  DataColumn(label: Text('SUN', style: manrope)),
                  DataColumn(label: Text('MON', style: manrope)),
                  DataColumn(label: Text('TUE', style: manrope)),
                  DataColumn(label: Text('WED', style: manrope)),
                  DataColumn(label: Text('THU', style: manrope)),
                  DataColumn(label: Text('FRI', style: manrope)),
                  DataColumn(label: Text('SAT', style: manrope)),
                ],
                rows: habits.map<DataRow>((habit) {
                  int rowIndex = habits.indexOf(habit);
                  return DataRow(
                      onLongPress: () {
                        Get.to(HabitInfoPage(id: habit['id']));
                      },
                      cells: [
                        DataCell(Text(habit['name'], style: klasik)),
                        ...[
                          'Sunday',
                          'Monday',
                          'Tuesday',
                          'Wednesday',
                          'Thursday',
                          'Friday',
                          'Saturday'
                        ].map((day) {
                          return DataCell(
                            onTap: () {
//! or in gesture detector 
                            },
                            Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(
                                color: habit['status'] != null
                                    ? Colors.red
                                    : randomRowColors[rowIndex % 4],
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          );
                        }),
                      ]);
                }).toList(),
              ),
            );
          }
          return const SizedBox(); 
        },
      ),
    );
  }
}
