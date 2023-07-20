import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/history_model/history_model.dart';
import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';
import '../../../services/user.dart';

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
    Future.delayed(const Duration(seconds: 2), () {
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
    showDialog(
      context: Get.context!,
      builder: (context) => Center(
        child: SizedBox(
          height: 30.h,
          width: 35.w,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
    DateTime currentDate = startDate;
    List<List<String>> historyData = [['Medicine', 'Time Scheduled', 'Status']];
    // PdfDocument document = PdfDocument();
    // final page = document.pages.add();
    // page.graphics.drawString('Welcome to Medibot', PdfStandardFont(PdfFontFamily.courier, 30));
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
                    int.parse(
                        reminder.pillsInterval[nextIndex].substring(0, 2)),
                    int.parse(
                        reminder.pillsInterval[nextIndex].substring(5, 7)),
                  )
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
      currentDate = currentDate.add(const Duration(days: 1));
      // log('Day: $currentDate');
    }
    generatingPdf.value = false;
    Get.back();
    await saveAndLaunchFile(historyData);
    // document.dispose();
  }

  Future<void> saveAndLaunchFile(List<List<String>> historyData) async {
    log('Opening the pdf');
    String csvData = const ListToCsvConverter().convert(historyData);
    final path = (await getExternalStorageDirectory())!.path;
    log(path);
    log(csvData);
    final file = await File('$path/medibot_history_${DateTime.now().toIso8601String()}.csv').create();
    await file.writeAsString(csvData);
    log('Opening the pdf2');
    OpenFile.open('$path/medibot_history_${DateTime.now().toIso8601String()}.csv');
  }
}
