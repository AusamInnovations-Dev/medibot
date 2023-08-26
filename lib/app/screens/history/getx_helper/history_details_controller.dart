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
        if(reminder.inMedibot){
          if(history != null){
            for(int i=0; i<reminder.pillsInterval.length; i++){
              if(i < history.timeTaken.length){
                if(int.parse(history.timeTaken[i].substring(0,2)) < 12){
                  if(!isUpcoming.value){
                    morning.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  }else {
                    morning.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : 'Upcoming'
                        }
                    );
                  }
                }else if(int.parse(history.timeTaken[i].substring(0,2)) >= 12 && int.parse(history.timeTaken[i].substring(0,2)) < 16){
                  if(!isUpcoming.value){
                    afternoon.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  }else {
                    afternoon.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : 'Upcoming'
                        }
                    );
                  }
                }else if(int.parse(history.timeTaken[i].substring(0,2)) >= 16 && int.parse(history.timeTaken[i].substring(0,2)) <=19){
                  if(!isUpcoming.value){
                    evening.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  }else {
                    evening.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : 'Upcoming'
                        }
                    );
                  }
                }else {
                  if (!isUpcoming.value) {
                    night.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule': history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  } else {
                    night.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule': 'Upcoming'
                        }
                    );
                  }
                }
              }else{
                if(int.parse(reminder.pillsInterval[i].substring(0,2)) < 12){
                  morning.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }else if(int.parse(reminder.pillsInterval[i].substring(0,2)) >= 12 && int.parse(reminder.pillsInterval[i].substring(0,2)) < 16){
                  afternoon.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }else if(int.parse(reminder.pillsInterval[i].substring(0,2)) >= 16 && int.parse(reminder.pillsInterval[i].substring(0,2)) <=19){
                  evening.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }else{
                  night.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }
              }
            }
          }else {
            for (var element in reminder.pillsInterval) {
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
            }
          }
        }else {
          if(history == null){
            for (var element in reminder.pillsInterval) {
              if(int.parse(element.substring(0,2)) < 12){
                morning.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                    }
                );
              }else if(int.parse(element.substring(0,2)) >= 12 && int.parse(element.substring(0,2)) < 16){
                afternoon.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                    }
                );
              }else if(int.parse(element.substring(0,2)) >= 16 && int.parse(element.substring(0,2)) <=19){
                evening.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                    }
                );
              }else{
                night.add(
                    {
                      'pillName': reminder.pillName,
                      'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                    }
                );
              }
            }
          }else{
            for(int i=0; i<reminder.pillsInterval.length; i++){
              if(i < history.timeTaken.length){
                if(int.parse(history.timeTaken[i].substring(0,2)) < 12){
                  if(!isUpcoming.value){
                    morning.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  }else {
                    morning.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : 'Upcoming'
                        }
                    );
                  }
                }else if(int.parse(history.timeTaken[i].substring(0,2)) >= 12 && int.parse(history.timeTaken[i].substring(0,2)) < 16){
                  if(!isUpcoming.value){
                    afternoon.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  }else {
                    afternoon.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : 'Upcoming'
                        }
                    );
                  }
                }else if(int.parse(history.timeTaken[i].substring(0,2)) >= 16 && int.parse(history.timeTaken[i].substring(0,2)) <=19){
                  if(!isUpcoming.value){
                    evening.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : history.med_status[i] == "Y" ? 'Taken on time' : history.med_status[i] == "L" ? "Taken Late" : "Missed"
                        }
                    );
                  }else {
                    evening.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule' : 'Upcoming'
                        }
                    );
                  }
                }else {
                  if (!isUpcoming.value) {
                    night.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule': history.med_status[i] == "Y"
                              ? 'Taken on time'
                              : history.med_status[i] == "L"
                              ? "Taken Late"
                              : "Missed"
                        }
                    );
                  } else {
                    night.add(
                        {
                          'pillName': reminder.pillName,
                          'schedule': 'Upcoming'
                        }
                    );
                  }
                }
              }else{
                if(int.parse(reminder.pillsInterval[i].substring(0,2)) < 12){
                  morning.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }else if(int.parse(reminder.pillsInterval[i].substring(0,2)) >= 12 && int.parse(reminder.pillsInterval[i].substring(0,2)) < 16){
                  afternoon.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }else if(int.parse(reminder.pillsInterval[i].substring(0,2)) >= 16 && int.parse(reminder.pillsInterval[i].substring(0,2)) <=19){
                  evening.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }else{
                  night.add(
                      {
                        'pillName': reminder.pillName,
                        'schedule' : isUpcoming.value ? 'Upcoming' : itsToday.value ? 'Pending' : 'Missed'
                      }
                  );
                }
              }
            }
          }
        }
      }
    }
    isLoading.value = false;
  }
}
