import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    if (DateTime.now().hour < 11) {
      greeting.value = 'Good Morning';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 16) {
      greeting.value = 'Good Afternoon';
    } else if (DateTime.now().hour >= 16 && DateTime.now().hour < 20) {
      greeting.value = 'Good Evening';
    } else {
      greeting.value = 'Good Night';
    }
    log(haveInternet.value.toString());
    if(haveInternet.value){
      log('Hello');
      await getUserData();
    }
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
            log(pill.doc.data().toString());
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
                      timeToTake: reminderList.last.pillsInterval,
                    ));
                    pillsTaken.value += historyList.last.timeTaken.length;
                  }
                } else {
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
                      timeToTake: reminderList.last.pillsInterval,
                    ),
                  );
                  pillsTaken.value = 0;
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
      loadingUserData.value = false;
      log('This is the history list: $historyList');
      log('This is the reminder list: $reminderList');
      log('Pills : ${pillsTaken.value} , ${pillsToTake.value}');
    });
  }

  bool findPillStatus() {
    if (historyList.isEmpty || historyList[pillIndex.value].timeTaken.isEmpty) {
      return false;
    }
    for (var time in historyList[pillIndex.value].timeToTake) {
      var date = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          int.parse(time.substring(0, 2)),
          int.parse(time.substring(5, 7)));
      var diff = historyList[pillIndex.value]
          .timeTaken
          .last
          .difference(date)
          .inMinutes;
      if (diff >= -30 && diff <= 30) {
        return true;
      }
    }
    return false;
  }

  String checkDue() {

    // log(UserStore.to.skipPills.toString());
    for (var interval in reminderList[pillIndex.value].pillsInterval) {
      var nextIndex = reminderList[pillIndex.value].pillsInterval.indexOf(interval) + 1;
      var diff = 60;
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
      // log('This is the difference : $diff');
      if (DateTime.now().difference(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(interval.substring(0, 2)),
            int.parse(interval.substring(5, 7)),
          )
        ).inMinutes <= diff/2) {
        log('This is interval $interval');
        for (var pill in UserStore.to.skipPills) {
          if (pill['pillId'] == reminderList[pillIndex.value].uid &&
              pill['pillInterval'] == interval &&
              DateTime.parse(pill['pillDuration']) ==
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)) {
            return '';
          }
        }
        if (historyList.isNotEmpty) {
          if (historyList[pillIndex.value].timeTaken.any((element) =>
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
      var nextIndex = reminderList[pillIndex.value].pillsInterval.indexOf(interval) + 1;
      var diff = 60;
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
      if (DateTime.now().difference(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(interval.substring(0, 2)),
            int.parse(interval.substring(5, 7)),
          )
      ).inMinutes <= diff/2) {
        for (var pill in UserStore.to.skipPills) {
          if (pill['pillId'] == reminderList[pillIndex.value].uid &&
              pill['pillInterval'] == interval &&
              DateTime.parse(pill['pillDuration']) ==
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)) {
            return '';
          }
        }
        if (historyList.isNotEmpty) {
          if (historyList[pillIndex.value].timeTaken.any((element) =>
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
            Icons.check_sharp,
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
        log('$hours : $minutes');
        var diff = DateTime.now().difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes)).inMinutes;
        log('This is difference: $diff');
        if (diff <= -30 && DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes).isAfter(DateTime.now())) {
          Future.delayed(
              const Duration(seconds: 1), () => isTaking.value = false);
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
          var dayHistory =
              await FirebaseFireStore.to.getHistoryDataByDay(docId);
          if (dayHistory != null) {
            HistoryModel historyModel = HistoryModel.fromJson(
                dayHistory.data() as Map<String, dynamic>);
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
                historyModel,
                docId,
              );
              historyList[pillIndex.value] = historyModel.historyData
                  .firstWhere((element) =>
                      element.pillId == reminderList[pillIndex.value].uid);
              pillsTaken.value++;
              isTaking.value = false;
            } else {
              if (historyData.timeTaken.length <
                  historyData.timeToTake.length) {
                HistoryData historyDataTemp = historyData;
                List<DateTime> tempTimeTaken = [];
                List<HistoryData> list = [];
                list.addAll(historyModel.historyData);
                tempTimeTaken.addAll(historyDataTemp.timeTaken);
                tempTimeTaken.add(DateTime.now());
                list[index] = HistoryData(
                  pillId: historyModel.historyData[index].pillId,
                  timeTaken: tempTimeTaken,
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
                historyList[pillIndex.value] = tempHistory.historyData
                    .firstWhere((element) =>
                        element.pillId == reminderList[pillIndex.value].uid);
                pillsTaken.value++;
                isTaking.value = false;
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
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  colorText: Colors.black,
                );
                isTaking.value = false;
              }
            }
          } else {
            HistoryModel historyModel =
                HistoryModel(userId: docId, historyData: [
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
            historyList[pillIndex.value] = historyModel.historyData.firstWhere(
                (element) =>
                    element.pillId == reminderList[pillIndex.value].uid);
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
    int flag = 0;
    if (reminderList.isNotEmpty) {
      for (var interval in reminderList[pillIndex.value].pillsInterval) {

        var diff = DateTime.now()
            .difference(
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                int.parse(interval.substring(0, 2)),
                int.parse(interval.substring(5, 7)),
              ),
            ).inMinutes;
        if (diff < 30) {
          log('This is interval $interval');
          for (var pill in UserStore.to.skipPills) {
            if (pill['pillId'] == reminderList[pillIndex.value].uid &&
                pill['pillInterval'] == interval &&
                DateTime.parse(pill['pillDuration']) ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) {
              Future.delayed(
                  const Duration(seconds: 1), () => isSkipping.value = false);
            }
          }
          if (historyList.isNotEmpty) {
            if (historyList[pillIndex.value].timeTaken.any((element) =>
                element
                        .difference(DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            int.parse(interval.substring(0, 2)),
                            int.parse(interval.substring(5, 7))))
                        .inMinutes <=
                    30 &&
                element
                        .difference(DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            int.parse(interval.substring(0, 2)),
                            int.parse(interval.substring(5, 7))))
                        .inMinutes >=
                    -30)) {
            } else {
              await UserStore.to.setSkipPills({
                'pillId': reminderList[pillIndex.value].uid,
                'pillInterval': interval,
                'pillDuration': DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day)
                    .toIso8601String()
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
              flag = 1;
              isSkipping.value = false;
              update();
              break;
            }
          } else {
            await UserStore.to.setSkipPills({
              'pillId': reminderList[pillIndex.value].uid,
              'pillInterval': interval,
              'pillDuration': DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day)
                  .toIso8601String()
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
            flag = 1;
            isSkipping.value = false;
            update();
            break;
          }
        }
      }

      if (flag == 0) {
        isSkipping.value = false;
        Get.snackbar(
          "Reminders",
          "This pill is not available for skip",
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
    } else {
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
      Future.delayed(
          const Duration(seconds: 1), () => isSkipping.value = false);
    }
  }
}
