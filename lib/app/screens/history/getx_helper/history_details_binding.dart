
import 'package:get/get.dart';
import 'package:medibot/app/screens/history/getx_helper/history_details_controller.dart';

class HistoryDetailsBinding implements Bindings{

  @override
  void dependencies() {
    Get.put(HistoryDetailsController());
  }
}