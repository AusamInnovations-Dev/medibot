import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

import '../../../services/firestore.dart';
import '../../../services/user.dart';
import 'medibot_controller.dart';

class AddExistingSlotController extends GetxController {
  late PillsModel pill;
  RxList<Map<String, dynamic>> pillIntervals = <Map<String, dynamic>>[].obs;
  Rx<String> medicineCategory = 'Select Category'.obs;

  TextEditingController pillName = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  String dosage = 'Select Dosage';

  @override
  void onInit() {
    pill = Get.arguments!['pillModel'];
    calculateInterval();
    super.onInit();
  }

  calculateInterval() {
    pillIntervals.clear();
    log(pill.pillsInterval.first);
    log('${pill.pillsInterval.first.substring(0, 2)} ${pill.pillsInterval.first.substring(5, 7)}');

    for (var interval in pill.pillsInterval) {
      if (interval.substring(0, 2) == '00' &&
          interval.substring(5, 7) == '00') {
      } else {
        pillIntervals.add(
          {
            'hour': '${int.parse(interval.substring(0, 2)) >= 12 ? (int.parse(interval.substring(0, 2)) - 12) <= 9 ? '0${int.parse(interval.substring(0, 2)) - 12}' : int.parse(interval.substring(0, 2)) - 12 : interval.substring(0, 2)} H',
            'minute': '${interval.substring(5, 7)} M',
            'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
          },
        );
      }
    }
  }

  Future<bool> uploadMedibotPills() async {
    try {
      var isUploaded = false;
      if(pill.slot == 1){
        if(Get.find<MedibotController>().slot1.length <= 2) {
          isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
            uid: '',
            pillName: pillName.text,
            dosage: dosageController.text + dosage,
            medicineCategory: medicineCategory.value,
            userId: UserStore.to.uid,
            interval: pill.interval,
            inMedibot: true,
            isIndividual: pill.isIndividual,
            isRange: pill.isRange,
            pillsQuantity: pill.pillsQuantity,
            pillsInterval: pill.pillsInterval,
            pillsDuration: pill.pillsDuration,
            request: 1,
            slot: pill.slot,
          ));
        }else{
          Get.snackbar(
            "Medibot",
            "You cannot add more than 3 pills in the same slot",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      }else if(pill.slot == 2){
        if(Get.find<MedibotController>().slot2.length <= 2) {
          isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
            uid: '',
            pillName: pillName.text,
            dosage: dosageController.text + dosage,
            medicineCategory: medicineCategory.value,
            userId: UserStore.to.uid,
            interval: pill.interval,
            inMedibot: true,
            isIndividual: pill.isIndividual,
            isRange: pill.isRange,
            pillsQuantity: pill.pillsQuantity,
            pillsInterval: pill.pillsInterval,
            pillsDuration: pill.pillsDuration,
            request: 1,
            slot: pill.slot,
          ));
        }else{
          Get.snackbar(
            "Medibot",
            "You cannot add more than 3 pills in the same slot",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      }else if(pill.slot == 3){
        if(Get.find<MedibotController>().slot3.length <= 2) {
          isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
            uid: '',
            pillName: pillName.text,
            dosage: dosageController.text + dosage,
            medicineCategory: medicineCategory.value,
            userId: UserStore.to.uid,
            interval: pill.interval,
            inMedibot: true,
            isIndividual: pill.isIndividual,
            isRange: pill.isRange,
            pillsQuantity: pill.pillsQuantity,
            pillsInterval: pill.pillsInterval,
            pillsDuration: pill.pillsDuration,
            request: 1,
            slot: pill.slot,
          ));
        }else{
          Get.snackbar(
            "Medibot",
            "You cannot add more than 3 pills in the same slot",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      }else if(pill.slot == 4){
        if(Get.find<MedibotController>().slot4.length <= 2) {
          isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
            uid: '',
            pillName: pillName.text,
            dosage: dosageController.text + dosage,
            medicineCategory: medicineCategory.value,
            userId: UserStore.to.uid,
            interval: pill.interval,
            inMedibot: true,
            isIndividual: pill.isIndividual,
            isRange: pill.isRange,
            pillsQuantity: pill.pillsQuantity,
            pillsInterval: pill.pillsInterval,
            pillsDuration: pill.pillsDuration,
            request: 1,
            slot: pill.slot,
          ));
        }else{
          Get.snackbar(
            "Medibot",
            "You cannot add more than 3 pills in the same slot",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      }else if(pill.slot == 5){
        if(Get.find<MedibotController>().slot5.length <= 2) {
          isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
            uid: '',
            pillName: pillName.text,
            dosage: dosageController.text + dosage,
            medicineCategory: medicineCategory.value,
            userId: UserStore.to.uid,
            interval: pill.interval,
            inMedibot: true,
            isIndividual: pill.isIndividual,
            isRange: pill.isRange,
            pillsQuantity: pill.pillsQuantity,
            pillsInterval: pill.pillsInterval,
            pillsDuration: pill.pillsDuration,
            request: 1,
            slot: pill.slot,
          ));
        }else{
          Get.snackbar(
            "Medibot",
            "You cannot add more than 3 pills in the same slot",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      }else if(pill.slot == 6){
        if(Get.find<MedibotController>().slot6.length <= 2) {
          isUploaded = await FirebaseFireStore.to.uploadMedibotPills(PillsModel(
            uid: '',
            pillName: pillName.text,
            dosage: dosageController.text + dosage,
            medicineCategory: medicineCategory.value,
            userId: UserStore.to.uid,
            interval: pill.interval,
            inMedibot: true,
            isIndividual: pill.isIndividual,
            isRange: pill.isRange,
            pillsQuantity: pill.pillsQuantity,
            pillsInterval: pill.pillsInterval,
            pillsDuration: pill.pillsDuration,
            request: 1,
            slot: pill.slot,
          ));
        }else{
          Get.snackbar(
            "Medibot",
            "You cannot add more than 3 pills in the same slot",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      }
      return isUploaded;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }
}
