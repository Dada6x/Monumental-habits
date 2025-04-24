import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:table_calendar/table_calendar.dart';

class Hcalander extends StatefulWidget {
  const Hcalander({super.key});

  @override
  _HabitCalendarState createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<Hcalander> {
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
      final response = {
        "habit_logs": [
          {"date": "2025-04-01", "status": null},
          {"date": "2025-04-02", "status": null},
          {"date": "2025-04-03", "status": null},
          {"date": "2025-04-04", "status": null},
          {"date": "2025-04-05", "status": null},
          {"date": "2025-04-06", "status": 0},
          {"date": "2025-04-07", "status": 0},
          {"date": "2025-04-08", "status": null},
          {"date": "2025-04-09", "status": null},
          {"date": "2025-04-10", "status": null},
          {"date": "2025-04-11", "status": null},
          {"date": "2025-04-12", "status": null},
          {"date": "2025-04-13", "status": 0},
          {"date": "2025-04-14", "status": 1},
          {"date": "2025-04-15", "status": null},
          {"date": "2025-04-16", "status": null},
          {"date": "2025-04-17", "status": null},
          {"date": "2025-04-18", "status": null},
          {"date": "2025-04-19", "status": null},
          {"date": "2025-04-20", "status": 0},
          {"date": "2025-04-21", "status": 1},
          {"date": "2025-04-22", "status": null},
          {"date": "2025-04-23", "status": null},
          {"date": "2025-04-24", "status": 1},
          {"date": "2025-04-25", "status": 0},
          {"date": "2025-04-26", "status": 0},
          {"date": "2025-04-27", "status": 0},
          {"date": "2025-04-28", "status": 1},
          {"date": "2025-04-29", "status": 0},
          {"date": "2025-04-30", "status": null},
        ]
      };

      // Parse habit logs and update habitStatus
      Map<int, int?> statusMap = {};
      final habitLogs = response['habit_logs'];

      if (habitLogs != null) {
        for (var log in habitLogs) {
          final date = DateTime.parse(log['date'] as String); // Corrected type
          final status = log['status'] != null ? log['status'] as int? : null;
          statusMap[date.day] = status;
        }
      }

      setState(() {
        habitStatus = statusMap;
      });
    } catch (e) {
      // Handle any unexpected errors here
      print('Error fetching data: $e');
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
    setState(() {
      _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month + offset, 1);
      _generateHabitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          const EdgeInsets.all(8.0), // Increased padding for responsiveness
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

                // Set the text color for today
                TextStyle dayTextStyle = TextStyle(
                  fontWeight: FontWeight.bold,
                  color: (dayNumber == currentDay)
                      ? (Get.isDarkMode
                          ? altPurple
                          : const Color(orange)) // Highlight for today
                      : Theme.of(context)
                          .colorScheme
                          .scrim, // Default color for other days
                );

                Color containerColor =
                    Colors.transparent; // Default color for habit status

                if (habitStatus.containsKey(dayNumber)) {
                  int? status = habitStatus[dayNumber];
                  // Set color based on habit status
                  if (status == 1) {
                    containerColor = Get.isDarkMode
                        ? altPurple
                        : const Color(darkOrange); // Green for completed
                  } else if (status == 0) {
                    containerColor = Theme.of(context)
                        .colorScheme
                        .onTertiary; // Red for not completed
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
