
import 'package:get/get.dart';
import 'package:medibot/app/models/history_model/history_model.dart';

class HistoryDetailsController extends GetxController{

  late String history;
  late DateTime day;

  @override
  void onInit() {
    history = Get.arguments['history'];
    day = Get.arguments['day'];
    super.onInit();
  }

}