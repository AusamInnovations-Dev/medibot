import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart' as localized;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/history_model/history_model.dart';
import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';
import '../../../services/user.dart';
import '../../../widgets/text_field.dart';

class HistoryController extends GetxController {
  var loadingUserData = false.obs;
  var generatingPdf = false.obs;
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  RxList<PillsModel> reminderList = <PillsModel>[].obs;

  var totalTakenPillsDosage = 0.obs;
  var todayRemainingPills = 0.obs;
  var totalPillsDosage = 0.obs;
  var upComingDosage = 0.obs;
  var daysMissed = 0.obs;

  @override
  Future<void> onInit() async {
    loadingUserData.value = true;
    await getUserData();
    Future.delayed(const Duration(seconds: 1), () {
      loadingUserData.value = false;
    });
    super.onInit();
  }

  getUserData() async {
    var history = await FirebaseFireStore.to.getHistoryData();
    var pillsReminder = FirebaseFireStore.to.getAllPillsReminder();
    Stream<QuerySnapshot<Map<String, dynamic>>>? cabinetPillsReminder;
    if (UserStore.to.profile.cabinetDetail.isNotEmpty) {
      cabinetPillsReminder = FirebaseFireStore.to.getAllCabinetPills();
    }
    if (history != null) {
      for (var history in history.docs) {
        log(history.data().toString());
        historyList.add(HistoryModel.fromJson(history.data()));
      }
    }
    pillsReminder.listen((snapshot) {
      for (var pill in snapshot.docChanges) {
        switch (pill.type) {
          case DocumentChangeType.added:
            PillsModel pillsModel = PillsModel.fromJson(pill.doc.data()!);
            reminderList.add(pillsModel);
            break;
          case DocumentChangeType.modified:
            // TODO: Handle this case.
            break;
          case DocumentChangeType.removed:
            // TODO: Handle this case.
            break;
        }
      }
      if (cabinetPillsReminder == null) {
        totalPillsDosage.value = 0;
        for (var reminder in reminderList) {
          if (reminder.isIndividual) {
            for (var time in reminder.pillsDuration) {
              totalPillsDosage.value += reminder.pillsInterval.length;
              DateTime date = DateTime.parse(time);
              if (date.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
                upComingDosage.value += reminder.pillsInterval.length;
                log('upcoming in individuals : ${reminder.pillsInterval.length}');
                log('Total upcoming : ${upComingDosage.value}');
              }
            }
          } else {
            log('Else part');
            DateTime date1 = DateTime.parse(reminder.pillsDuration.first);
            DateTime date2 = DateTime.parse(reminder.pillsDuration.last);
            totalPillsDosage.value += reminder.pillsInterval.length * (date2.difference(date1).inDays + 1);
            if (date1.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) && date2.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
              log('upcoming in range 1: ${reminder.pillsInterval.length} : ${date2.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}');
              upComingDosage.value += reminder.pillsInterval.length * (date2.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays);
              log('Total upcoming : ${upComingDosage.value}');
            } else if (date2.isAfter(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day))) {
              log('upcoming in range 2: ${reminder.pillsInterval.length} : ${date2.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}');
              log('Before upcoming : ${upComingDosage.value}');
              upComingDosage.value += reminder.pillsInterval.length * (date2.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays);
              log('After upcoming : ${upComingDosage.value}');
            } else if (date1.isAfter(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day))) {
              log('upcoming in range 3: ${reminder.pillsInterval.length} : ${date2.difference(date1).inDays}');
              upComingDosage.value += reminder.pillsInterval.length * (date2.difference(date1).inDays);
              log('Total upcoming : ${upComingDosage.value}');
            }
          }
        }
        checkForAllHistory();
        log('Total reminders : ${totalPillsDosage.value}');
        log('Total history : ${historyList.first.toJson()}');
        log('Total upcoming : ${upComingDosage.value}');
      }
    });
    if (cabinetPillsReminder != null) {
      cabinetPillsReminder.listen((snapshot) {
        for (var pill in snapshot.docChanges) {
          switch (pill.type) {
            case DocumentChangeType.added:
              PillsModel pillsModel = PillsModel.fromJson(pill.doc.data()!);
              reminderList.add(pillsModel);
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
        for (var reminder in reminderList) {
          if (reminder.isIndividual) {
            for (var time in reminder.pillsDuration) {
              totalPillsDosage.value += reminder.pillsInterval.length;
              DateTime date = DateTime.parse(time);
              if (date.isAfter(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day))) {
                upComingDosage.value += reminder.pillsInterval.length;
                log('upcoming in individuals : ${reminder.pillsInterval.length}');
                log('Total upcoming : ${upComingDosage.value}');
              }
            }
          } else {
            log('Else part');
            DateTime date1 = DateTime.parse(reminder.pillsDuration.first);
            DateTime date2 = DateTime.parse(reminder.pillsDuration.last);
            totalPillsDosage.value += reminder.pillsInterval.length *
                (date2.difference(date1).inDays + 1);
            if (date1.isBefore(DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day)) &&
                date2.isAfter(DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day))) {
              log('upcoming in range 1: ${reminder.pillsInterval.length} : ${date2.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}');
              upComingDosage.value += reminder.pillsInterval.length *
                  (date2
                      .difference(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day))
                      .inDays);
              log('Total upcoming : ${upComingDosage.value}');
            } else if (date2.isAfter(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day))) {
              log('upcoming in range 2: ${reminder.pillsInterval.length} : ${date2.difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays}');
              log('Before upcoming : ${upComingDosage.value}');
              upComingDosage.value += reminder.pillsInterval.length *
                  (date2
                      .difference(DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day))
                      .inDays);
              log('After upcoming : ${upComingDosage.value}');
            } else if (date1.isAfter(DateTime(DateTime.now().year,
                DateTime.now().month, DateTime.now().day))) {
              log('upcoming in range 3: ${reminder.pillsInterval.length} : ${date2.difference(date1).inDays}');
              upComingDosage.value += reminder.pillsInterval.length *
                  (date2.difference(date1).inDays);
              log('Total upcoming : ${upComingDosage.value}');
            }
          }
        }
        checkForAllHistory();
        log('Total reminders : ${totalPillsDosage.value}');
        log('Total history : $historyList');
        log('Total upcoming : ${upComingDosage.value}');
      });
    }
  }

  String checkForSuccess(DateTime date) {
    HistoryModel? historyItem;
    if (historyList.isNotEmpty) {
      for (var element in historyList) {
        log('Hello I am In at : $date');
        if (element.userId.trim() ==
            '${date.year}:${date.month < 10 ? '0${date.month}' : date.month}:${date.day < 10 ? '0${date.day}' : date.day}'
                .trim()) {
          historyItem = element;
          break;
        }
      }
    }
    // log('This is the history part : $historyItem');
    List<PillsModel> pills = todayReminders(date);
    if (historyItem != null) {
      var totalPills = 0;
      var takenPills = 0;

      for (var pill in pills) {
        totalPills += pill.pillsInterval.length;
      }

      for (var pill in historyItem.historyData) {
        takenPills += pill.timeTaken.length;
      }

      if (totalPills == takenPills) {
        return 'AllPillsTaken';
      } else if (takenPills == 0) {
        return 'NoPillsTaken';
      } else {
        return 'PartiallyTaken';
      }
    } else {
      for (var reminder in reminderList) {
        if (reminder.isIndividual) {
          List<DateTime> dates =
              reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
          if (dates.contains(DateTime(date.year, date.month, date.day))) {
            return 'NoPillsTaken';
          }
        } else {
          List<DateTime> dates =
              reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
          bool isAt =
              dates.first.isBefore(DateTime(date.year, date.month, date.day)) &&
                  dates.last.isAfter(DateTime(date.year, date.month, date.day));
          if (isAt ||
              dates.first.isAtSameMomentAs(
                  DateTime(date.year, date.month, date.day)) ||
              dates.last.isAtSameMomentAs(
                  DateTime(date.year, date.month, date.day))) {
            return 'NoPillsTaken';
          }
        }
      }
      return 'NoPillsScheduled';
    }
  }

  List<PillsModel> todayReminders(DateTime date) {
    List<PillsModel> todayReminder = [];
    for (var reminder in reminderList) {
      if (reminder.isIndividual) {
        List<DateTime> dates =
            reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();
        if (dates.contains(DateTime(date.year, date.month, date.day))) {
          todayReminder.add(reminder);
        }
      } else {
        List<DateTime> dates =
            reminder.pillsDuration.map((e) => DateTime.parse(e)).toList();

        DateTime date1 = dates.first;
        DateTime date2 = dates.last;

        if (date1.isBefore(DateTime(date.year, date.month, date.day)) &&
            date2.isAfter(DateTime(date.year, date.month, date.day))) {
          todayReminder.add(reminder);
        } else if (date1
            .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
          todayReminder.add(reminder);
        } else if (date2
            .isAtSameMomentAs(DateTime(date.year, date.month, date.day))) {
          todayReminder.add(reminder);
        }
      }
    }
    log('This is all today reminder: $todayReminder');
    return todayReminder;
  }

  checkForAllHistory() {
    List<PillsModel> todayReminder = todayReminders(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    log('This is the todays reminder: $todayReminder');
    for (var reminder in todayReminder) {
      for (var interval in reminder.pillsInterval) {
        if (DateTime.now().isBefore(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(interval.substring(0, 2)),
            int.parse(interval.substring(5, 7))))) {
          log(interval);
          todayRemainingPills.value++;
        }
      }
    }

    for(var history in historyList){
      for(var pill in history.historyData){
        totalTakenPillsDosage.value += pill.timeTaken.length;
      }
      log(history.userId.substring(0,4));
      log(history.userId.substring(5,7));
      log(history.userId.substring(8,10));
    }

  }

  Future<void> exportToPdf(DateTime startDate, DateTime endDate) async {
    generatingPdf.value = true;
    Rx<double> progress = 0.0.obs;
    var totalDays = endDate.difference(startDate).inDays+1;
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Obx(
          () => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            contentPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  text: "Generating your file \nplease wait...",
                  fontFamily: 'Sansation',
                  size: 16.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: 13.h,),
                SizedBox(
                  height: 7.h,
                  child: LinearProgressIndicator(
                    value: progress.value/totalDays,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(30.r),
                    color: const Color(0xff041c50),
                  ),
                ),
                SizedBox(height: 5.h,),
                CustomTextField(
                  text: "Progress: ${progress.value/totalDays*100} %",
                  fontFamily: 'Sansation',
                  size: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    DateTime currentDate = startDate;
    List<String> header = ['Medicine', 'Time Scheduled', 'Status'];
    List<List<String>> historyData = [];
    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      List<PillsModel> currentReminder = todayReminders(currentDate);
      var selectedHistory = await FirebaseFireStore.to.getHistoryDataByDay('${currentDate.year}:${currentDate.month < 10 ? '0${currentDate.month}' : currentDate.month}:${currentDate.day < 10 ? '0${currentDate.day}' : currentDate.day}');
      HistoryModel? historyModel;
      historyData.add(['Date: ${currentDate.year}/${currentDate.month}/${currentDate.day}' ,'', '']);
      if (currentReminder.isEmpty) {
        historyData.add(['No Pill was Scheduled this day' ,'', '']);
      } else {
        if (selectedHistory == null) {
          for (var reminder in currentReminder) {
            for (var interval in reminder.pillsInterval) {
              historyData.add([reminder.pillName, interval, DateTime.now().isBefore(currentDate) ? 'Upcoming' : 'Missed']);
            }
          }
        } else {
          historyModel = HistoryModel.fromJson(selectedHistory.data() as Map<String, dynamic>);
          for (var reminder in currentReminder) {
            HistoryData? history;
            for (var historyData in historyModel.historyData) {
              if (historyData.pillId == reminder.uid) {
                history = historyData;
                break;
              }
            }
            for (var interval in reminder.pillsInterval) {
              if (history == null) {
                historyData.add([reminder.pillName, interval, DateTime.now().isBefore(currentDate) ? 'Upcoming' : 'Missed']);
              } else {
                var difference = 60;
                var nextIndex = reminder.pillsInterval.indexOf(interval) + 1;
                if (nextIndex < reminder.pillsInterval.length) {
                  difference = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    int.parse(reminder.pillsInterval[nextIndex].substring(0, 2)),
                    int.parse(reminder.pillsInterval[nextIndex].substring(5, 7)),)
                      .difference(
                        DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          int.parse(interval.substring(0, 2)),
                          int.parse(interval.substring(5, 7)),
                        ),
                      )
                      .inMinutes;
                }
                var diff = history.timeTaken.any((element1) =>
                    element1
                            .difference(DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day,
                                int.parse(interval.substring(0, 2)),
                                int.parse(interval.substring(5, 7))))
                            .inMinutes <=
                        difference / 2 &&
                    element1
                            .difference(DateTime(
                                currentDate.year,
                                currentDate.month,
                                currentDate.day,
                                int.parse(interval.substring(0, 2)),
                                int.parse(interval.substring(5, 7))))
                            .inMinutes >=
                        -30);
                if (diff) {
                  historyData.add([reminder.pillName, interval, 'Taken']);
                } else {
                  historyData.add([reminder.pillName, interval, DateTime.now().isBefore(currentDate) ? 'Upcoming' :  DateTime.now().isAtSameMomentAs(currentDate) ? 'Under Progress' :  'Missed']);
                }
              }
            }
          }
        }
      }
      progress.value++;
      currentDate = currentDate.add(const Duration(days: 1));
      // log('Day: $currentDate');
    }
    generatingPdf.value = false;
    Get.back();
    await saveAndLaunchFile(header, historyData);
  }

  Future<void> saveAndLaunchFile(List<String> header, List<List<String>> historyData) async {
    try{
      List<List<String>> headerAndDataList = [];
      headerAndDataList.add(header);
      for (var dataRow in historyData) {
        headerAndDataList.add(dataRow);
      }
      String csvData = const ListToCsvConverter().convert(headerAndDataList);
      DateTime now = DateTime.now();
      final formattedData = DateFormat('MM-dd-yyyy').format(now);
      final bytes = utf8.encode(csvData);
      Uint8List bytes2 = Uint8List.fromList(bytes);
      final xFile = await FileSaver.instance.saveAs(
        name: 'medibot_history_$formattedData.csv',
        bytes: bytes2,
        ext: 'csv',
        mimeType: MimeType.csv,
      );
      if (xFile != null) {
        checkAndRequestStoragePermission(xFile);
        Get.snackbar(
          "MediBot",
          "Your history is saved successfully",
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
        Get.snackbar(
          "MediBot",
          "Failed to save your history data",
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
    }catch(err){
      log(err.toString());
      Get.snackbar(
        "MediBot",
        err.toString(),
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

  void checkAndRequestStoragePermission(xFile) async {
    log('Checking permsiion');
    if (await Permission.storage.request().isGranted) {
      log('Permission granted');
      Share.shareFiles([xFile]);
    } else {

    }
  }
}
