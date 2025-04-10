import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';

class HabitTable extends StatefulWidget {
  @override
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

  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    fetchHabitData(); // Initial fetch
    _pollingTimer = Timer.periodic(Duration(seconds: 5), (_) {
      fetchHabitData(); // Auto update every 5 seconds
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _streamController.close();
    super.dispose();
  }

  void fetchHabitData() async {
    Dio dio = Dio();
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
      }
    } catch (e) {
      _streamController.addError('Failed to load data: $e');
    }
  }

  Map<String, Color> getDayStatus(Map<String, dynamic> habit) {
    Map<String, Color> dayStatus = {};
    return dayStatus;
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
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var habits = snapshot.data?['habits'];
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
                  return DataRow(cells: [
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
          return const Center(child: Text("No Habits yet \n add something !"));
        },
      ),
    );
  }
}
