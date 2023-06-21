import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/pills_models/pills_model.dart';
import '../../../services/firestore.dart';

class CabinetController extends GetxController {
  var isLoading = false.obs;
  RxList<PillsModel> cabinetPillsList = <PillsModel>[].obs;
  RxList<int> remainingDay = <int>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCabinetDetails();
  }

  getCabinetDetails() async {
    isLoading.value = true;
    cabinetPillsList.clear();
    try {
      var cabinetData = await FirebaseFireStore.to.getCabinetDetail();
      if (cabinetData != null) {
        for (var cabinet in cabinetData.docs) {
          cabinetPillsList.add(PillsModel.fromJson(cabinet.data()));
          if (cabinetPillsList.last.isIndividual) {
            var difference = 0;
            for(var date in cabinetPillsList.last.pillsDuration){
              if(!DateTime.parse(date).isBefore(DateTime.now())){
                difference ++;
              }
            }
            remainingDay.add(difference);
          } else if (cabinetPillsList.last.isRange) {
            remainingDay.add(
                DateTime.parse(cabinetPillsList.last.pillsDuration.last)
                    .difference(DateTime.now())
                    .inDays);
          }
        }
      }
      log("This is the data: $cabinetPillsList");
    } catch (err) {
      log(err.toString());
    }
    isLoading.value = false;
  }

}
