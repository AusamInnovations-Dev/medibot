import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medibot/app/services/firestore.dart';

import '../../../models/pills_models/pills_model.dart';

class EditCabinetController extends GetxController{

  late PillsModel pill;
  late int remainingDay;
  late String interval;

  TextEditingController remainingPillController = TextEditingController();

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    remainingDay = Get.arguments['remainingDays'];
    interval = pill.interval;
    super.onInit();
  }

  updatePill() async {
    await FirebaseFireStore.to.updateCabinetData(
      pill.copyWith(
        interval: interval,
        pillsQuantity: remainingPillController.text
      )
    );
    Get.back();
  }

}