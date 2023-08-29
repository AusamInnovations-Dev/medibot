import 'dart:developer';
import 'dart:math' as math;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

class NotificationService extends GetxController {
  final FlutterLocalNotificationsPlugin localNotifications = FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late InitializationSettings initSettings;
  String messagingToken = '';

  static NotificationService get to => Get.find();

  @override
  Future<void> onInit() async {
    await initPermission();
    await getToken();
    await initializeNotifications();
    super.onInit();
  }

  initPermission() async {
    NotificationSettings settings =
    await messaging.requestPermission(alert: true, sound: true, provisional: true, carPlay: true, criticalAlert: false, badge: true, announcement: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User Granted Permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User Granted Permission as on provisional');
    } else {
      log("User haven't granted permission");
    }
  }

  getToken() async {
    await messaging.getToken().then((token) {
      messagingToken = token ?? '';
      log(messagingToken);
    });
  }

  initializeNotifications() async {
    try {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
      );
      initSettings = const InitializationSettings(android: androidInitializationSettings);
      await localNotifications.initialize(initializationSettings);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log('Title: ${message.notification!.title}');
    log('Body: ${message.notification!.body}');
  }

  scheduleNotification(PillsModel pillsModel, List<DateTime> duration) async {
    log('********** Printing Duration 1 *********');
    log(duration.toString());
    if (pillsModel.isRange) {
      for (var interval in pillsModel.pillsInterval) {
        var currentDate = DateTime.parse(pillsModel.pillsDuration.first);
        log('Setting up notification now');
        log('********** Printing Duration 2 *********');
        log(currentDate.toIso8601String());
        log('********** Printing Duration 3 *********');
        log(interval);
        while (currentDate.isBefore(DateTime.parse(pillsModel.pillsDuration.last)) || currentDate.isAtSameMomentAs(DateTime.parse(pillsModel.pillsDuration.last))) {
          var isAfter = DateTime.now().isBefore(DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            int.parse(interval.substring(0, 2)),
            int.parse(interval.substring(5, 7)),
          ));
          log('$isAfter at $currentDate : $interval');
          if (isAfter) {
            log('Scheduling1');
            log('********** Printing Duration 4 *********');
            log(DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            ).toIso8601String());
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: math.Random().nextInt(100000),
                  channelKey: 'medibot_channel',
                  title: 'MediBot',
                  payload: {'pillId': pillsModel.uid, 'interval': interval},
                  body: 'Its time to take ${pillsModel.pillName} pill',
                  autoDismissible: false,
                  notificationLayout: NotificationLayout.BigText),
              actionButtons: [
                NotificationActionButton(
                  key: 'Taken',
                  label: 'Taken',
                  color: Colors.green,
                  actionType: ActionType.DismissAction,
                  showInCompactView: true,
                ),
                NotificationActionButton(
                  key: 'Missed',
                  label: 'Missed',
                  color: Colors.red,
                  actionType: ActionType.DismissAction,
                  showInCompactView: true,
                ),
              ],
              schedule: NotificationCalendar.fromDate(
                date: DateTime(
                  currentDate.year,
                  currentDate.month,
                  currentDate.day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7)),
                ),
                allowWhileIdle: true,
                preciseAlarm: true,
              ),
            );
          }
          currentDate = currentDate.add(const Duration(days: 1));
        }
      }
    } else {
      for (var individualDuration in duration) {
        for (var interval in pillsModel.pillsInterval) {
          var isAfter = DateTime.now().isBefore(
            DateTime(
              individualDuration.year,
              individualDuration.month,
              individualDuration.day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            ),
          );
          if (isAfter) {
            log('Scheduling1');
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: math.Random().nextInt(100000),
                channelKey: 'medibot_channel',
                title: 'MediBot',
                payload: {'pillId': pillsModel.uid, 'interval': interval},
                body: 'Its time to take ${pillsModel.pillName} pill',
                autoDismissible: false,
                notificationLayout: NotificationLayout.BigText,
                groupKey: pillsModel.uid,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: 'Taken',
                  label: 'Taken',
                  color: Colors.green,
                  actionType: ActionType.DismissAction,
                  showInCompactView: true,
                ),
                NotificationActionButton(
                  key: 'Missed',
                  label: 'Missed',
                  color: Colors.red,
                  actionType: ActionType.DismissAction,
                  showInCompactView: true,
                ),
              ],
              schedule: NotificationCalendar.fromDate(
                date: DateTime(
                  individualDuration.year,
                  individualDuration.month,
                  individualDuration.day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7)),
                ),
                allowWhileIdle: true,
                preciseAlarm: true,
              ),
            );
          }
        }
      }
    }
  }
}
