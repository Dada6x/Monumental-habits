import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitCalendar extends StatefulWidget {
  final id;
  const HabitCalendar({super.key, this.id});

  @override
  _HabitCalendarState createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  DateTime _selectedMonth = DateTime.now();
  Map<int, int?> habitStatus = {}; // Allow nullable status

  @override
  void initState() {
    super.initState();
    _generateHabitData();
    _fetchHabitLogs();
  }

  Future<void> _fetchHabitLogs() async {
    try {
      final response = await dio.get(
        'http://10.0.2.2:8000/api/habits/${widget.id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token!.getString("token")}',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data['status'] == true) {
        final responseData = response.data;
        Map<int, int?> statusMap = {};
        final habitLogs = responseData['habit']?['habit_logs'];
        if (habitLogs != null) {
          for (var log in habitLogs) {
            final date = DateTime.parse(log['date']);
            if (date.month == _selectedMonth.month &&
                date.year == _selectedMonth.year) {
              statusMap[date.day] = log['status'];
            }
          }
        }
        setState(() {
          habitStatus = statusMap;
        });
      } else {
        print('Error: Unexpected response status');
      }
    } catch (e) {
      print('Error fetching Calendar data: $e');
    }
  }

  void _generateHabitData() {
    int daysInMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
    habitStatus.clear();
    for (int i = 1; i <= daysInMonth; i++) {
      habitStatus[i] = -1; // Default to unselected (-1)
    }
  }

  void _changeMonth(int offset) {
    final nextMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month + offset, 1);
    final now = DateTime.now();

    if (nextMonth.isAfter(DateTime(now.year, now.month))) {
      return;
    }

    setState(() {
      _selectedMonth = nextMonth;
      _generateHabitData();
      _fetchHabitLogs();
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
          //! Month Selector
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      size: screenWidth * 0.05, // Scalable icon size
                      Icons.arrow_back_ios_new_outlined,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                    onPressed: () => _changeMonth(-1),
                  ),
                  Text(
                    DateFormat.yMMMM().format(_selectedMonth),
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // Scalable text size
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      size: screenWidth * 0.05, // Scalable icon size
                      Icons.arrow_forward_ios_outlined,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          //! Calendar UI
          Expanded(
              child: TableCalendar(
            firstDay: DateTime(2000, 1, 1),
            lastDay: DateTime(2100, 12, 31),
            focusedDay: _selectedMonth,
            calendarFormat: CalendarFormat.month,
            headerVisible: false,
            calendarBuilders: CalendarBuilders(
              //! TODAY ##########################
              todayBuilder: (context, day, focusedDay) {
                int currentDay = DateTime.now().day;
                int dayNumber = day.day;
                TextStyle dayTextStyle = TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (dayNumber == currentDay)
                      ? (Get.isDarkMode ? altPurple : const Color(orange))
                      : Theme.of(context).colorScheme.scrim,
                );
                Color containerColor = Colors.transparent;
                if (habitStatus.containsKey(dayNumber)) {
                  int? status = habitStatus[dayNumber];
                  // Set color based on habit status
                  if (status == 1) {
                    containerColor =
                        Get.isDarkMode ? altPurple : const Color(darkOrange);
                  } else if (status == 0) {
                    containerColor = Theme.of(context).colorScheme.onTertiary;
                  } else {
                    containerColor = Colors.transparent; // Yellow for //!null
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    width: screenWidth * 0.12, // Scalable width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$dayNumber", // Show only the day number (date)
                          style: dayTextStyle, // Apply text style for today
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Container(
                          width: screenWidth * 0.08, // Scalable size
                          height: screenWidth * 0.08, // Scalable size
                          decoration: BoxDecoration(
                            color:
                                containerColor, // Color based on habit status
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              //! defaultBuilder ##########################
              defaultBuilder: (context, date, _) {
                int dayNumber = date.day;
                TextStyle dayTextStyle = TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .scrim, // Default color for other days
                );
                Color containerColor = Colors.transparent;
                if (habitStatus.containsKey(dayNumber)) {
                  int? status = habitStatus[dayNumber];
                  // Set color based on habit status
                  if (status == 1) {
                    containerColor = Get.isDarkMode
                        ? altPurple
                        : const Color(darkOrange); // Green for completed
                  } else if (status == 0) {
                    containerColor = Get.isDarkMode
                        ? Colors.grey.shade800
                        : Colors.grey.shade300;
                  } else {
                    containerColor = Colors.transparent; // Yellow for no status
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    width: screenWidth * 0.12, // Scalable width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$dayNumber", // Show only the day number (date)
                          style: dayTextStyle, // Apply text style
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        // Container color based on habit status
                        Container(
                          width: screenWidth * 0.08, // Scalable size
                          height: screenWidth * 0.08, // Scalable size
                          decoration: BoxDecoration(
                            color:
                                containerColor, // Color based on habit status
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
          )),
        ],
      ),
    );
  }
}
