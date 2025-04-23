import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:table_calendar/table_calendar.dart';

// Mocked Color Constants
const int orange = 0xFFFF9800;
const Color altPurple = Color(0xFF9575CD);
const TextStyle manropeGrey = TextStyle(color: Colors.grey);

class HabitLog {
  final int id;
  final DateTime date;
  final int? status;

  HabitLog({required this.id, required this.date, this.status});

  factory HabitLog.fromJson(Map<String, dynamic> json) {
    return HabitLog(
      id: json['id'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}

class HabitService {
  Future<List<HabitLog>> fetchHabitLogs() async {
    final response = await dio.get('http://10.0.2.2:8000/api/habits/119');
    List<dynamic> logsJson = response.data['habit']['habit_logs'];
    return logsJson.map((json) => HabitLog.fromJson(json)).toList();
  }
}

class HClander extends StatefulWidget {
  const HClander({super.key});

  @override
  _HClanderState createState() => _HClanderState();
}

class _HClanderState extends State<HClander> {
  DateTime _selectedMonth = DateTime.now();
  List<HabitLog> logs = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final service = HabitService();
    final fetchedLogs = await service.fetchHabitLogs();
    setState(() {
      logs = fetchedLogs;
    });
  }

  void _changeMonth(int offset) {
    final now = DateTime.now();
    final newMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month + offset, 1);
    final currentMonth = DateTime(now.year, now.month, 1);

    // Prevent moving forward beyond the current month
    if (newMonth.isAfter(currentMonth)) return;

    setState(() {
      _selectedMonth = newMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  size: screenWidth * 0.05,
                  Icons.arrow_back_ios_new_outlined,
                  color: Theme.of(context).colorScheme.scrim,
                ),
                onPressed: () => _changeMonth(-1),
              ),
              Text(
                DateFormat.yMMMM().format(_selectedMonth),
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.scrim,
                ),
              ),
              IconButton(
                icon: Icon(
                  size: screenWidth * 0.05,
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).colorScheme.scrim,
                ),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime(2020, 1, 1),
              lastDay: DateTime(2100, 12, 31),
              focusedDay: _selectedMonth,
              calendarFormat: CalendarFormat.month,
              headerVisible: false,
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, focusedDay) {
                  int currentDay = DateTime.now().day;
                  return Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "$currentDay",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? altPurple
                                  : const Color(orange),
                            ),
                          ),
                          const SizedBox(height: 9),
                          Container(
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? altPurple
                                  : const Color(darkOrange),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                defaultBuilder: (context, date, _) {
                  int day = date.day;
                  HabitLog? log = logs.firstWhereOrNull(
                    (element) =>
                        element.date.year == date.year &&
                        element.date.month == date.month &&
                        element.date.day == date.day,
                  );

                  Color? boxColor;
                  if (log != null) {
                    if (log.status == 1) {
                      boxColor =
                          Get.isDarkMode ? altPurple : const Color(darkOrange);
                    } else if (log.status == 0) {
                      boxColor = Colors.green;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "$day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.scrim,
                            ),
                          ),
                          const SizedBox(height: 9),
                          Container(
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            decoration: BoxDecoration(
                              color: boxColor ?? Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              daysOfWeekVisible: true,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: manropeGrey,
                weekendStyle: manropeGrey,
              ),
              rowHeight: screenHeight * 0.088,
              daysOfWeekHeight: 30,
              calendarStyle: const CalendarStyle(
                cellPadding: EdgeInsets.all(2),
                isTodayHighlighted: true,
              ),
              availableGestures: AvailableGestures.none,
            ),
          ),
        ],
      ),
    );
  }
}
