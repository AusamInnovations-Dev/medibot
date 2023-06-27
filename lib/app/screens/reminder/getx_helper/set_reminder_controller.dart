import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';
import 'package:medibot/app/services/notification_service.dart';
import 'package:medibot/app/services/user.dart';

import '../../../services/firestore.dart';


class SetReminderController extends GetxController {
  TextEditingController pillName = TextEditingController();
  String dosage = 'Select Dosage';
  Rx<String> interval = 'Select Interval'.obs;
  List<TimeOfDay> pillsTime = [
    const TimeOfDay(
      hour: 12,
      minute: 20,
    )
  ];
  Rx<int> pillQuantity = 1.obs;
  Rx<bool> isRange = false.obs;
  Rx<bool> isIndividual = false.obs;
  RxList<Map<String, Object>> timeIntervals = <Map<String, Object>>[
    {'hour': '12 H', 'minute': '20 M', 'period': 'PM'}
  ].obs;

  RxList<DateTime> durationDates = <DateTime>[].obs;

  selectingTimeIntervals() {
    pillsTime.clear();
    timeIntervals.clear();
    if (interval.value == 'Once a Day') {
      pillsTime.add(const TimeOfDay(
        hour: 12,
        minute: 20,
      ));
      generateTimeInterval();
    } else if (interval.value == 'Twice a Day') {
      pillsTime.add(const TimeOfDay(
        hour: 8,
        minute: 30,
      ));
      pillsTime.add(const TimeOfDay(
        hour: 8,
        minute: 30,
      ));
      generateTimeInterval();
    } else if (interval.value == 'Thrice a Day') {
      pillsTime.add(const TimeOfDay(
        hour: 8,
        minute: 30,
      ));
      pillsTime.add(const TimeOfDay(
        hour: 2,
        minute: 30,
      ));
      pillsTime.add(const TimeOfDay(
        hour: 8,
        minute: 30,
      ));
      generateTimeInterval();
    }
  }

  generateTimeInterval() {
    for (int i = 0; i < pillsTime.length; i++) {
      timeIntervals.add({
        'hour':
            '${pillsTime[i].hour <= 9 ? '0${pillsTime[i].hour}' : pillsTime[i].hour} H',
        'minute':
            '${pillsTime[i].minute <= 9 ? '0${pillsTime[i].minute}' : pillsTime[i].minute} M',
        'period': i == 0 ? 'AM' : 'PM'
      });
    }
    log(timeIntervals.toString());
  }

  gererateCustomTimeInterval() {
    timeIntervals.clear();
    pillsTime.add(const TimeOfDay(
      hour: 8,
      minute: 30,
    ));
    timeIntervals.add({
      'hour':
          '${pillsTime[0].hour <= 9 ? '0${pillsTime[0].hour}' : pillsTime[0].hour} H',
      'minute':
          '${pillsTime[0].minute <= 9 ? '0${pillsTime[0].minute}' : pillsTime[0].minute} M',
      'period': 'PM'
    });
  }

  addCustomTimeInterval() {
    pillsTime.add(const TimeOfDay(
      hour: 8,
      minute: 30,
    ));
    timeIntervals.add({
      'hour':
          '${pillsTime.last.hour <= 9 ? '0${pillsTime.last.hour}' : pillsTime.last.hour} H',
      'minute':
          '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
      'period': 'PM'
    });
  }

  removeCustomTimeInterval(index) {
    timeIntervals.removeAt(index);
    pillsTime.removeAt(index);
  }

  Future<String> uploadPillsReminderData() async {
    List<String> intervalsInString = [];
    switch (timeIntervals.length) {
      case 1:
        intervalsInString.add('00HH:00MM');
        var hour = timeIntervals[0]['hour'] as String;
        var minute = timeIntervals[0]['minute'] as String;
        intervalsInString.add(
            '${timeIntervals.first['period'] == 'AM' ? (hour.substring(0,2)) : int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM');
        intervalsInString.add('00HH:00MM');
        intervalsInString.add('00HH:00MM');
        break;

      case 2:
        intervalsInString.add('00HH:00MM');
        var hour = timeIntervals[0]['hour'] as String;
        var minute = timeIntervals[0]['minute'] as String;
        intervalsInString.add(
            '${timeIntervals[0]['period'] == 'AM' ? (hour.substring(0,2)) : int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM');

        intervalsInString.add('00HH:00MM');
        hour = timeIntervals[1]['hour'] as String;
        minute = timeIntervals[1]['minute'] as String;
        intervalsInString.add(
            '${timeIntervals[1]['period'] == 'AM' ? (hour.substring(0,2)) : int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM');
        break;

      case 3:
        var hour = timeIntervals[0]['hour'] as String;
        var minute = timeIntervals[0]['minute'] as String;
        intervalsInString.add(
            '${timeIntervals[0]['period'] == 'AM' ? (hour.substring(0,2)) : int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM');
        hour = timeIntervals[1]['hour'] as String;
        minute = timeIntervals[1]['minute'] as String;
        intervalsInString.add(
            '${timeIntervals[1]['period'] == 'AM' ? (hour.substring(0,2)) : int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM');
        intervalsInString.add('00HH:00MM');
        hour = timeIntervals[2]['hour'] as String;
        minute = timeIntervals[2]['minute'] as String;
        intervalsInString.add(
            '${timeIntervals[2]['period'] == 'AM' ? (hour.substring(0,2)) : int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM');
        break;
    }
    try {
      
      log(PillsModel(
        uid: '',
        slot: 0,
        request: 1,
        pillName: pillName.text,
        dosage: dosage,
        interval: interval.value,
        isIndividual: isIndividual.value,
        isRange: isRange.value,
        pillsQuantity: pillQuantity.value.toString(),
        pillsInterval: intervalsInString,
        pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
        inCabinet: false,
        userId: UserStore.to.uid,
      ).toJson().toString());


     var isUploaded = await FirebaseFireStore.to.uploadPillsReminderData(
      PillsModel(
        uid: '',
        pillName: pillName.text,
        userId: UserStore.to.uid,
        dosage: dosage,
        interval: interval.value,
        isIndividual: isIndividual.value,
        isRange: isRange.value,
        pillsQuantity: pillQuantity.value.toString(),
        pillsInterval: intervalsInString,
        inCabinet: false,
        pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
        request: 1,
        slot: 0,
      ),
    );
     await NotificationService.to.scheduleNotification(
       1,
       PillsModel(
         userId: UserStore.to.uid,
         uid: isUploaded,
         pillName: pillName.text,
         dosage: dosage,
         interval: interval.value,
         isIndividual: isIndividual.value,
         isRange: isRange.value,
         pillsQuantity: pillQuantity.value.toString(),
         pillsInterval: intervalsInString,
         inCabinet: false,
         pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
         request: 1,
         slot: 0,
       ),
       durationDates
     );
    return isUploaded;
    } catch (err) {
      log(err.toString());
      return '';
    }

  }
}
