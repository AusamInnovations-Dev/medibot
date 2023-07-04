import 'dart:developer';

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
    loadingUserData.value = false;
    super.onInit();
  }

  getUserData() async {
    var history = await FirebaseFireStore.to.getHistoryData();
    if(history != null){
      for(var history in history.docs){
        historyList.add(HistoryModel.fromJson(history.data()));
      }
    }else{

    }
    log('This is the history list: $historyList');
    log('This is the reminder list: $reminderList');
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
      //TODO: Check if not scheduled for this day
      return 'NoPillsScheduled';
    }
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
      var day = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .isBefore(
          DateTime(
              int.parse(history.userId.substring(0,4)),
              int.parse(history.userId.substring(5,7)),
              int.parse(history.userId.substring(8,10)),
          ),
      );
      if(day){
        upComingDosage.value++;
      }
      if(totalTakenPillsDosage.value < totalPillsDosage.value){
        daysMissed.value++;
      }
    }

  }

}