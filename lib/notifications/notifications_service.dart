import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

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

    // Initialize Time Zones
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // Android Initialization
    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initSettings =
        InitializationSettings(android: initSettingsAndroid);

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  //! Notification Details Setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id', // Unique Channel ID
        'Daily Notifications',
        channelDescription:
            'This channel handles daily scheduled notifications.',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        ongoing: false, // Not sticky
        autoCancel: true, // Removes after tapping
        visibility: NotificationVisibility.public, // Shows on lock screen
      ),
    );
  }

  //! Show Instant Notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
  }

  //! Schedule Notifications at a Specific Time
  Future<void> scheduledNotifications({
    required int id, // Unique ID for each notification
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // If the scheduled time has passed today, schedule it for the next day
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await notificationsPlugin.zonedSchedule(
      id, // Unique ID
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode
          .exactAllowWhileIdle, // Ensures it fires in background
      matchDateTimeComponents:
          DateTimeComponents.time, // Repeat daily at the same time
      // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("Scheduled notification set for $scheduledDate with ID: $id");
  }

  //! Cancel All Notifications
  Future<void> cancelNotification() async {
    await notificationsPlugin.cancelAll();
  }

  void habitScheduleNotification(
      {required String timeString, required String HabitName}) {
    DateTime dateTime = DateFormat("hh:mm a").parse(timeString);

    int hour = int.parse(DateFormat("HH").format(dateTime));
    int minute = int.parse(DateFormat("mm").format(dateTime));

    NotificationsService().scheduledNotifications(
      id: 99,
      //! Not unique yet
      hour: hour,
      minute: minute,
      title: HabitName,
      body: "Your scheduled  to Do $HabitName  at $timeString!",
    );

    debugPrint("Notification set for  $hour:$minute ✅✅");
  }



//  // Schedule notification using UUID-based hash code
//   Future<void> scheduledNotifications({
//     required int id, // Using habit.id.hashCode
//     required int hour,
//     required int minute,
//     required String title,
//     required String body,
//   }) async {
//     var scheduledTime = Time(hour, minute, 0);

//     await notificationsPlugin.zonedSchedule(
//       id, // Unique notification ID
//       title,
//       body,
//       scheduledTime,
//       NotificationDetails(...),
//       androidAllowWhileIdle: true,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   // Cancel notification
//   Future<void> cancelNotification(int id) async {
//     await notificationsPlugin.cancel(id);
//   }




}
