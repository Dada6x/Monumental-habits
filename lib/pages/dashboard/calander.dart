import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitCalendar extends StatefulWidget {
  const HabitCalendar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitCalendarState createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  DateTime _selectedMonth = DateTime.now();
  Map<int, int> habitStatus = {};

  @override
  void initState() {
    super.initState();
    _generateHabitData();
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
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          //! Month Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                      size: 18,
                      Icons.arrow_back_ios_new_outlined,
                      color: Theme.of(context).colorScheme.scrim),
                  onPressed: () => _changeMonth(-1)),
              Text(
                DateFormat.yMMMM()
                    .format(_selectedMonth), // Format: "September 2024"
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.scrim),
              ),
              IconButton(
                  icon: Icon(
                      size: 18,
                      Icons.arrow_forward_ios_outlined,
                      color: Theme.of(context).colorScheme.scrim),
                  onPressed: () => _changeMonth(1)),
            ],
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
                  return Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: 42,
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
                                    : const Color(orange)),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Container(
                            width: 33,
                            height: 33,
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
                //! defaultBuilder ##########################
                defaultBuilder: (context, date, _) {
                  int day = date.day;
                  if (habitStatus.containsKey(day)) {
                    return Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Container(
                        width: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
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
                            const SizedBox(
                              height: 9,
                            ),
                            //! IF DONE AND undone
                            Container(
                              width: 33,
                              height: 33,
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
                  }
                  return const SizedBox();
                },
              ),
              daysOfWeekVisible: true,
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: manropeGrey, weekendStyle: manropeGrey),
              rowHeight: SizeConfig.screenHeight * 0.088,
              daysOfWeekHeight: 30,
              calendarStyle: const CalendarStyle(
                  cellPadding: EdgeInsets.all(2), isTodayHighlighted: true),
              availableGestures: AvailableGestures.none,
            ),
          ),
        ],
      ),
    );
  }
}
