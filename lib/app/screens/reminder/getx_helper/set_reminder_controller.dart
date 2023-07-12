import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';
import 'package:medibot/app/services/notification_service.dart';
import 'package:medibot/app/services/user.dart';

import '../../../services/firestore.dart';


class SetReminderController extends GetxController {
  TextEditingController pillName = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  String dosage = 'Select Dosage';
  String medicineCategory = 'Select Category';
  Rx<String> interval = 'Once a Day'.obs;
  Rx<String> hourlyInterval = '01 H'.obs;
  List<TimeOfDay> pillsTime = [
    const TimeOfDay(
      hour: 08,
      minute: 00,
    )
  ];
  Rx<int> pillQuantity = 1.obs;
  Rx<bool> isRange = false.obs;
  Rx<bool> isIndividual = false.obs;
  Rx<bool> increasePossible = true.obs;
  RxList<Map<String, Object>> timeIntervals = <Map<String, Object>>[
    {'hour': '08 H', 'minute': '00 M', 'period': 'PM'}
  ].obs;

  RxList<DateTime> durationDates = <DateTime>[].obs;

  var selectingInterval = false.obs;

  selectingTimeIntervals() {
    selectingInterval.value = true;
    if (interval.value == 'Once a Day') {
      if(pillsTime.length > 1){
        pillsTime.removeRange(1, pillsTime.length);
        timeIntervals.removeRange(1, timeIntervals.length);
      }
      log(timeIntervals.toString());
    } else if (interval.value == 'Twice a Day') {
      if(pillsTime.length > 2){
        pillsTime.removeRange(2, pillsTime.length);
        timeIntervals.removeRange(2, pillsTime.length);
      }else if(pillsTime.length == 1){
        pillsTime.add(const TimeOfDay(
          hour: 8,
          minute: 00,
        ));
        timeIntervals.add({
          'hour':
          '${pillsTime.last.hour <= 9 ? '0${pillsTime.last.hour}' : pillsTime.last.hour} H',
          'minute':
          '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
          'period': pillsTime.isEmpty ? 'AM' : 'PM'
        });
      }
      log(timeIntervals.toString());
    } else if (interval.value == 'Thrice a Day') {
      if(pillsTime.length > 3){
        pillsTime.removeRange(3, pillsTime.length);
        timeIntervals.removeRange(3, pillsTime.length);
      }else if (pillsTime.length == 1){
        log('Hello');
        pillsTime.add(const TimeOfDay(
          hour: 2,
          minute: 00,
        ));
        pillsTime.add(const TimeOfDay(
          hour: 8,
          minute: 00,
        ));
        timeIntervals.add({
          'hour':
          '${pillsTime[1].hour <= 9 ? '0${pillsTime[1].hour}' : pillsTime[1].hour} H',
          'minute':
          '${pillsTime[1].minute <= 9 ? '0${pillsTime[1].minute}' : pillsTime[1].minute} M',
          'period': 'PM'
        });
        timeIntervals.add({
          'hour':
          '${pillsTime[2].hour <= 9 ? '0${pillsTime[2].hour}' : pillsTime[2].hour} H',
          'minute':
          '${pillsTime[2].minute <= 9 ? '0${pillsTime[2].minute}' : pillsTime[2].minute} M',
          'period': 'PM'
        });
      }else if (pillsTime.length == 2) {
        pillsTime.add(const TimeOfDay(
          hour: 8,
          minute: 00,
        ));
        timeIntervals.add({
          'hour':
          '${pillsTime[1].hour <= 9 ? '0${pillsTime[1].hour}' : pillsTime[1].hour} H',
          'minute':
          '${pillsTime[1].minute <= 9 ? '0${pillsTime[1].minute}' : pillsTime[1].minute} M',
          'period': 'PM'
        });
      }
      log(timeIntervals.toString());
    }
  }


  gererateCustomTimeInterval() {
    timeIntervals.clear();
    pillsTime.clear();
    log('Hello : $timeIntervals');
    pillsTime.add(const TimeOfDay(
      hour: 8,
      minute: 00,
    ));
    timeIntervals.add({
      'hour': '${pillsTime.last.hour <= 9 ? '0${pillsTime.last.hour}' : pillsTime.last.hour > 12 ? pillsTime.last.hour-12 : pillsTime.last.hour } H',
      'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
      'period': 'AM'
    });
  }

