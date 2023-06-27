import 'dart:developer';

import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

class ViewPillsController extends GetxController {
  late PillsModel pill;
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
    log(pill.pillsInterval.first);
    log('${pill.pillsInterval.first.substring(0, 2)} ${pill.pillsInterval.first.substring(5, 7)}');

    for(var interval in pill.pillsInterval){
      if(interval.substring(0, 2) == '00' && interval.substring(5, 7) == '00'){

      }else{
        pillIntervals.add(
          {
            'hour': '${int.parse(interval.substring(0, 2)) >= 12 ? (int.parse(interval.substring(0, 2))-12) <= 9? '0${int.parse(interval.substring(0, 2))-12}' : int.parse(interval.substring(0, 2))-12 : interval.substring(0, 2) } H',
            'minute': '${interval.substring(5, 7)} M',
            'period': int.parse(interval.substring(0, 2)) >= 12? "PM" : "AM",
          },
        );
      }
    }
  }
}
