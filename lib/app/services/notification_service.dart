import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationService extends GetxController {

  final FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();

  @override
  Future<void> onInit () async {
    await initializeNotifications();
    super.onInit();
  }

  initializeNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await localNotifications.initialize(initializationSettings);
  }

  scheduleNotification(int id, String title, String body, PillsModel pillsModel) async {
    await localNotifications.zonedSchedule(
      id,
      'MediBot',
      'Its time to take ${pillsModel.pillName} pill',
      tz.TZDateTime.from(DateTime.now(), tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          pillsModel.uid,
          pillsModel.pillName,
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/ic_launcher',
          category: AndroidNotificationCategory.reminder,
          actions: [

          ],
          autoCancel: false,
          enableVibration: true,
          visibility: NotificationVisibility.public
        )
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
    );
  }

}