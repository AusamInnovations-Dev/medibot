import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

import '../../../services/firestore.dart';
import '../../../services/user.dart';

class AddExistingSlotController extends GetxController {
  late PillsModel pill;
  List<Map<String, dynamic>> pillIntervals = [];
  Rx<String> medicineCategory = 'Select Category'.obs;

  TextEditingController pillName = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  String dosage = 'Select Dosage';

  @override
  void onInit() {
    pill = Get.arguments!['pillModel'];
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
            'hour':
                '${int.parse(interval.substring(0, 2)) >= 12 ? (int.parse(interval.substring(0, 2)) - 12) <= 9 ? '0${int.parse(interval.substring(0, 2)) - 12}' : int.parse(interval.substring(0, 2)) - 12 : interval.substring(0, 2)} H',
            'minute': '${interval.substring(5, 7)} M',
            'period': int.parse(interval.substring(0, 2)) >= 12 ? "PM" : "AM",
          },
        );
      }
    }
  }

  Future<bool> uploadCabinetPills() async {
    try {
      var isUploaded = await FirebaseFireStore.to.uploadCabinetPills(PillsModel(
        uid: '',
        pillName: pillName.text,
        dosage: dosageController.text + dosage,
        medicineCategory: medicineCategory.value,
        userId: UserStore.to.uid,
        interval: pill.interval,
        inCabinet: true,
        isIndividual: pill.isIndividual,
        isRange: pill.isRange,
        pillsQuantity: pill.pillsQuantity,
        pillsInterval: pill.pillsInterval,
        pillsDuration: pill.pillsDuration,
        request: 1,
        slot: pill.slot,
      ));
      return isUploaded;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }
}
