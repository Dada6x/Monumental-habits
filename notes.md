# notes

- column padding in wards work instead of each element padding + should be in width mediaquery \* value
- make verification page as function(destination) coz i want to use it in multiple areas
- fix all textfields and its controllers in the app [login-signup-ver cod-forgetpassword-newpassword]
  when floating action button is pressed it should take you to dashboard and then do the ADD HABIT

dash boards is landpage (your progress and stuf) and make newHabit

map still yet

community oh gosh

settings damn

imagepicker ⟶ middlewares ⟶ homepageappbar titel ⟶ DAshBoard of weeks
⟶ Habit edit and so on

> > MOVING PICTURE IN THE HOMEPAGE

# needs just fixing the images to be beautiful

# also the first time app running the first swipe goes black until the image is loaded

but chatgpt said it wont affect the performance that much
but i dont think it useful coz the widget wont be visible


# in the widget you want to back from

    Get.back(result: formattedTime);

# in the widget you wanna back into with [result]


# HOW THE HABIT SHIT WORKS

dashboard ⟶ displaying the habit table
habit info ⟶ displaying the habit details,calender , analytics
habit table ⟶ displaying the habit name and days of repeat
new Habit ⟶ entering new habit to
reminder ⟶ adding reminder
habit controller

whats left
the notifications , storing the notifications in the device
fixing the edit Habit,
the Button for each Day of each habit 


# THE CALANDER THAT DOSENT SHOW THE UNSELECTED DAYS

# but theres proplem so i need to see the abdo's response

# if it 1,2,3,4,5,8,7,9,, ..... then this code is not suitable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:monumental_habits/util/helper.dart';
import 'package:monumental_habits/util/sizedconfig.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitCalendar extends StatefulWidget {
final Map<String, bool> selectedDays; // Accept the selectedDays map

HabitCalendar({
super.key,
required this.selectedDays, // Required parameter for selectedDays
});

@override
\_HabitCalendarState createState() => \_HabitCalendarState();
}

class \_HabitCalendarState extends State<HabitCalendar> {
DateTime \_selectedMonth = DateTime.now();

@override
void initState() {
super.initState();
}

void \_changeMonth(int offset) {
setState(() {
\_selectedMonth =
DateTime(\_selectedMonth.year, \_selectedMonth.month + offset, 1);
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
DateFormat.yMMMM().format(_selectedMonth),
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
const SizedBox(height: 8),
//! Calendar UI
Expanded(
child: TableCalendar(
firstDay: DateTime(2000, 1, 1),
lastDay: DateTime(2100, 12, 31),
focusedDay: \_selectedMonth,
calendarFormat: CalendarFormat.month,
headerVisible: false,
calendarBuilders: CalendarBuilders(
//! TODAY ##################
todayBuilder: (context, day, focusedDay) {
String dayOfWeek = DateFormat('E').format(day).toLowerCase();
bool isActive = widget.selectedDays[dayOfWeek] ?? false;
int currentDay = DateTime.now().day;
if (!isActive) {
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
const SizedBox(height: 9),
],
),
),
);
}
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
const SizedBox(height: 9),
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

                //! THE REST OF DAYS   ##################
              }, defaultBuilder: (context, date, _) {
                int day = date.day;
                String dayOfWeek = DateFormat('E').format(date).toLowerCase();
                bool isActive = widget.selectedDays[dayOfWeek] ?? false;
                if (!isActive) {
                  return Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
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
                        ],
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    width: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
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
              }),
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
![alt text](image.png)




sche noti 
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationsService {
  static final NotificationsService _instance =
      NotificationsService._internal();

  factory NotificationsService() => _instance;

  NotificationsService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  //! Initialize Notifications
  Future<void> initNotification() async {
    if (_isInitialized) return;

    //@ Init timezone handling
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initSettings =
        InitializationSettings(android: initSettingsAndroid);

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  //! Notification Details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );
  }

  //! Show Immediate Notification
  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
  }

  //! Schedule Notification
  Future<void> scheduledNotifications({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // If the scheduled time is in the past, schedule it for the next day
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    print("Scheduled notification set for $scheduledDate");
  }

  //! Cancel All Notifications
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}

