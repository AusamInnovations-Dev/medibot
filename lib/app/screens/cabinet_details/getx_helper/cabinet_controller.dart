import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';

class CabinetController extends GetxController {
  var isLoading = false.obs;
  RxList<PillsModel> cabinetPillsList = <PillsModel>[].obs;
  RxList<int> remainingDay = <int>[].obs;
  RefreshController refreshController = RefreshController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCabinetDetails();
  }

  onRefreshCabinet() {
    getCabinetDetails().then(
      (_) => refreshController.refreshCompleted(resetFooterState: true),
    );
  }

  getCabinetDetails() async {
    isLoading.value = true;
    cabinetPillsList.clear();
    try {
      var cabinetData = FirebaseFireStore.to.getCabinetDetail();
      cabinetData.listen((snapshot) {
        for (var cabinet in snapshot.docChanges) {
          switch (cabinet.type) {
            case DocumentChangeType.added:
              if (cabinet.doc.data() != null) {
                cabinetPillsList.add(PillsModel.fromJson(cabinet.doc.data()!));
                log('This is new data: $cabinetPillsList');
                if (cabinetPillsList.last.isIndividual) {
                  var difference = 0;
                  for (var date in cabinetPillsList.last.pillsDuration) {
                    if (!DateTime.parse(date).isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
                      difference++;
                    }
                  }
                  remainingDay.add(difference);
                } else if (cabinetPillsList.last.isRange) {
                  log('remaining day: ${cabinetPillsList.last.pillsDuration.last} and ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)}');
                  remainingDay.add(
                    DateTime.parse(cabinetPillsList.last.pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1,
                  );
                  log(remainingDay.toString());
                }
              }
              break;
            case DocumentChangeType.modified:
              if (cabinet.doc.data() != null) {
                int changeIndex = cabinetPillsList.indexWhere(
                        (element) => element.uid == cabinet.doc.data()!['uid']);
                Map<String, dynamic> modification =
                cabinet.doc.data() as Map<String, dynamic>;
                var modifiedRemainder = PillsModel.fromJson(modification);
                cabinetPillsList[changeIndex] = cabinetPillsList[changeIndex]
                    .copyWith(
                    uid: modifiedRemainder.uid,
                    dosage: modifiedRemainder.dosage,
                    inCabinet: modifiedRemainder.inCabinet,
                    interval: modifiedRemainder.interval,
                    isIndividual: modifiedRemainder.isIndividual,
                    isRange: modifiedRemainder.isRange,
                    pillName: modifiedRemainder.pillName,
                    pillsDuration: modifiedRemainder.pillsDuration,
                    pillsInterval: modifiedRemainder.pillsInterval,
                    pillsQuantity: modifiedRemainder.pillsQuantity,
                    request: modifiedRemainder.request,
                    slot: modifiedRemainder.slot);
              }
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
        log("This is the data: $cabinetPillsList");
      });
    } catch (err) {
      log(err.toString());
    }
    isLoading.value = false;
  }
}
