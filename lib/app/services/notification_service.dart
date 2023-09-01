import 'dart:developer';
import 'dart:math' as math;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

import '../models/history_model/history_model.dart';
import 'firestore.dart';

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
                  id: DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                    int.parse(interval.substring(0, 2)),
                    int.parse(interval.substring(5, 7)),
                  ).hashCode,
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
                  actionType: ActionType.Default,
                  showInCompactView: true,
                ),
                NotificationActionButton(
                  key: 'Missed',
                  label: 'Missed',
                  color: Colors.red,
                  actionType: ActionType.Default,
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
                id: DateTime(
                  individualDuration.year,
                  individualDuration.month,
                  individualDuration.day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7)),
                ).hashCode,
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
                  actionType: ActionType.Default,
                  showInCompactView: true,
                ),
                NotificationActionButton(
                  key: 'Missed',
                  label: 'Missed',
                  color: Colors.red,
                  actionType: ActionType.Default,
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

  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    var data = await FirebaseFireStore.to.getPillReminder(receivedAction.payload!['pillId']!);
    PillsModel pill = PillsModel.fromJson(data.docs.first.data());
    var pillInterval = receivedAction.payload!['interval']?? '';
    if(pillInterval != ''){
      String docId = "${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";
      var dayHistory = await FirebaseFireStore.to.getHistoryDataByDay(docId);
      if (dayHistory != null) {
        HistoryModel historyModel = HistoryModel.fromJson(dayHistory.data() as Map<String, dynamic>);
        late HistoryData historyData;
        int? index;
        for (var pills in historyModel.historyData) {
          if (pills.pillId == pill.uid) {
            historyData = pills;
            index = historyModel.historyData.indexOf(pills);
            break;
          }
        }
        if (index == null) {
          List<HistoryData> list = [];
          list.addAll(historyModel.historyData);
          List<String> timeTaken = [];
          List<String> status = [];
          for(int i=0; i<pill.pillsInterval.indexOf(pillInterval); i++){
            timeTaken.add('00HH:00MM');
            status.add('M');
          }
          timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
          status.add('M');

          list.add(
            HistoryData(
              pillId: pill.uid,
              timeToTake: pill.pillsInterval,
              timeTaken: timeTaken,
              med_status: status,
            ),
          );
          historyModel = historyModel.copyWith(historyData: list);
          await FirebaseFireStore.to.uploadHistoryData(
            historyModel,
            docId,
          );
        } else {
          if (historyData.timeTaken.length < historyData.timeToTake.length) {
            HistoryData historyDataTemp = historyData;
            List<String> tempTimeTaken = [];
            List<HistoryData> list = [];
            List<String> tempStatus = [];
            tempStatus.addAll(historyDataTemp.med_status);
            list.addAll(historyModel.historyData);
            tempTimeTaken.addAll(historyDataTemp.timeTaken);
            for(int i=tempTimeTaken.length; i<pill.pillsInterval.indexOf(pillInterval); i++){
              tempTimeTaken.add('00HH:00MM');
              tempStatus.add('M');
            }
            tempTimeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
            tempStatus.add('M');
            list[index] = HistoryData(
              pillId: historyModel.historyData[index].pillId,
              timeTaken: tempTimeTaken,
              med_status: tempStatus,
              timeToTake: historyModel.historyData[index].timeToTake,
            );
            HistoryModel tempHistory = HistoryModel(
              userId: historyModel.userId,
              historyData: list,
            );
            await FirebaseFireStore.to.uploadHistoryData(
              tempHistory,
              docId,
            );
          }
        }
      } else {
        List<String> timeTaken = [];
        List<String> status = [];
        for(int i=0; i<pill.pillsInterval.indexOf(pillInterval); i++){
          timeTaken.add('00HH:00MM');
          status.add('M');
        }
        timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
        status.add('M');
        HistoryModel historyModel = HistoryModel(userId: docId, historyData: [
          HistoryData(
            pillId: pill.uid,
            timeToTake: pill.pillsInterval,
            timeTaken: timeTaken,
            med_status: status,
          ),
        ]);
        await FirebaseFireStore.to.uploadHistoryData(
          historyModel,
          docId,
        );
      }
    }
  }

  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    log('Message sent via notification input 1 : "${receivedAction.buttonKeyPressed}"');
    if(receivedAction.buttonKeyPressed == 'Taken'){
      log('Marking as taken');
      var data = await FirebaseFireStore.to.getPillReminder(receivedAction.payload!['pillId']!);
      PillsModel pill = PillsModel.fromJson(data.docs.first.data());
      var pillInterval = receivedAction.payload!['interval']?? '';
      var hours = int.parse(receivedAction.payload!['interval']!.substring(0, 2));
      var minutes = int.parse(receivedAction.payload!['interval']!.substring(5, 7));
      if(pillInterval != ''){
        String docId = "${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";
        var dayHistory = await FirebaseFireStore.to.getHistoryDataByDay(docId);
        if (dayHistory != null) {
          HistoryModel historyModel = HistoryModel.fromJson(dayHistory.data() as Map<String, dynamic>);
          late HistoryData historyData;
          int? index;
          for (var pills in historyModel.historyData) {
            if (pills.pillId == pill.uid) {
              historyData = pills;
              index = historyModel.historyData.indexOf(pills);
              break;
            }
          }
          if (index == null) {
            List<HistoryData> list = [];
            list.addAll(historyModel.historyData);
            List<String> timeTaken = [];
            List<String> status = [];
            for(int i=0; i<pill.pillsInterval.indexOf(pillInterval); i++){
              timeTaken.add('00HH:00MM');
              status.add('M');
            }
            timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
            status.add(DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes < 60 ? 'Y' : 'L');

            list.add(
              HistoryData(
                pillId: pill.uid,
                timeToTake: pill.pillsInterval,
                timeTaken: timeTaken,
                med_status: status,
              ),
            );
            historyModel = historyModel.copyWith(historyData: list);
            await FirebaseFireStore.to.uploadHistoryData(
              historyModel,
              docId,
            );
          } else {
            if (historyData.timeTaken.length < historyData.timeToTake.length) {
              HistoryData historyDataTemp = historyData;
              List<String> tempTimeTaken = [];
              List<HistoryData> list = [];
              List<String> tempStatus = [];
              tempStatus.addAll(historyDataTemp.med_status);
              list.addAll(historyModel.historyData);
              tempTimeTaken.addAll(historyDataTemp.timeTaken);
              for(int i=tempTimeTaken.length; i<pill.pillsInterval.indexOf(pillInterval); i++){
                tempTimeTaken.add('00HH:00MM');
                tempStatus.add('M');
              }
              tempTimeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
              tempStatus.add(DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes < 60 ? 'Y' : 'L',);
              list[index] = HistoryData(
                pillId: historyModel.historyData[index].pillId,
                timeTaken: tempTimeTaken,
                med_status: tempStatus,
                timeToTake: historyModel.historyData[index].timeToTake,
              );
              HistoryModel tempHistory = HistoryModel(
                userId: historyModel.userId,
                historyData: list,
              );
              await FirebaseFireStore.to.uploadHistoryData(
                tempHistory,
                docId,
              );
            }
          }
        } else {
          List<String> timeTaken = [];
          List<String> status = [];
          for(int i=0; i<pill.pillsInterval.indexOf(pillInterval); i++){
            timeTaken.add('00HH:00MM');
            status.add('M');
          }
          timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
          status.add(DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes < 60 ? 'Y' : 'L');
          HistoryModel historyModel = HistoryModel(userId: docId, historyData: [
            HistoryData(
              pillId: pill.uid,
              timeToTake: pill.pillsInterval,
              timeTaken: timeTaken,
              med_status: status,
            ),
          ]);
          await FirebaseFireStore.to.uploadHistoryData(
            historyModel,
            docId,
          );
          await FirebaseFireStore.to.decreaseQuantity(pill.uid, int.parse(pill.pillsQuantity)-1);
        }
      }
    }else if(receivedAction.buttonKeyPressed == 'Missed'){
      log('Marking as Messed');
      var data = await FirebaseFireStore.to.getPillReminder(receivedAction.payload!['pillId']!);
      PillsModel pill = PillsModel.fromJson(data.docs.first.data());
      var pillInterval = receivedAction.payload!['interval']?? '';
      if(pillInterval != ''){
        String docId = "${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";
        var dayHistory = await FirebaseFireStore.to.getHistoryDataByDay(docId);
        if (dayHistory != null) {
          HistoryModel historyModel = HistoryModel.fromJson(dayHistory.data() as Map<String, dynamic>);
          late HistoryData historyData;
          int? index;
          for (var pills in historyModel.historyData) {
            if (pills.pillId == pill.uid) {
              historyData = pills;
              index = historyModel.historyData.indexOf(pills);
              break;
            }
          }
          if (index == null) {
            List<HistoryData> list = [];
            list.addAll(historyModel.historyData);
            List<String> timeTaken = [];
            List<String> status = [];
            for(int i=0; i<pill.pillsInterval.indexOf(pillInterval); i++){
              timeTaken.add('00HH:00MM');
              status.add('M');
            }
            timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
            status.add('M');

            list.add(
              HistoryData(
                pillId: pill.uid,
                timeToTake: pill.pillsInterval,
                timeTaken: timeTaken,
                med_status: status,
              ),
            );
            historyModel = historyModel.copyWith(historyData: list);
            await FirebaseFireStore.to.uploadHistoryData(
              historyModel,
              docId,
            );
          } else {
            if (historyData.timeTaken.length < historyData.timeToTake.length) {
              HistoryData historyDataTemp = historyData;
              List<String> tempTimeTaken = [];
              List<HistoryData> list = [];
              List<String> tempStatus = [];
              tempStatus.addAll(historyDataTemp.med_status);
              list.addAll(historyModel.historyData);
              tempTimeTaken.addAll(historyDataTemp.timeTaken);
              for(int i=tempTimeTaken.length; i<pill.pillsInterval.indexOf(pillInterval); i++){
                tempTimeTaken.add('00HH:00MM');
                tempStatus.add('M');
              }
              tempTimeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
              tempStatus.add('M');
              list[index] = HistoryData(
                pillId: historyModel.historyData[index].pillId,
                timeTaken: tempTimeTaken,
                med_status: tempStatus,
                timeToTake: historyModel.historyData[index].timeToTake,
              );
              HistoryModel tempHistory = HistoryModel(
                userId: historyModel.userId,
                historyData: list,
              );
              await FirebaseFireStore.to.uploadHistoryData(
                tempHistory,
                docId,
              );
            }
          }
        } else {
          List<String> timeTaken = [];
          List<String> status = [];
          for(int i=0; i<pill.pillsInterval.indexOf(pillInterval); i++){
            timeTaken.add('00HH:00MM');
            status.add('M');
          }
          timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
          status.add('M');
          HistoryModel historyModel = HistoryModel(userId: docId, historyData: [
            HistoryData(
              pillId: pill.uid,
              timeToTake: pill.pillsInterval,
              timeTaken: timeTaken,
              med_status: status,
            ),
          ]);
          await FirebaseFireStore.to.uploadHistoryData(
            historyModel,
            docId,
          );
        }
      }
    }
  }
}
