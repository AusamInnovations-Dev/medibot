
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';

class ViewController extends GetxController{

  var isLoading = false.obs;
  RxList<PillsModel> reminders = <PillsModel>[].obs;
  RxList<PillsModel> slot1 = <PillsModel>[].obs;
  RxList<PillsModel> slot2 = <PillsModel>[].obs;
  RxList<PillsModel> slot3 = <PillsModel>[].obs;
  RxList<PillsModel> slot4 = <PillsModel>[].obs;
  RxList<PillsModel> slot5 = <PillsModel>[].obs;
  RxList<PillsModel> slot6 = <PillsModel>[].obs;
  Rx<int> slot1remainingDay = 0.obs;
  Rx<int> slot2remainingDay = 0.obs;
  Rx<int> slot3remainingDay = 0.obs;
  Rx<int> slot4remainingDay = 0.obs;
  Rx<int> slot5remainingDay = 0.obs;
  Rx<int> slot6remainingDay = 0.obs;
  RefreshController refreshController = RefreshController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getMedibotDetails();
    await getReminders();
  }

  onRefreshMedibot() async {
    await getMedibotDetails();
    await getReminders();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  getReminders() async {
    reminders.clear();
    var pillsReminder = FirebaseFireStore.to.getAllPillsReminder();
    pillsReminder.listen((snapshot) {
      for (var pill in snapshot.docChanges) {
        switch (pill.type) {
          case DocumentChangeType.added:
            reminders.add(PillsModel.fromJson(pill.doc.data()!));
            break;
          case DocumentChangeType.modified:
          // TODO: Handle this case.
            break;
          case DocumentChangeType.removed:
          // TODO: Handle this case.
            break;
        }
      }
    });
  }

  getMedibotDetails() async {
    isLoading.value = true;
    try {
      slot1.clear();
      slot2.clear();
      slot3.clear();
      slot4.clear();
      slot5.clear();
      slot6.clear();
      var medibotData = FirebaseFireStore.to.getMedibotDetail();
      medibotData.listen((snapshot) {
        for (var medibot in snapshot.docChanges) {
          switch (medibot.type) {
            case DocumentChangeType.added:
              if (medibot.doc.data() != null) {
                addSlotPill(medibot.doc.data());
              }
              break;
            case DocumentChangeType.modified:
              if (medibot.doc.data() != null) {
                modifySlotPill(medibot.doc.data());
              }
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      });
    } catch (err) {
      log(err.toString());
    }
    isLoading.value = false;
  }

  addSlotPill(pill) {
    switch(pill['slot']) {
      case 1:
        slot1.add(PillsModel.fromJson(pill));
        if (slot1.last.isIndividual) {
          var difference = 0;
          for (var date in slot1.last.pillsDuration) {
            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              difference++;
            }
          }
          slot1remainingDay.value = difference;
        } else if (slot1.last.isRange) {
          slot1remainingDay.value = DateTime.parse(slot1.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
          if(slot1remainingDay.value < 0){
            slot1remainingDay.value = 0;
          }
        }
        break;

      case 2:
        slot2.add(PillsModel.fromJson(pill));
        if (slot2.last.isIndividual) {
          var difference = 0;
          for (var date in slot2.last.pillsDuration) {
            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              difference++;
            }
          }
          slot2remainingDay.value = difference;
        } else if (slot2.last.isRange) {
          slot2remainingDay.value = DateTime.parse(slot2.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
          if(slot2remainingDay.value < 0){
            slot2remainingDay.value = 0;
          }
        }
        break;

      case 3:
        slot3.add(PillsModel.fromJson(pill));
        if (slot3.last.isIndividual) {
          var difference = 0;
          for (var date in slot3.last.pillsDuration) {
            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              difference++;
            }
          }
          slot3remainingDay.value = difference;
        } else if (slot3.last.isRange) {
          slot3remainingDay.value = DateTime.parse(slot3.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
          if(slot3remainingDay.value < 0){
            slot3remainingDay.value = 0;
          }
        }
        break;

      case 4:
        slot4.add(PillsModel.fromJson(pill));
        if (slot4.last.isIndividual) {
          var difference = 0;
          for (var date in slot4.last.pillsDuration) {
            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              difference++;
            }
          }
          slot4remainingDay.value = difference;
        } else if (slot4.last.isRange) {
          slot4remainingDay.value = DateTime.parse(slot4.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
          if(slot4remainingDay.value < 0){
            slot4remainingDay.value = 0;
          }
        }
        break;

      case 5:
        slot5.add(PillsModel.fromJson(pill));
        if (slot5.last.isIndividual) {
          var difference = 0;
          for (var date in slot5.last.pillsDuration) {
            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              difference++;
            }
          }
          slot5remainingDay.value = difference;
        } else if (slot5.last.isRange) {
          slot5remainingDay.value = DateTime.parse(slot5.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
          if(slot5remainingDay.value < 0){
            slot5remainingDay.value = 0;
          }
        }
        break;

      case 6:
        slot6.add(PillsModel.fromJson(pill));
        if (slot6.last.isIndividual) {
          var difference = 0;
          for (var date in slot6.last.pillsDuration) {
            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              difference++;
            }
          }
          slot6remainingDay.value = difference;
        } else if (slot6.last.isRange) {
          slot6remainingDay.value = DateTime.parse(slot6.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
          if(slot6remainingDay.value < 0){
            slot6remainingDay.value = 0;
          }
        }
        break;
    }
  }

  modifySlotPill(pill) {
    switch(pill['slot']) {
      case 1:
        int changeIndex = slot1.indexWhere((element) => element.uid == pill['uid']);
        Map<String, dynamic> modification = pill as Map<String, dynamic>;
        var modifiedRemainder = PillsModel.fromJson(modification);
        slot1[changeIndex] = slot1[changeIndex]
            .copyWith(
          uid: modifiedRemainder.uid,
          dosage: modifiedRemainder.dosage,
          inMedibot: modifiedRemainder.inMedibot,
          interval: modifiedRemainder.interval,
          isIndividual: modifiedRemainder.isIndividual,
          isRange: modifiedRemainder.isRange,
          pillName: modifiedRemainder.pillName,
          pillsDuration: modifiedRemainder.pillsDuration,
          pillsInterval: modifiedRemainder.pillsInterval,
          pillsQuantity: modifiedRemainder.pillsQuantity,
          request: modifiedRemainder.request,
        );
        break;

      case 2:
        int changeIndex = slot2.indexWhere((element) => element.uid == pill['uid']);
        Map<String, dynamic> modification = pill as Map<String, dynamic>;
        var modifiedRemainder = PillsModel.fromJson(modification);
        slot2[changeIndex] = slot2[changeIndex]
            .copyWith(
          uid: modifiedRemainder.uid,
          dosage: modifiedRemainder.dosage,
          inMedibot: modifiedRemainder.inMedibot,
          interval: modifiedRemainder.interval,
          isIndividual: modifiedRemainder.isIndividual,
          isRange: modifiedRemainder.isRange,
          pillName: modifiedRemainder.pillName,
          pillsDuration: modifiedRemainder.pillsDuration,
          pillsInterval: modifiedRemainder.pillsInterval,
          pillsQuantity: modifiedRemainder.pillsQuantity,
          request: modifiedRemainder.request,
        );
        break;

      case 3:
        int changeIndex = slot3.indexWhere((element) => element.uid == pill['uid']);
        Map<String, dynamic> modification = pill as Map<String, dynamic>;
        var modifiedRemainder = PillsModel.fromJson(modification);
        slot3[changeIndex] = slot3[changeIndex]
            .copyWith(
          uid: modifiedRemainder.uid,
          dosage: modifiedRemainder.dosage,
          inMedibot: modifiedRemainder.inMedibot,
          interval: modifiedRemainder.interval,
          isIndividual: modifiedRemainder.isIndividual,
          isRange: modifiedRemainder.isRange,
          pillName: modifiedRemainder.pillName,
          pillsDuration: modifiedRemainder.pillsDuration,
          pillsInterval: modifiedRemainder.pillsInterval,
          pillsQuantity: modifiedRemainder.pillsQuantity,
          request: modifiedRemainder.request,
        );
        break;

      case 4:
        int changeIndex = slot4.indexWhere((element) => element.uid == pill['uid']);
        Map<String, dynamic> modification = pill as Map<String, dynamic>;
        var modifiedRemainder = PillsModel.fromJson(modification);
        slot4[changeIndex] = slot4[changeIndex]
            .copyWith(
          uid: modifiedRemainder.uid,
          dosage: modifiedRemainder.dosage,
          inMedibot: modifiedRemainder.inMedibot,
          interval: modifiedRemainder.interval,
          isIndividual: modifiedRemainder.isIndividual,
          isRange: modifiedRemainder.isRange,
          pillName: modifiedRemainder.pillName,
          pillsDuration: modifiedRemainder.pillsDuration,
          pillsInterval: modifiedRemainder.pillsInterval,
          pillsQuantity: modifiedRemainder.pillsQuantity,
          request: modifiedRemainder.request,
        );
        break;

      case 5:
        int changeIndex = slot5.indexWhere((element) => element.uid == pill['uid']);
        Map<String, dynamic> modification = pill as Map<String, dynamic>;
        var modifiedRemainder = PillsModel.fromJson(modification);
        slot5[changeIndex] = slot5[changeIndex]
            .copyWith(
          uid: modifiedRemainder.uid,
          dosage: modifiedRemainder.dosage,
          inMedibot: modifiedRemainder.inMedibot,
          interval: modifiedRemainder.interval,
          isIndividual: modifiedRemainder.isIndividual,
          isRange: modifiedRemainder.isRange,
          pillName: modifiedRemainder.pillName,
          pillsDuration: modifiedRemainder.pillsDuration,
          pillsInterval: modifiedRemainder.pillsInterval,
          pillsQuantity: modifiedRemainder.pillsQuantity,
          request: modifiedRemainder.request,
        );
        break;

      case 6:
        int changeIndex = slot6.indexWhere((element) => element.uid == pill['uid']);
        Map<String, dynamic> modification = pill as Map<String, dynamic>;
        var modifiedRemainder = PillsModel.fromJson(modification);
        slot6[changeIndex] = slot6[changeIndex]
            .copyWith(
          uid: modifiedRemainder.uid,
          dosage: modifiedRemainder.dosage,
          inMedibot: modifiedRemainder.inMedibot,
          interval: modifiedRemainder.interval,
          isIndividual: modifiedRemainder.isIndividual,
          isRange: modifiedRemainder.isRange,
          pillName: modifiedRemainder.pillName,
          pillsDuration: modifiedRemainder.pillsDuration,
          pillsInterval: modifiedRemainder.pillsInterval,
          pillsQuantity: modifiedRemainder.pillsQuantity,
          request: modifiedRemainder.request,
        );
        break;
    }
  }

  Future<void> deletePill(String uid, int index, int slot) async {
    await FirebaseFireStore.to.deletePill(uid);
    switch(slot){
      case 1:
        slot1.removeAt(index);
        break;

      case 2:
        slot2.removeAt(index);
        break;

      case 3:
        slot3.removeAt(index);
        break;

      case 4:
        slot4.removeAt(index);
        break;

      case 5:
        slot5.removeAt(index);
        break;

      case 6:
        slot6.removeAt(index);
        break;
    }
  }

  Future<void> deleteReminderPill(String uid, int index) async {
    await FirebaseFireStore.to.deleteReminderPill(uid);
    reminders.removeAt(index);
  }

}