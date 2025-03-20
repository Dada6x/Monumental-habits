import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final NotificationsService _instance = NotificationsService._internal();

  factory NotificationsService() => _instance;

  NotificationsService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  //! initialize
  Future<void> initNotification() async {
    // Prevent re-initialization
    if (_isInitialized) return;

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initSettings =
        InitializationSettings(android: initSettingsAndroid);

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  //! notification detail setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id', 
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  //! show notifications
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
  }
}
