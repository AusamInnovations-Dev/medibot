import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/history_model/history_model.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';
import 'package:medibot/app/services/firestore.dart';
import 'package:medibot/app/services/user.dart';

import '../../../services/internet_status_service.dart';

class HomepageController extends GetxController {
  RxList<HistoryData> historyList = <HistoryData>[].obs;
  RxList<PillsModel> reminderList = <PillsModel>[].obs;
  var loadingUserData = true.obs;
  var isSkipping = false.obs;
  var isTaking = false.obs;
  var haveInternet = true.obs;
  var pillIndex = 0.obs;
  var pillsTaken = 0.obs;
  var pillsToTake = 0.obs;
  Rx<String> greeting = ''.obs;

  @override
  Future<void> onInit() async {
    haveInternet.value = await InternetService().checkInternetSourceStatus();
    if (DateTime.now().hour <= 11) {
      greeting.value = 'Good Morning';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 16) {
      greeting.value = 'Good Afternoon';
    } else if (DateTime.now().hour >= 16 && DateTime.now().hour < 20) {
      greeting.value = 'Good Evening';
    } else {
      greeting.value = 'Good Night';
    }
    if(haveInternet.value){
      await getUserData();
    }
    super.onInit();
  }

  Future<void> getUserData() async {
    try{
      loadingUserData.value = true;
      var todayHistory = await FirebaseFireStore.to.getTodayHistory();
      var pillsReminder = FirebaseFireStore.to.getAllPillsReminder();
      Stream<QuerySnapshot<Map<String, dynamic>>>? medibotPillsReminder;
      if (UserStore.to.profile.medibotDetail.isNotEmpty) {
        medibotPillsReminder = FirebaseFireStore.to.getAllMedibotPills();
      }else{

      }

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
                  pillsToTake.value += reminderList.last.pillsInterval.length;
                  if (todayHistory != null) {
                    var history = HistoryModel.fromJson(
                        todayHistory.data() as Map<String, dynamic>);
                    for (var historyData in history.historyData) {
                      if (historyData.pillId == reminderList.last.uid) {
                        historyList.add(historyData);
                        pillsTaken.value += historyList.last.timeTaken.length;
                        break;
                      }
                    }
                    if (historyList.isEmpty ||
                        historyList.last.pillId != reminderList.last.uid) {
                      historyList.add(HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        med_status: [],
                        timeToTake: reminderList.last.pillsInterval,
                      ));
                      pillsTaken.value += historyList.last.timeTaken.length;
                    }
                  } else {
                    historyList.add(HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        med_status: [],
                        timeToTake: reminderList.last.pillsInterval));
                    pillsTaken.value = 0;
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                  }
                }
              } else {
                List<DateTime> dates = pillsModel.pillsDuration
                    .map((e) => DateTime.parse(e))
                    .toList();
                var checkInRange = dates.first.isBefore(DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day)) &&
                    dates.last.isAfter(DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day));
                if (checkInRange ||
                    dates.first.isAtSameMomentAs(DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day)) ||
                    dates.last.isAtSameMomentAs(DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day))) {
                  reminderList.add(pillsModel);
                  pillsToTake.value += reminderList.last.pillsInterval.length;
                  if (todayHistory != null) {
                    var history = HistoryModel.fromJson(
                        todayHistory.data() as Map<String, dynamic>);
                    for (var historyData in history.historyData) {
                      if (historyData.pillId == reminderList.last.uid) {
                        historyList.add(historyData);
                        pillsTaken.value += historyList.last.timeTaken.length;
                        break;
                      }
                    }
                    if (historyList.isEmpty ||
                        historyList.last.pillId != reminderList.last.uid) {
                      historyList.add(
                        HistoryData(
                          pillId: reminderList.last.uid,
                          timeTaken: [],
                          med_status: [],
                          timeToTake: reminderList.last.pillsInterval,
                        ),
                      );
                      pillsTaken.value += historyList.last.timeTaken.length;
                    }
                  } else {
                    historyList.add(
                      HistoryData(
                        pillId: reminderList.last.uid,
                        timeTaken: [],
                        med_status: [],
                        timeToTake: reminderList.last.pillsInterval,
                      ),
                    );
                    pillsTaken.value = 0;
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
        if (medibotPillsReminder == null) {
          loadingUserData.value = false;
          log('This is the history list: $historyList');
          log('This is the reminder list: $reminderList');
        }
      });
      if (medibotPillsReminder != null) {
        medibotPillsReminder.listen((snapshot) {
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
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                    if (todayHistory != null) {
                      var history = HistoryModel.fromJson(
                          todayHistory.data() as Map<String, dynamic>);
                      for (var historyData in history.historyData) {
                        if (historyData.pillId == reminderList.last.uid) {
                          historyList.add(historyData);
                          pillsTaken.value += historyList.last.timeTaken.length;
                          break;
                        }
                      }
                      if (historyList.isEmpty ||
                          historyList.last.pillId != reminderList.last.uid) {
                        historyList.add(HistoryData(
                          pillId: reminderList.last.uid,
                          timeTaken: [],
                          med_status: [],
                          timeToTake: reminderList.last.pillsInterval,
                        ));
                        pillsTaken.value += historyList.last.timeTaken.length;
                      }
                    } else {
                      historyList.add(HistoryData(
                          pillId: reminderList.last.uid,
                          timeTaken: [],
                          med_status: [],
                          timeToTake: reminderList.last.pillsInterval));
                      pillsTaken.value = 0;
                      pillsToTake.value +=
                          reminderList.last.pillsInterval.length;
                    }
                  }
                } else {
                  List<DateTime> dates = pillsModel.pillsDuration
                      .map((e) => DateTime.parse(e))
                      .toList();
                  var checkInRange = dates.first.isBefore(DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day)) &&
                      dates.last.isAfter(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day));
                  if (checkInRange ||
                      dates.first.isAtSameMomentAs(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day)) ||
                      dates.last.isAtSameMomentAs(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day))) {
                    reminderList.add(pillsModel);
                    pillsToTake.value += reminderList.last.pillsInterval.length;
                    if (todayHistory != null) {
                      var history = HistoryModel.fromJson(
                          todayHistory.data() as Map<String, dynamic>);
                      for (var historyData in history.historyData) {
                        if (historyData.pillId == reminderList.last.uid) {
                          historyList.add(historyData);
                          pillsTaken.value += historyList.last.timeTaken.length;
                          break;
                        }
                      }
                      if (historyList.isEmpty ||
                          historyList.last.pillId != reminderList.last.uid) {
                        historyList.add(
                          HistoryData(
                            pillId: reminderList.last.uid,
                            timeTaken: [],
                            med_status: [],
                            timeToTake: reminderList.last.pillsInterval,
                          ),
                        );
                        pillsTaken.value += historyList.last.timeTaken.length;
                      }
                    } else {
                      historyList.add(
                        HistoryData(
                          pillId: reminderList.last.uid,
                          timeTaken: [],
                          med_status: [],
                          timeToTake: reminderList.last.pillsInterval,
                        ),
                      );
                      pillsTaken.value = 0;
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
          log('This is the history list: $historyList');
          log('This is the reminder list: $reminderList');
          loadingUserData.value = false;
        });
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
      loadingUserData.value = false;
    }
  }

  bool findPillStatus() {
    if (historyList.isEmpty || historyList[pillIndex.value].timeTaken.isEmpty) {
      return false;
    }
    if (historyList[pillIndex.value].med_status.last == 'Y') {
      return true;
    }
    return false;
  }

  String checkDue() {

    // log(UserStore.to.skipPills.toString());
    if(reminderList.isNotEmpty){
      for (var interval in reminderList[pillIndex.value].pillsInterval) {
        var nextIndex = reminderList[pillIndex.value].pillsInterval.indexOf(interval) + 1;
        var diff = 180;
        if(nextIndex < reminderList[pillIndex.value].pillsInterval.length){
          diff = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(reminderList[pillIndex.value].pillsInterval[nextIndex].substring(0, 2)),
            int.parse(reminderList[pillIndex.value].pillsInterval[nextIndex].substring(5, 7)),
          ).difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            ),
          ).inMinutes;
        }
        log('This is the difference : $diff');
        if(diff >= 180){
          diff = 180;
        }
        if (DateTime.now().difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            )
        ).inMinutes <= diff/2) {
          if(UserStore.to.skipPills.any((pill) => pill['pillId'] == reminderList[pillIndex.value].uid && pill['pillInterval'] == interval && DateTime.parse(pill['pillDuration']) == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){

          }else{
            if (historyList.isNotEmpty) {
              List<DateTime> timeTaken = historyList[pillIndex.value].timeTaken.map((e) => DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day, int.parse(e.substring(0,2)),  int.parse(e.substring(5,7)))).toList();
              if (timeTaken.any((element) =>
              element
                  .difference(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7))))
                  .inMinutes <=
                  diff/2 &&
                  element
                      .difference(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(interval.substring(0, 2)),
                      int.parse(interval.substring(5, 7))))
                      .inMinutes >=
                      -diff/2)) {
              } else {
                if (int.parse(interval.substring(0, 2)) == 12) {
                  return '${interval.substring(0, 2)} : ${interval.substring(5, 7)} PM';
                } else if (int.parse(interval.substring(0, 2)) > 12) {
                  int diff = int.parse(interval.substring(0, 2)) - 12;
                  if (diff > 9) {
                    return '$diff : ${interval.substring(5, 7)} ${(int.parse(interval.substring(0, 2)) - 12) == 12 ? 'AM' : 'PM'}';
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
                  return '$diff : ${interval.substring(5, 7)} ${(int.parse(interval.substring(0, 2)) - 12) == 12 ? 'AM' : 'PM'}';
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
      }
    }
    return '';
  }

  String checkDueTime() {
    if(reminderList.isNotEmpty){
      for (var interval in reminderList[pillIndex.value].pillsInterval) {
        var nextIndex = reminderList[pillIndex.value].pillsInterval.indexOf(interval) + 1;
        var diff = 180;
        if(nextIndex < reminderList[pillIndex.value].pillsInterval.length){
          diff = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(reminderList[pillIndex.value].pillsInterval[nextIndex].substring(0, 2)),
            int.parse(reminderList[pillIndex.value].pillsInterval[nextIndex].substring(5, 7)),
          ).difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            ),
          ).inMinutes;
        }
        if(diff >= 180){
          diff = 180;
        }
        if (DateTime.now().difference(
            DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              int.parse(interval.substring(0, 2)),
              int.parse(interval.substring(5, 7)),
            )
        ).inMinutes <= diff/2) {
          if(UserStore.to.skipPills.any((pill) => pill['pillId'] == reminderList[pillIndex.value].uid && pill['pillInterval'] == interval && DateTime.parse(pill['pillDuration']) == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {

          }else{
            if (historyList.isNotEmpty) {
              List<DateTime> timeTaken = historyList[pillIndex.value].timeTaken.map((e) => DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day, int.parse(e.substring(0,2)),  int.parse(e.substring(5,7)))).toList();
              if (timeTaken.any((element) =>
              element
                  .difference(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  int.parse(interval.substring(0, 2)),
                  int.parse(interval.substring(5, 7))))
                  .inMinutes <=
                  diff/2 &&
                  element
                      .difference(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(interval.substring(0, 2)),
                      int.parse(interval.substring(5, 7))))
                      .inMinutes >=
                      -diff/2)) {
              } else {
                return '${interval.substring(0, 2)}:${interval.substring(5, 7)}';
              }
            } else {
              return '${interval.substring(0, 2)}:${interval.substring(5, 7)}';
            }
          }
        }
      }
    }
    return '';
  }

  Future<void> takeNowPill() async {
    try {
      isTaking.value = true;
      if (checkDueTime() == '') {
        Future.delayed(const Duration(seconds: 1), () => isTaking.value = false);
        Get.snackbar(
          "Reminders",
          "You don't have anymore pills",
          icon: const Icon(
            Icons.crisis_alert_outlined,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
      } else {
        var hours = int.parse(checkDueTime().substring(0, 2));
        var minutes = int.parse(checkDueTime().substring(3, 5));
        var diff = DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes;
        log('This is difference: $diff');
        if (diff <= -30 && DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes).isAfter(DateTime.now())) {
          Future.delayed(const Duration(seconds: 1), () => isTaking.value = false);
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
          String docId = "${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}";
          var dayHistory = await FirebaseFireStore.to.getHistoryDataByDay(docId);
          if (dayHistory != null) {
            HistoryModel historyModel = HistoryModel.fromJson(dayHistory.data() as Map<String, dynamic>);
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
              List<String> timeTaken = [];
              List<String> status = [];
              for(int i=0; i<reminderList[pillIndex.value].pillsInterval.indexOf('${checkDueTime().substring(0, 2)}HH:${checkDueTime().substring(3,5)}MM'); i++){
                timeTaken.add('00HH:00MM');
                status.add('M');
              }
              timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
              status.add(DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes < 60 ? 'Y' : 'L');
              list.add(
                HistoryData(
                  pillId: reminderList[pillIndex.value].uid,
                  timeToTake: reminderList[pillIndex.value].pillsInterval,
                  timeTaken: timeTaken,
                  med_status: status,
                ),
              );
              historyModel = historyModel.copyWith(historyData: list);
              await FirebaseFireStore.to.uploadHistoryData(
                historyModel,
                docId,
              );
              historyList[pillIndex.value] = historyModel.historyData.firstWhere((element) => element.pillId == reminderList[pillIndex.value].uid);
              pillsTaken.value++;
              isTaking.value = false;
            } else {
              if (historyData.timeTaken.length < historyData.timeToTake.length) {
                HistoryData historyDataTemp = historyData;
                List<String> tempTimeTaken = [];
                List<String> tempStatus = [];
                List<HistoryData> list = [];
                list.addAll(historyModel.historyData);
                tempStatus.addAll(historyDataTemp.med_status);
                tempTimeTaken.addAll(historyDataTemp.timeTaken);
                for(int i=tempTimeTaken.length; i<reminderList[pillIndex.value].pillsInterval.indexOf('${checkDueTime().substring(0, 2)}HH:${checkDueTime().substring(3,5)}MM'); i++){
                  tempTimeTaken.add('00HH:00MM');
                  tempStatus.add('M');
                }
                tempTimeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
                tempStatus.add(DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes < 60 ? 'Y' : 'L',);
                list[index] = HistoryData(
                  pillId: historyModel.historyData[index].pillId,
                  timeTaken: tempTimeTaken,
                  med_status: tempStatus,
                  timeToTake: historyModel.historyData[index].timeToTake,
                );
                HistoryModel tempHistory = HistoryModel(
                  userId: historyModel.userId,
                  historyData: list,
                );
                await FirebaseFireStore.to.uploadHistoryData(
                  tempHistory,
                  docId,
                );
                historyList[pillIndex.value] = tempHistory.historyData.firstWhere((element) => element.pillId == reminderList[pillIndex.value].uid);
                pillsTaken.value++;
                isTaking.value = false;
              } else {
                Get.snackbar(
                  "Reminders",
                  "Can't take anymore pills",
                  icon: const Icon(
                    Icons.crisis_alert,
                    color: Colors.black,
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xffA9CBFF),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  colorText: Colors.black,
                );
                isTaking.value = false;
              }
            }
          } else {
            List<String> timeTaken = [];
            List<String> status = [];
            for(int i=0; i<reminderList[pillIndex.value].pillsInterval.indexOf('${checkDueTime().substring(0, 2)}HH:${checkDueTime().substring(3,5)}MM'); i++){
              timeTaken.add('00HH:00MM');
              status.add('M');
            }
            timeTaken.add('${DateTime.now().hour > 9 ? '${DateTime.now().hour}HH' : '0${DateTime.now().hour}HH'}:${DateTime.now().minute > 9 ? '${DateTime.now().minute}HH' : '0${DateTime.now().minute}MM'}');
            status.add(DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes < 60 ? 'Y' : 'L');
            HistoryModel historyModel = HistoryModel(userId: docId, historyData: [
              HistoryData(
                pillId: reminderList[pillIndex.value].uid,
                timeToTake: reminderList[pillIndex.value].pillsInterval,
                timeTaken: timeTaken,
                med_status: status,
              ),
            ]);
            await FirebaseFireStore.to.uploadHistoryData(
              historyModel,
              docId,
            );
            historyList[pillIndex.value] = historyModel.historyData.firstWhere((element) => element.pillId == reminderList[pillIndex.value].uid);
            pillsTaken.value++;
            isTaking.value = false;
          }
        }
      }
    } catch (err) {
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
      Future.delayed(const Duration(seconds: 1), () => isTaking.value = false);
    }
  }

  Future<void> skipPill() async {
    isSkipping.value = true;
    if(checkDueTime() == ''){
      Get.snackbar(
        "Reminders",
        "You don't have any pill to skip",
        icon: const Icon(
          Icons.crisis_alert_outlined,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
      Future.delayed(const Duration(seconds: 1), () => isSkipping.value = false);
    }else{
      log(checkDueTime());
      await UserStore.to.setSkipPills({
        'pillId': reminderList[pillIndex.value].uid,
        'pillInterval': '${checkDueTime().substring(0,2)}HH:${checkDueTime().substring(3, 5)}MM',
        'pillDuration': DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String()
      });
      Get.snackbar(
        "Reminders",
        "You Have successfully skip this pill",
        icon: const Icon(
          Icons.check_sharp,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
      isSkipping.value = false;
      update();
    }
  }
}
