import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/pills_models/pills_model.dart';

class EditMedibotController extends GetxController{

  late List<PillsModel> pill;
  late int remainingDay;
  late String interval;

  TextEditingController remainingPillController = TextEditingController();

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    remainingDay = Get.arguments['remainingDays'];
    interval = pill.first.interval;
    super.onInit();
  }

  updatePill() async {
    // await FirebaseFireStore.to.updateMedibotData(
    //   pill.copyWith(
    //     interval: interval,
    //     pillsQuantity: remainingPillController.text
    //   )
    // );
    // Get.back();
  }

}