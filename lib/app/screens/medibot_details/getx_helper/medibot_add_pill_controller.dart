
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';
import '../../../services/user.dart';
import 'medibot_controller.dart';

class AddMedibotPill extends GetxController {
  TextEditingController pillName = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  String dosage = 'Select Dosage';
  Rx<String> medicineCategory = 'Select Category'.obs;
  Rx<String> interval = 'Once a Day (24 Hours)'.obs;
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
    {'hour': '08 H', 'minute': '00 M', 'period': 'AM'}
  ].obs;

  RxList<DateTime> durationDates = <DateTime>[].obs;

  selectingTimeIntervals() {
    if (interval.value == 'Once a Day (24 Hours)') {
      if(timeIntervals.length > 1){
        pillsTime.removeRange(1, pillsTime.length);
        timeIntervals.removeRange(1, timeIntervals.length);
      }
    } else if (interval.value == 'Twice a Day (12 Hours)') {
      if(timeIntervals.length > 2){
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
        timeIntervals.add({
          'hour': '12 H',
          'minute': '00 M',
          'period': 'AM'
        });
      }
    }
  }

  gererateCustomTimeInterval() {
    timeIntervals.clear();
    pillsTime.clear();
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
        pillsTime.add(TimeOfDay(
          hour: pillsTime.last.hour+6,
          minute: 00,
        ));
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

  Future<bool> uploadMedibotPills() async {
    List<String> intervalsInString = [];
    for(var interval in timeIntervals){
      var hour = interval['hour'] as String;
      var minute = interval['minute'] as String;
      intervalsInString.add(
          '${interval['period'] == 'AM' ? hour.substring(0,2) == '12' ? int.parse(hour.substring(0,2))+12 : hour.substring(0,2) : int.parse(hour.substring(0,2)) == 12 ? hour.substring(0,2) :  int.parse(hour.substring(0,2)) + 12}HH:${minute.substring(0,2)}MM'
      );
    }

    try {
      var controller = Get.find<MedibotController>();
      if(controller.slot1.isEmpty){
        var isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
          uid: '',
          pillName: pillName.text,
          dosage: dosageController.text+dosage,
          medicineCategory: medicineCategory.value,
          userId: UserStore.to.uid,
          interval: interval.value,
          inMedibot: true,
          isIndividual: isIndividual.value,
          isRange: isRange.value,
          pillsQuantity: pillQuantity.value.toString(),
          pillsInterval: intervalsInString,
          pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
          request: 1,
          slot: 1,
        ));
        return isUploaded;
      }else if(controller.slot2.isEmpty){
        var isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
          uid: '',
          pillName: pillName.text,
          dosage: dosageController.text+dosage,
          medicineCategory: medicineCategory.value,
          userId: UserStore.to.uid,
          interval: interval.value,
          inMedibot: true,
          isIndividual: isIndividual.value,
          isRange: isRange.value,
          pillsQuantity: pillQuantity.value.toString(),
          pillsInterval: intervalsInString,
          pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
          request: 1,
          slot: 2,
        ));
        return isUploaded;
      }else if(controller.slot3.isEmpty){
        var isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
          uid: '',
          pillName: pillName.text,
          dosage: dosageController.text+dosage,
          medicineCategory: medicineCategory.value,
          userId: UserStore.to.uid,
          interval: interval.value,
          inMedibot: true,
          isIndividual: isIndividual.value,
          isRange: isRange.value,
          pillsQuantity: pillQuantity.value.toString(),
          pillsInterval: intervalsInString,
          pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
          request: 1,
          slot: 3,
        ));
        return isUploaded;
      }else if(controller.slot4.isEmpty){
        var isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
          uid: '',
          pillName: pillName.text,
          dosage: dosageController.text+dosage,
          medicineCategory: medicineCategory.value,
          userId: UserStore.to.uid,
          interval: interval.value,
          inMedibot: true,
          isIndividual: isIndividual.value,
          isRange: isRange.value,
          pillsQuantity: pillQuantity.value.toString(),
          pillsInterval: intervalsInString,
          pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
          request: 1,
          slot: 4,
        ));
        return isUploaded;
      }else if(controller.slot5.isEmpty){
        var isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
          uid: '',
          pillName: pillName.text,
          dosage: dosageController.text+dosage,
          medicineCategory: medicineCategory.value,
          userId: UserStore.to.uid,
          interval: interval.value,
          inMedibot: true,
          isIndividual: isIndividual.value,
          isRange: isRange.value,
          pillsQuantity: pillQuantity.value.toString(),
          pillsInterval: intervalsInString,
          pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
          request: 1,
          slot: 5,
        ));
        return isUploaded;
      } else if(controller.slot6.isEmpty){
        var isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
          uid: '',
          pillName: pillName.text,
          dosage: dosageController.text+dosage,
          medicineCategory: medicineCategory.value,
          userId: UserStore.to.uid,
          interval: interval.value,
          inMedibot: true,
          isIndividual: isIndividual.value,
          isRange: isRange.value,
          pillsQuantity: pillQuantity.value.toString(),
          pillsInterval: intervalsInString,
          pillsDuration: durationDates.map((e) => e.toIso8601String()).toList(),
          request: 1,
          slot: 6,
        ));
        return isUploaded;
      }else {
        Get.snackbar(
          "Medibot",
          "You don't have enough empty slot left in Medibot",
          icon: const Icon(
            Icons.crisis_alert,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
        return false;
      }
    } catch (err) {
      log(err.toString());
      return false;
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