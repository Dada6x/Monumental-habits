import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';

class HabitListPage extends StatefulWidget {
  @override
  _HabitListPageState createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final List<Color> randomRowColors = const [
    Color(darkOrange),
    Color(0xFFF65B4E),
    Color(0xFF29319F),
    Color(0xFF973456),
  ];

  late Future<Map<String, dynamic>> futureHabits;

  @override
  void initState() {
    super.initState();
    futureHabits = fetchHabitData();
  }

  // Fetching the habit data from an API
  Future<Map<String, dynamic>> fetchHabitData() async {
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
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Get the status color for each day of the week for each habit
  Map<String, Color> getDayStatus(Map<String, dynamic> habit) {
    Map<String, Color> dayStatus = {};
    List<String> daysOfWeek = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];

    for (var day in daysOfWeek) {
      var log = habit['habit_logs'].firstWhere(
        (log) => log['day_of_week'] == day,
        orElse: () => null,
      );

      // Default to green (status = 0)
      dayStatus[day] = log != null && log['status'] == 0
          ? Colors.green
          : Colors.red; // Set to red if status == 1
    }

    return dayStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      child: FutureBuilder<Map<String, dynamic>>(
        future: futureHabits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var habits = snapshot.data?['habits'];

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowHeight: 60,
                  dataRowMinHeight: 50,
                  dataRowMaxHeight: 80,
                  showBottomBorder: false,
                  dividerThickness: double.infinity,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('Habit Name')),
                    DataColumn(label: Text('Sun')),
                    DataColumn(label: Text('Mon')),
                    DataColumn(label: Text('Tue')),
                    DataColumn(label: Text('Wed')),
                    DataColumn(label: Text('Thu')),
                    DataColumn(label: Text('Fri')),
                    DataColumn(label: Text('Sat')),
                  ],
                  rows: habits.map<DataRow>((habit) {
                    int rowIndex = habits.indexOf(habit);
                    return DataRow(cells: [
                      // Habit Name as the first cell
                      DataCell(Text(habit['name'])),
                      // Days of the week as the other cells
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
                              color: randomRowColors[rowIndex % 4],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        );
                      }),
                    ]);
                  }).toList(),
                ),
              ),
            );
          }

          return const Center(child: Text("No data found"));
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HabitListPage(),
  ));
}
