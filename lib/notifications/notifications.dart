// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// //https://youtu.be/rT7-p5t_35c?si=gQOS8FtomEoSEL9N  
// class NotificationService {
//   //! Initialize the instance
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   //! Handle notification responses (e.g., navigation)
//   static Future<void> onDidReceiveNotification(
//       NotificationResponse response) async {
//     if (response.payload != null) {
//       debugPrint('Payload: ${response.payload}');
//       // Handle navigation or custom logic here (e.g., open a specific screen)
//     }
//   }

//   //! Initialize the plugin
//   static Future<void> init() async {
//     tz.initializeTimeZones();
//     // Required for scheduling notifications

//     // Android initialization settings
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings("@mipmap/ic_launcher");

//     // iOS initialization settings
//     const DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings();

//     // General initialization settings
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );

//     // Initialize the plugin
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotification,
//       onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
//     );

//     // Request permission for iOS
//     if (Platform.isIOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(alert: true, badge: true, sound: true);
//     }

//     // Request permission for Android (13+ only)
//     if (Platform.isAndroid) {
//       final androidPlugin =
//           flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//       if (androidPlugin != null) {
//         await androidPlugin.requestNotificationsPermission();
//       }
//     }

//     // Create notification channel (Android only)
//     if (Platform.isAndroid) {
//       await createNotificationChannel();
//     }
//   }

//   //! Create a notification channel (Android only)
//   static Future<void> createNotificationChannel() async {
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'channel_Id',
//       'channel_Name',
//       description: 'This is the notification channel for instant notifications',
//       importance: Importance.high,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }

//   //! Show an instant notification
//   static Future<void> showInstantNotification(String title, String body) async {
//     const NotificationDetails platformSpecificPlatform = NotificationDetails(
//       android: AndroidNotificationDetails(
//         "channel_Id",
//         "channel_Name",
//         importance: Importance.high,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );

//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, platformSpecificPlatform);
//   }

//   //! Schedule a notification
//   static Future<void> scheduleInstantNotification(
//       String title, String body, DateTime scheduleDate) async {
//     if (scheduleDate.isBefore(DateTime.now())) {
//       throw ArgumentError("The scheduled date must be in the future.");
//     }

//     const NotificationDetails platformSpecificPlatform = NotificationDetails(
//       android: AndroidNotificationDetails(
//         "channel_Id",
//         "channel_Name",
//         importance: Importance.high,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
//       tz.TZDateTime.from(scheduleDate, tz.local),
//       platformSpecificPlatform,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }

//   //! Schedule a daily notification at a specific time
//   static Future<void> scheduleDailyInstantNotification(
//       {String? title,
//       String? body,
//       DateTime? scheduleDate,
//       required int daysAfter}) async {
//     if (scheduleDate!.isBefore(DateTime.now())) {
//       throw ArgumentError("The scheduled date must be in the future.");
//     }

//     const NotificationDetails platformSpecificPlatform = NotificationDetails(
//       android: AndroidNotificationDetails(
//         "channel_Id",
//         "channel_Name",
//         importance: Importance.high,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );

//     // Correct function to get the next instance of the given time
//     tz.TZDateTime _nextInstanceOfTime(int hour, int minute, int daysAfter) {
//       final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//       tz.TZDateTime scheduledDate = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month,
//         now.day,
//         hour,
//         minute,
//       );

//       // If the time has already passed today, schedule it for tomorrow
//       if (scheduledDate.isBefore(now)) {
//         scheduledDate = scheduledDate.add(Duration(days: daysAfter));
//       }
//       debugPrint(" this is the preveos alarm  $scheduledDate");
//       return scheduledDate;
//     }

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
//       _nextInstanceOfTime(scheduleDate.hour, scheduleDate.minute, daysAfter),
//       platformSpecificPlatform,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents: DateTimeComponents.time,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }