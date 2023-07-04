import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/history_model/history_model.dart';
import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';

class HistoryController extends GetxController {

  var loadingUserData = false.obs;
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  RxList<PillsModel> reminderList = <PillsModel>[].obs;

  var totalTakenPillsDosage = 0.obs;
  var totalPillsDosage = 0.obs;
  var upComingDosage = 0.obs;
  var daysMissed = 0.obs;

  @override
  Future<void> onInit() async {
    loadingUserData.value = true;
    await getUserData();
    checkForAllHistory();
    super.onInit();
  }

  getUserData() async {
    var history = await FirebaseFireStore.to.getHistoryData();
    var pillsReminder = FirebaseFireStore.to.getAllPillsReminder();
    var cabinetPillsReminder = FirebaseFireStore.to.getAllCabinetPills();
    if(history != null){
      for(var history in history.docs){
        historyList.add(HistoryModel.fromJson(history.data()));
      }
    }
    pillsReminder.listen((snapshot) {
      for(var pill in snapshot.docChanges){
        switch(pill.type){
          case DocumentChangeType.added:
            PillsModel pillsModel = PillsModel.fromJson(pill.doc.data()!);
            if(pillsModel.isIndividual) {
              List<DateTime> dates = pillsModel.pillsDuration.map((e) => DateTime.parse(e)).toList();
              if(dates.contains(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
                reminderList.add(pillsModel);
              }
            }else{
              List<DateTime> dates = pillsModel.pillsDuration.map((e) => DateTime.parse(e)).toList();
              if(dates.first.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) || dates.last.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
                reminderList.add(pillsModel);
              }
            }
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
    cabinetPillsReminder.listen((snapshot) {
      for(var pill in snapshot.docChanges){
        switch(pill.type) {
          case DocumentChangeType.added:
            PillsModel pillsModel = PillsModel.fromJson(pill.doc.data()!);
            if(pillsModel.isIndividual) {
              List<DateTime> dates = pillsModel.pillsDuration.map((e) => DateTime.parse(e)).toList();
              if(dates.contains(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
                reminderList.add(pillsModel);
              }
            }else{
              List<DateTime> dates = pillsModel.pillsDuration.map((e) => DateTime.parse(e)).toList();
              if(dates.first.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) || dates.last.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
                reminderList.add(pillsModel);
              }
            }
            break;
          case DocumentChangeType.modified:
          // TODO: Handle this case.
            break;
          case DocumentChangeType.removed:
          // TODO: Handle this case.
            break;
        }
      }
      totalPillsDosage.value = 0;
      for(var reminder in reminderList){
        totalPillsDosage.value += reminder.pillsInterval.length;
        if(reminder.isIndividual){
          for(var time in reminder.pillsDuration){
            DateTime date = DateTime.parse(time);
            if(date.isAfter(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day))){
              upComingDosage.value++;
            }
          }
        }else {
          DateTime date1 = DateTime.parse(reminder.pillsDuration.first);
          DateTime date2 = DateTime.parse(reminder.pillsDuration.last);

          if(date1.isBefore(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day)) && date2.isAfter(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day))){
            upComingDosage.value += date2.difference(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day)).inDays;
          }else if(date1.isAfter(DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day))){
            upComingDosage.value += date2.difference(date1).inDays;
          }
        }
      }
      log('Total reminders : ${totalPillsDosage.value}');
    });
  }

  String checkForSuccess(DateTime date) {
    HistoryModel? historyItem;
    for(var element in historyList){
      if(element.userId == '${date.year}:${date.month}:${date.day}'){
        historyItem = element;
        break;
      }
    }
    if(historyItem != null){
      var totalPills = 0;
      var takenPills = 0;

      for(var pill in historyItem.historyData){
        takenPills += pill.timeTaken.length;
        totalPills += pill.timeToTake.length;
      }

      if(totalPills == takenPills){
        return 'AllPillsTaken';
      } else if(takenPills == 0) {
        return 'NoPillsTaken';
      } else {
        return 'PartiallyTaken';
      }
    }else {
      for(var reminder in reminderList){
        if(reminder.isIndividual) {
          List<DateTime> dates = reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
          if(dates.contains(DateTime(date.year, date.month, date.day))){
            return 'NoPillsTaken';
          }
        }else{
          List<DateTime> dates = reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
          if(dates.first.isBefore(DateTime(date.year, date.month, date.day)) && dates.last.isAfter(DateTime(date.year, date.month, date.day))){
            return 'NoPillsTaken';
          }
        }
      }
      return 'NoPillsScheduled';
    }
  }

  List<PillsModel> todayReminders(DateTime date) {
    List<PillsModel> todayReminder = [];
    for(var reminder in reminderList){
      if(reminder.isIndividual) {
        List<DateTime> dates = reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
        if(dates.contains(DateTime(date.year, date.month, date.day))){
          todayReminder.add(reminder);
        }
      }else{
        List<DateTime> dates = reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
        if(dates.first.isBefore(DateTime(date.year, date.month, date.day)) && dates.last.isAfter(DateTime(date.year, date.month, date.day))){
          todayReminder.add(reminder);
        }
      }
    }
    log('This is all today reminder: $todayReminder');
    return todayReminder;
  }

  checkForAllHistory() {
    for(var history in historyList){
      for(var pill in history.historyData){
        totalTakenPillsDosage.value += pill.timeTaken.length;
        totalPillsDosage.value += pill.timeToTake.length;
      }
      log(history.userId.substring(0,4));
      log(history.userId.substring(5,7));
      log(history.userId.substring(8,10));
      if(totalTakenPillsDosage.value < totalPillsDosage.value){
        daysMissed.value++;
      }
    }
    loadingUserData.value = false;
  }

}