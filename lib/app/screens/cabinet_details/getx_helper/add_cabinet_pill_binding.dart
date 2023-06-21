import 'package:get/get.dart';

import 'cabinet_add_pill_controller.dart';

class AddCabinetPillBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(AddCabinetPill());
  }

}