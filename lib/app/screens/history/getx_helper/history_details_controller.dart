import 'dart:developer';

import 'package:get/get.dart';
import 'package:medibot/app/models/history_model/history_model.dart';

import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';
import 'history_controller.dart';

class HistoryDetailsController extends GetxController {
  late DateTime date;
  late RxList<PillsModel> reminderList;
  late List<PillsModel> todayReminders;
  late List showingReminder;
  HistoryModel? historyModel;
  RxList morning = [].obs;
  RxList afternoon = [].obs;
  RxList evening = [].obs;
  RxList night = [].obs;

  var isLoading = false.obs;
  var itsToday = false.obs;
  var isUpcoming = false.obs;

  @override
  void onInit() {
    date = Get.arguments['date'];
    todayReminders = Get.arguments['todayReminders'];
    isUpcoming.value = Get.arguments['isUpcoming'] ?? false;
    itsToday.value = Get.arguments['itsToday'] ?? false;
    reminderList = Get.find<HistoryController>().reminderList;
    findSelectedDayHistory();
    super.onInit();
  }

  findSelectedDayHistory() async {
    isLoading.value = true;
    var selectedHistory = await FirebaseFireStore.to.getHistoryDataByDay('${date.year}:${date.month < 10 ? '0${date.month}' : date.month}:${date.day < 10 ? '0${date.day}' : date.day}');
    if (selectedHistory == null) {
      historyModel = HistoryModel(userId: '${date.year}:${date.month < 10 ? '0${date.month}' : date.month}:${date.day < 10 ? '0${date.day}' : date.day}', historyData: []);
      for (var reminder in todayReminders) {
        for (var element in reminder.pillsInterval) {
          if(int.parse(element.substring(0,2)) < 12){
            log('Hello 8 and 12');
            morning.add(
              {
                'pillName': reminder.pillName,
                'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
              }
            );
          }else if(int.parse(element.substring(0,2)) >= 12 && int.parse(element.substring(0,2)) < 16){
            log('Hello 16');
            afternoon.add(
                {
                  'pillName': reminder.pillName,
                  'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                }
            );
          }else if(int.parse(element.substring(0,2)) >= 16 && int.parse(element.substring(0,2)) <=19){
            log('Hello 19');
            evening.add(
                {
                  'pillName': reminder.pillName,
                  'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                }
            );
          }else{
            log('Hello 20');
            night.add(
                {
                  'pillName': reminder.pillName,
                  'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                }
            );
          }
        }
      }
      log('$morning : $afternoon : $evening : $night');
    } else {
      historyModel = HistoryModel.fromJson(selectedHistory.data() as Map<String, dynamic>);
      for(var reminder in todayReminders){
        HistoryData? history;
        for(var historyData in historyModel!.historyData){
          if(historyData.pillId == reminder.uid){
            history = historyData;
            break;
          }
        }
        log('This is history pill : $history');
        for (var element in reminder.pillsInterval) {
          if(history == null){
            if(int.parse(element.substring(0,2)) < 12){
              morning.add(
                  {
                    'pillName': reminder.pillName,
                    'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                  }
              );
            }else if(int.parse(element.substring(0,2)) >= 12 && int.parse(element.substring(0,2)) < 16){
              afternoon.add(
                  {
                    'pillName': reminder.pillName,
                    'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                  }
              );
            }else if(int.parse(element.substring(0,2)) >= 16 && int.parse(element.substring(0,2)) <=19){
              evening.add(
                  {
                    'pillName': reminder.pillName,
                    'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                  }
              );
            }else{
              night.add(
                  {
                    'pillName': reminder.pillName,
                    'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                  }
              );
            }
          }else{
            var difference = 60;
            var nextIndex = reminder.pillsInterval.indexOf(element)+1;
            if(nextIndex < reminder.pillsInterval.length){
              difference = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                int.parse(reminder.pillsInterval[nextIndex].substring(0, 2)),
                int.parse(reminder.pillsInterval[nextIndex].substring(5, 7)),
              ).difference(
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  int.parse(element.substring(0, 2)),
                  int.parse(element.substring(5, 7)),
                ),
              ).inMinutes;
            }
            var diff = history.timeTaken.any((element1) => element1.difference(DateTime(date.year, date.month,date.day, int.parse(element.substring(0,2)), int.parse(element.substring(5,7)))).inMinutes <= difference/2 && element1.difference(DateTime(date.year,date.month,date.day, int.parse(element.substring(0,2)), int.parse(element.substring(5,7)))).inMinutes >=-30);
            if(int.parse(element.substring(0,2)) < 12){
              if(diff){
                morning.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : 'Taken'
                    }
                );
              }else{
                morning.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                    }
                );
              }
            }else if(int.parse(element.substring(0,2)) >= 12 && int.parse(element.substring(0,2)) < 16){
              if(diff){
                afternoon.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : 'Taken'
                    }
                );
              }else{
                afternoon.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                    }
                );
              }
            }else if(int.parse(element.substring(0,2)) >= 16 && int.parse(element.substring(0,2)) <=19){
              if(diff){
                evening.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : 'Taken'
                    }
                );
              }else{
                evening.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                    }
                );
              }
            }else{
              if(diff){
                night.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : 'Taken'
                    }
                );
              }else{
                night.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Under process' : 'Missed'
                    }
                );
              }
            }
          }
        }
      }
    }
    isLoading.value = false;
  }
}
