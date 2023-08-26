import 'dart:developer';

import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

class ViewPillsController extends GetxController {
  late List<PillsModel> pill;
  List<Map<String, dynamic>> pillIntervals = [
  ];

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    calculateInterval();
    super.onInit();
  }

  calculateInterval() {
    pillIntervals.clear();
    log(pill.first.pillsInterval.toString());

    for(var interval in pill.first.pillsInterval){
      if(interval.substring(0, 2) == '00' && interval.substring(5, 7) == '00'){

      }else{
        pillIntervals.add(
          {
            'hour': '${int.parse(interval.substring(0, 2)) >= 12 ? (int.parse(interval.substring(0, 2))-12) <= 9? '0${int.parse(interval.substring(0, 2))-12}' : int.parse(interval.substring(0, 2))-12 : interval.substring(0, 2) } H',
            'minute': '${interval.substring(5, 7)} M',
                'period': int.parse(interval.substring(0, 2)) > 12 && int.parse(interval.substring(0, 2)) != 24? "PM" : int.parse(interval.substring(0, 2)) == 12 ? "PM" : "AM",
          },
        );
      }
    }
  }
}
