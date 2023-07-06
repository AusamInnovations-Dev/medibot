import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/history_model/history_model.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';
import 'package:medibot/app/services/firestore.dart';

class HomepageController extends GetxController {
  RxList<HistoryData> historyList = <HistoryData>[].obs;
  RxList<PillsModel> reminderList = <PillsModel>[].obs;
  var loadingUserData = true.obs;
  var pillIndex = 0.obs;
  var pillsTaken = 0.obs;
  var pillsToTake = 0.obs;

  @override
  Future<void> onInit() async {
    await getUserData();
    log('Pills : ${pillsTaken.value} , ${pillsToTake.value}');

    super.onInit();
  }

  Future<void> getUserData() async {
    loadingUserData.value = true;
    var todayHistory = await FirebaseFireStore.to.getTodayHistory();
    var pillsReminder = FirebaseFireStore.to.getAllPillsReminder();
    var cabinetPillsReminder = FirebaseFireStore.to.getAllCabinetPills();

    pillsReminder.listen((snapshot) {
      for (var pill in snapshot.docChanges) {
        switch (pill.type) {
          case DocumentChangeType.added:
            PillsModel pillsModel = PillsModel.fromJson(pill.doc.data()!);
            if (pillsModel.isIndividual) {
              List<DateTime> dates = pillsModel.pillsDuration
                  .map((e) => DateTime.parse(e))
                  .toList();
              if (dates.contains(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day))) {
                reminderList.add(pillsModel);
                log('Adding reminder 1 : $pillsModel');
                if (todayHistory != null) {
                  var history = HistoryModel.fromJson(todayHistory.data() as Map<String, dynamic>);
                  log('History: $history');
                  for (var historyData in history.historyData) {
                    if (historyData.pillId == reminderList.last.uid) {
                      log('Adding history 1');
                      historyList.add(historyData);
                      pillsTaken.value += historyList.last.timeTaken.length;
                      pillsToTake.value +=
                          reminderList.last.pillsInterval.length;
                      break;
                    }
                  }
                  if (historyList.isEmpty || historyList.last.pillId != reminderList.last.uid) {
                    log('Adding history 2');
                    historyList.add(
                      HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        timeToTake: reminderList.last.pillsInterval,
                      )
                    );
                    // historyList.add(
                    //   history.historyData.firstWhere((element) => element.pillId == reminderList.last.uid)
                    // );
                    pillsTaken.value += historyList.last.timeTaken.length;
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                  }
                } else {
                  log('Adding history 3');
                  historyList.add(HistoryData(
                      pillId: reminderList.last.uid,
                      timeTaken: [],
                      timeToTake: reminderList.last.pillsInterval));
                  pillsTaken.value = 0;
                  pillsToTake.value += reminderList.last.pillsInterval.length;
                }
              }
            } else {
              List<DateTime> dates = pillsModel.pillsDuration
                  .map((e) => DateTime.parse(e))
                  .toList();
              if (dates.first.isBefore(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day)) ||
                  dates.last.isAfter(DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day))) {
                reminderList.add(pillsModel);
                if (todayHistory != null) {
                  var history = HistoryModel.fromJson(
                      todayHistory.data() as Map<String, dynamic>);
                  for (var historyData in history.historyData) {
                    if (historyData.pillId == reminderList.last.uid) {
                      historyList.add(historyData);
                      pillsTaken.value += historyList.last.timeTaken.length;
                      pillsToTake.value +=
                          reminderList.last.pillsInterval.length;
                      break;
                    }
                  }
                  if (historyList.last.pillId != reminderList.last.uid) {
                    historyList.add(HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        timeToTake: reminderList.last.pillsInterval));
                    pillsTaken.value += historyList.last.timeTaken.length;
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                  }
                } else {
                  log('Adding history 3');
                  historyList.add(HistoryData(
                      pillId: reminderList.last.uid,
                      timeTaken: [],
                      timeToTake: reminderList.last.pillsInterval));
                  pillsTaken.value = 0;
                  pillsToTake.value += reminderList.last.pillsInterval.length;
                }
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
      for (var pill in snapshot.docChanges) {
        switch (pill.type) {
          case DocumentChangeType.added:
            PillsModel pillsModel = PillsModel.fromJson(pill.doc.data()!);
            if (pillsModel.isIndividual) {
              List<DateTime> dates = pillsModel.pillsDuration
                  .map((e) => DateTime.parse(e))
                  .toList();
              if (dates.contains(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day))) {
                reminderList.add(pillsModel);
                if (todayHistory != null) {
                  var history = HistoryModel.fromJson(
                      todayHistory.data() as Map<String, dynamic>);
                  for (var historyData in history.historyData) {
                    if (historyData.pillId == reminderList.last.uid) {
                      historyList.add(historyData);
                      pillsTaken.value += historyList.last.timeTaken.length;
                      pillsToTake.value +=
                          reminderList.last.pillsInterval.length;
                      break;
                    }
                  }
                  if (historyList.last.pillId != reminderList.last.uid) {
                    historyList.add(HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        timeToTake: reminderList.last.pillsInterval));
                    pillsTaken.value += historyList.last.timeTaken.length;
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                  }
                } else {
                  log('Adding history 3');
                  historyList.add(HistoryData(
                      pillId: reminderList.last.uid,
                      timeTaken: [],
                      timeToTake: reminderList.last.pillsInterval));
                  pillsTaken.value = 0;
                  pillsToTake.value += reminderList.last.pillsInterval.length;
                }
              }
            } else {
              List<DateTime> dates = pillsModel.pillsDuration
                  .map((e) => DateTime.parse(e))
                  .toList();
              if (dates.first.isBefore(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day)) ||
                  dates.last.isAfter(DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day))) {
                reminderList.add(pillsModel);
                if (todayHistory != null) {
                  var history = HistoryModel.fromJson(
                      todayHistory.data() as Map<String, dynamic>);
                  for (var historyData in history.historyData) {
                    if (historyData.pillId == reminderList.last.uid) {
                      historyList.add(historyData);
                      pillsTaken.value += historyList.last.timeTaken.length;
                      pillsToTake.value +=
                          reminderList.last.pillsInterval.length;
                      break;
                    }
                  }
                  if (historyList.last.pillId != reminderList.last.uid) {
                    historyList.add(HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        timeToTake: reminderList.last.pillsInterval));
                    pillsTaken.value += historyList.last.timeTaken.length;
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                  }
                } else {
                  log('Adding history 3');
                  historyList.add(HistoryData(
                      pillId: reminderList.last.uid,
                      timeTaken: [],
                      timeToTake: reminderList.last.pillsInterval));
                  pillsTaken.value = 0;
                  pillsToTake.value += reminderList.last.pillsInterval.length;
                }
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
      loadingUserData.value = false;
      log('This is the history list: $historyList');
      log('This is the reminder list: $reminderList');
      log('Pills : ${pillsTaken.value} , ${pillsToTake.value}');
    });
  }

  bool findPillStatus() {
    if (historyList[pillIndex.value].timeTaken.isEmpty) {
      return false;
    }
    for(var time in historyList[pillIndex.value].timeToTake){
      var date = DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day, int.parse(time.substring(0,2)), int.parse(time.substring(5,7)));
      var diff = historyList[pillIndex.value].timeTaken.last.difference(date).inMinutes;
      log('diff : $diff');
      if(diff > -15 && diff <=15){
        return true;
      }else{
        return false;
      }
    }
    return false;
  }

  String checkDue() {
    for (var interval in reminderList[pillIndex.value].pillsInterval) {
      if (DateTime.now()
          .difference(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(interval.substring(0, 2)),
          int.parse(interval.substring(5, 7))))
          .inMinutes <
          30) {
        log('This is interval $interval');

        if (historyList.isNotEmpty) {
          if (historyList[pillIndex.value].timeTaken.any(
                  (element) => element.difference(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(interval.substring(0, 2)),
                      int.parse(interval.substring(5, 7)))).inMinutes <= 30 &&
                  element.difference(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7)))).inMinutes >= -30)) {

          } else {
            log('Interval is : $interval');
            if (int.parse(interval.substring(0, 2)) == 12) {
              return '${interval.substring(0, 2)} : ${interval.substring(5, 7)} PM';
            } else if (int.parse(interval.substring(0, 2)) > 12) {
              int diff = int.parse(interval.substring(0, 2)) - 12;
              if (diff > 9) {
                return '$diff : ${interval.substring(5, 7)} PM';
              } else {
                return '0$diff : ${interval.substring(5, 7)} PM';
              }
            } else {
              if (int.parse(interval.substring(0, 2)) > 9) {
                return '${int.parse(interval.substring(0, 2))} : ${interval.substring(5, 7)} AM';
              } else {
                return '0${int.parse(interval.substring(0, 2))} : ${interval.substring(5, 7)} AM';
              }
            }
          }
        } else {
          if (int.parse(interval.substring(0, 2)) == 12) {
            return '${interval.substring(0, 2)} : ${interval.substring(5, 7)} PM';
          } else if (int.parse(interval.substring(0, 2)) > 12) {
            int diff = int.parse(interval.substring(0, 2)) - 12;
            if (diff > 9) {
              return '$diff : ${interval.substring(5, 7)} PM';
            } else {
              return '0$diff : ${interval.substring(5, 7)} PM';
            }
          } else {
            if (int.parse(interval.substring(0, 2)) > 9) {
              return '${int.parse(interval.substring(0, 2))} : ${interval.substring(5, 7)} AM';
            } else {
              return '0${int.parse(interval.substring(0, 2))} : ${interval.substring(5, 7)} AM';
            }
          }
        }
      }
    }
    return '';
  }


  String checkDueTime() {
    for (var interval in reminderList[pillIndex.value].pillsInterval) {
      if (DateTime.now()
          .difference(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(interval.substring(0, 2)),
          int.parse(interval.substring(5, 7))))
          .inMinutes < 30) {
        log('This is interval $interval');

        if (historyList.isNotEmpty) {
          if (historyList[pillIndex.value].timeTaken.any(
                  (element) => element.difference(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7)))).inMinutes < 30 &&
                  element.difference(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(interval.substring(0, 2)),
                      int.parse(interval.substring(5, 7)))).inMinutes > -30)) {

          } else {
            return '${interval.substring(0,2)}:${interval.substring(5,7)}';
          }
        } else {
          return '${interval.substring(0,2)}:${interval.substring(5,7)}';
        }
      }
    }
    return '';
  }


  Future<void> takeNowPill() async {
    try{
      log(checkDueTime());
      if(checkDueTime() == ''){
        Get.snackbar(
          "Reminders",
          "You Already have taken all pills",
          icon: const Icon(
            Icons.check_sharp,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
      }else{
        var hours = int.parse(checkDueTime().substring(0, 2));
        var minutes = int.parse(checkDueTime().substring(3, 5));
        var diff = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, hours, minutes)
            .difference(DateTime.now())
            .inMinutes;
        log('This is difference: $diff');
        if (diff < 0) {
          diff = -diff;
        }
        if (diff >= 30) {
          Get.snackbar(
            "Reminders",
            "You cannot take pill this early",
            icon: const Icon(
              Icons.timelapse,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        } else {
          log('This is difference : $diff');
          String docId =
              "${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";
          var dayHistory = await FirebaseFireStore.to.getHistoryDataByDay(docId);
          if (dayHistory != null) {
            HistoryModel historyModel =
            HistoryModel.fromJson(dayHistory.data() as Map<String, dynamic>);
            late HistoryData historyData;
            int? index;
            for (var pill in historyModel.historyData) {
              if (pill.pillId == reminderList[pillIndex.value].uid) {
                historyData = pill;
                index = historyModel.historyData.indexOf(pill);
                break;
              }
            }
            if (index == null) {
              List<HistoryData> list = [];
              list.addAll(historyModel.historyData);
              list.add(
                HistoryData(
                  pillId: reminderList[pillIndex.value].uid,
                  timeToTake: reminderList[pillIndex.value].pillsInterval,
                  timeTaken: [DateTime.now()],
                ),
              );
              historyModel = historyModel.copyWith(historyData: list);
              await FirebaseFireStore.to.uploadHistoryData(
                historyModel.copyWith(historyData: historyModel.historyData),
                docId,
              );
              historyList[pillIndex.value] = historyModel.historyData.last;
              pillsTaken.value++;
            } else {
              if (historyData.timeTaken.length < historyData.timeToTake.length) {
                historyData.timeTaken.add(DateTime.now());
                historyModel.historyData[index] = historyData;
                await FirebaseFireStore.to.uploadHistoryData(
                  historyModel.copyWith(historyData: historyModel.historyData),
                  docId,
                );
                historyList[pillIndex.value] = historyModel.historyData[index];
                pillsTaken.value++;
              } else {
                Get.snackbar(
                  "Reminders",
                  "Can't take anymore pills",
                  icon: const Icon(
                    Icons.check_sharp,
                    color: Colors.black,
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xffA9CBFF),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  colorText: Colors.black,
                );
              }
            }
          } else {
            HistoryModel historyModel = HistoryModel(userId: docId, historyData: [
              HistoryData(
                pillId: reminderList[pillIndex.value].uid,
                timeToTake: reminderList[pillIndex.value].pillsInterval,
                timeTaken: [DateTime.now()],
              ),
            ]);
            await FirebaseFireStore.to.uploadHistoryData(
              historyModel,
              docId,
            );
            historyList[pillIndex.value] = historyModel.historyData.firstWhere((element) => element.pillId == reminderList[pillIndex.value].uid);
            pillsTaken.value++;
          }
        }
      }
    }catch(err){
      Get.snackbar(
        "Reminders",
        "$err",
        icon: const Icon(
          Icons.crisis_alert_outlined,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
    }
  }

  updateHistory() async {}
}