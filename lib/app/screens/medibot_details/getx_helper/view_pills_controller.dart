import 'dart:developer';

import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

class ViewPillsController extends GetxController {
  late List<PillsModel> pill;
  List<String> pillIntervals = [
  ];

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    calculateInterval();
    super.onInit();
  }

  calculateInterval() {
    pillIntervals.clear();
    pillIntervals = pill.first.pillsInterval;
  }
}
