import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/main.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:table_calendar/table_calendar.dart';

class Hcalander extends StatefulWidget {
  final id;
  const Hcalander({super.key, this.id});

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
        "status": true,
        "user_current_date": "2025-04-25",
        "habit": {
          "id": 155,
          "name": "beating the Wife",
          "days": [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Saturday"
          ],
          "reminder_time": "10:00 AM",
          "notifications_enabled": 0,
          "habit_logs": [
            {
              "id": 56455,
              "date": "2025-04-01",
              "status": 0,
              "day_of_week": "Tuesday"
            },
            {
              "id": 56456,
              "date": "2025-04-02",
              "status": 0,
              "day_of_week": "Wednesday"
            },
            {
              "id": 56457,
              "date": "2025-04-03",
              "status": 0,
              "day_of_week": "Thursday"
            },
            {
              "id": 56458,
              "date": "2025-04-04",
              "status": null,
              "day_of_week": "Friday"
            },
            {
              "id": 56459,
              "date": "2025-04-05",
              "status": 0,
              "day_of_week": "Saturday"
            },
            {
              "id": 56460,
              "date": "2025-04-06",
              "status": 0,
              "day_of_week": "Sunday"
            },
            {
              "id": 56461,
              "date": "2025-04-07",
              "status": 0,
              "day_of_week": "Monday"
            },
            {
              "id": 56462,
              "date": "2025-04-08",
              "status": 0,
              "day_of_week": "Tuesday"
            },
            {
              "id": 56463,
              "date": "2025-04-09",
              "status": 0,
              "day_of_week": "Wednesday"
            },
            {
              "id": 56464,
              "date": "2025-04-10",
              "status": 0,
              "day_of_week": "Thursday"
            },
            {
              "id": 56465,
              "date": "2025-04-11",
              "status": null,
              "day_of_week": "Friday"
            },
            {
              "id": 56466,
              "date": "2025-04-12",
              "status": 0,
              "day_of_week": "Saturday"
            },
            {
              "id": 56467,
              "date": "2025-04-13",
              "status": 0,
              "day_of_week": "Sunday"
            },
            {
              "id": 56468,
              "date": "2025-04-14",
              "status": 0,
              "day_of_week": "Monday"
            },
            {
              "id": 56469,
              "date": "2025-04-15",
              "status": 0,
              "day_of_week": "Tuesday"
            },
            {
              "id": 56470,
              "date": "2025-04-16",
              "status": 0,
              "day_of_week": "Wednesday"
            },
            {
              "id": 56471,
              "date": "2025-04-17",
              "status": 0,
              "day_of_week": "Thursday"
            },
            {
              "id": 56472,
              "date": "2025-04-18",
              "status": null,
              "day_of_week": "Friday"
            },
            {
              "id": 56473,
              "date": "2025-04-19",
              "status": 0,
              "day_of_week": "Saturday"
            },
            {
              "id": 56474,
              "date": "2025-04-20",
              "status": 0,
              "day_of_week": "Sunday"
            },
            {
              "id": 56475,
              "date": "2025-04-21",
              "status": 0,
              "day_of_week": "Monday"
            },
            {
              "id": 56476,
              "date": "2025-04-22",
              "status": 0,
              "day_of_week": "Tuesday"
            },
            {
              "id": 56477,
              "date": "2025-04-23",
              "status": 1,
              "day_of_week": "Wednesday"
            },
            {
              "id": 56478,
              "date": "2025-04-24",
              "status": 1,
              "day_of_week": "Thursday"
            },
            {
              "id": 56479,
              "date": "2025-04-25",
              "status": null,
              "day_of_week": "Friday"
            },
            {
              "id": 56480,
              "date": "2025-04-26",
              "status": 0,
              "day_of_week": "Saturday"
            },
            {
              "id": 56481,
              "date": "2025-04-27",
              "status": 0,
              "day_of_week": "Sunday"
            },
            {
              "id": 56482,
              "date": "2025-04-28",
              "status": 0,
              "day_of_week": "Monday"
            },
            {
              "id": 56483,
              "date": "2025-04-29",
              "status": 0,
              "day_of_week": "Tuesday"
            },
            {
              "id": 56484,
              "date": "2025-04-30",
              "status": 0,
              "day_of_week": "Wednesday"
            }
          ]
        },
      };

      Map<String, dynamic> responseData = response;

      // Extract habit logs
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
    } catch (e) {
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