  addCustomTimeInterval() {
    pillsTime.add(const TimeOfDay(
      hour: 8,
      minute: 00,
    ));
    timeIntervals.add({
      'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
      'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
      'period': pillsTime.last.hour >= 12 ? 'PM' : 'AM'
    });
  }

  addHourlyTimeInterval() {
    log('Here Printing');
    switch(hourlyInterval.value) {
      case '01 H':
        pillsTime.add(TimeOfDay(
          hour: pillsTime.last.hour+1,
          minute: 00,
        ));
        timeIntervals.add({
          'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour-12}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
          'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
          'period': pillsTime.last.hour >= 12 ? 'PM' : 'AM'
        });
        if(pillsTime.last.hour+1 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '02 H':
        pillsTime.add(TimeOfDay(
          hour: pillsTime.last.hour+2,
          minute: 00,
        ));
        timeIntervals.add({
          'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour-12}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
          'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
          'period': pillsTime.last.hour >= 12 ? 'PM' : 'AM'
        });
        if(pillsTime.last.hour+2 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '03 H':
        log(hourlyInterval.value);
        pillsTime.add(TimeOfDay(
          hour: pillsTime.last.hour+3,
          minute: 00,
        ));
        timeIntervals.add({
          'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour-12}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
          'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
          'period': pillsTime.last.hour >= 12 ? 'PM' : 'AM'
        });
        if(pillsTime.last.hour+3 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '04 H':
        log(hourlyInterval.value);
        pillsTime.add(TimeOfDay(
          hour: pillsTime.last.hour+4,
          minute: 00,
        ));
        timeIntervals.add({
          'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour-12}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
          'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
          'period': pillsTime.last.hour >= 12 ? 'PM' : 'AM'
        });
        if(pillsTime.last.hour+4 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '06 H':
        log(hourlyInterval.value);
        pillsTime.add(TimeOfDay(
          hour: pillsTime.last.hour+6,
          minute: 00,
        ));
        log('This is adding data : ${pillsTime.last.hour}');
        timeIntervals.add({
          'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour-12}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
          'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
          'period': pillsTime.last.hour >= 12 ? 'PM' : 'AM'
        });
        if(pillsTime.last.hour+6 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;
    }
  }

  removeCustomTimeInterval(index) {
    timeIntervals.removeAt(index);
    pillsTime.removeAt(index);
  }

  removeHourlyTimeInterval(index) {
    timeIntervals.removeAt(index);
    pillsTime.removeAt(index);
    checkIfIncreasePossible();
  }

  Future<String> uploadPillsReminderData() async {
    List<String> intervalsInString = [];
    for(var interval in timeIntervals){
      var hour = interval['hour'] as String;
      var minute = interval['minute'] as String;
      intervalsInString.add(
          '${interval['period'] == 'AM' ? hour.substring(0,2) : int.parse(hour.substring(0,2)) == 12 ? hour.substring(0,2) :  int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM'
      );
    }

    try {
     var isUploaded = await FirebaseFireStore.to.uploadPillsReminderData(
      PillsModel(
        uid: '',
        pillName: pillName.text,
        userId: UserStore.to.uid,
        dosage: dosageController.text+dosage,
        medicineCategory: medicineCategory,
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
     await NotificationService.to.scheduleAlert(
       1,
       PillsModel(
         userId: UserStore.to.uid,
         uid: isUploaded,
         pillName: pillName.text,
         dosage: dosageController.text+dosage,
         medicineCategory: medicineCategory,
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

  void checkIfIncreasePossible() {
    switch(hourlyInterval.value) {
      case '01 H':
        if(pillsTime.last.hour+1 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '02 H':
        if(pillsTime.last.hour+2 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '03 H':

        if(pillsTime.last.hour+3 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '04 H':
        if(pillsTime.last.hour+4 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;

      case '06 H':
        if(pillsTime.last.hour+6 >= 24){
          increasePossible.value = false;
        }else{
          increasePossible.value = true;
        }
        break;
    }
  }
}
