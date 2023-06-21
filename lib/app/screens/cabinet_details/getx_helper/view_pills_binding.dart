import 'package:get/get.dart';
import 'package:medibot/app/screens/cabinet_details/getx_helper/view_pills_controller.dart';

class ViewPillsBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(ViewPillsController());
  }

}