import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';

class EditMedibotController extends GetxController{

  late List<PillsModel> pill;
  late int remainingDay;
  RxList<TextEditingController> dosageController = <TextEditingController>[].obs;
  RxList<TextEditingController> pillName = <TextEditingController>[].obs;
  RxList<String> dosage = <String>[].obs;
  RxList<String> medicineCategory = <String>[].obs;
  Rx<String> interval = 'Once a Day (24 Hours)'.obs;
  Rx<String> hourlyInterval = '01 H'.obs;

  List<TimeOfDay> pillsTime = [];
  Rx<bool> increasePossible = true.obs;
  Rx<int> pillQuantity = 1.obs;
  RxList<Map<String, Object>> timeIntervals = <Map<String, Object>>[].obs;

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    remainingDay = Get.arguments['remainingDays'];
    interval.value = pill.first.interval;
    pillQuantity.value = int.parse(pill.first.pillsQuantity);
    for(var reminder in pill){
      pillName.add(TextEditingController(text: reminder.pillName));
      dosageController.add(TextEditingController(text: ''));
      dosage.add('Select Dosage');
      medicineCategory.add(reminder.medicineCategory);
    }
    for(var time in pill.first.pillsInterval){
      pillsTime.add(TimeOfDay(
        hour: int.parse(time.substring(0,2)),
        minute: int.parse(time.substring(5,7)),
      ));
      timeIntervals.add({
        'hour': '${pillsTime.last.hour > 12 ? (pillsTime.last.hour-12) > 9? (pillsTime.last.hour-12) : '0${pillsTime.last.hour-12}' : pillsTime.last.hour > 9? pillsTime.last.hour : '0${pillsTime.last.hour}'} H',
        'minute': '${pillsTime.last.minute <= 9 ? '0${pillsTime.last.minute}' : pillsTime.last.minute} M',
        'period': pillsTime.last.hour > 12 && pillsTime.last.hour != 24? "PM" : pillsTime.last.hour == 12 ? "PM" : "AM",
      });
    }
    super.onInit();
  }

  updatePill() async {
    List<String> intervalsInString = [];
    for(var interval in timeIntervals){
      var hour = interval['hour'] as String;
      var minute = interval['minute'] as String;
      intervalsInString.add(
          '${interval['period'] == 'AM' ? hour.substring(0,2) == '12' ? int.parse(hour.substring(0,2))+12 : hour.substring(0,2) : int.parse(hour.substring(0,2)) == 12 ? hour.substring(0,2) :  int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM'
      );
    }
    for(var i=0; i<pill.length; i++){
      if(dosage[i] != 'Select Dosage' && dosageController[i].text.isNotEmpty){
        await FirebaseFireStore.to.updateMedibotData(
            pill[i].copyWith(
              interval: interval.value,
              pillsQuantity: pillQuantity.value.toString(),
              pillsInterval: intervalsInString,
              pillName: pillName[i].text,
              dosage: dosageController[i].text+dosage[i],
              medicineCategory: medicineCategory[i],
            )
        );
      }else{
        await FirebaseFireStore.to.updateMedibotData(
            pill[i].copyWith(
              interval: interval.value,
              pillsQuantity: pillQuantity.value.toString(),
              pillsInterval: intervalsInString,
              pillName: pillName[i].text,
              medicineCategory: medicineCategory[i],
            )
        );
      }
    }
    Get.back();
  }


  selectingTimeIntervals() {
    if (interval.value == 'Once a Day (24 Hours)') {
      if(timeIntervals.length > 1){
        pillsTime.removeRange(1, pillsTime.length);
        timeIntervals.removeRange(1, timeIntervals.length);
      }
      log(timeIntervals.toString());
    } else if (interval.value == 'Twice a Day (12 Hours)') {
      if(timeIntervals.length > 2){
        log('Hello removing pills');
        pillsTime.removeRange(2, pillsTime.length);
        timeIntervals.removeRange(2, timeIntervals.length);
      }else if(timeIntervals.length == 1){
        pillsTime.add(const TimeOfDay(
          hour: 8,
          minute: 00,
        ));
        timeIntervals.add({
          'hour': '08 H',
          'minute': '00 M',
          'period': 'PM'
        });
      }
      log(timeIntervals.toString());
    } else if (interval.value == 'Thrice a Day (8 Hours)') {
      if(pillsTime.length > 3){
        pillsTime.removeRange(3, pillsTime.length);
        timeIntervals.removeRange(3, timeIntervals.length);
      }else if (timeIntervals.length == 1){
        pillsTime.add(const TimeOfDay(
          hour: 16,
          minute: 00,
        ));
        pillsTime.add(const TimeOfDay(
          hour: 24,
          minute: 00,
        ));
        timeIntervals.add({
          'hour': '04 H',
          'minute': '00 M',
          'period': 'PM'
        });
        timeIntervals.add({
          'hour': '12 H',
          'minute': '00 M',
          'period': 'AM'
        });
      }else if (timeIntervals.length == 2) {
        pillsTime.last = const TimeOfDay(
          hour: 4,
          minute: 00,
        );
        timeIntervals.last = {
          'hour': '04 H',
          'minute': '00 M',
          'period': 'PM'
        };
        pillsTime.add(const TimeOfDay(
          hour: 24,
          minute: 00,
        ));
        log(pillsTime.toString());
        timeIntervals.add({
          'hour': '12 H',
          'minute': '00 M',
          'period': 'AM'
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
      'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
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
          'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
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
          'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
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
          'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
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
          'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
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
          'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
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