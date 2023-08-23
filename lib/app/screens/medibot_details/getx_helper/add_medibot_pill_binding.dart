import 'package:get/get.dart';

import 'medibot_add_pill_controller.dart';

class AddMedibotPillBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(AddMedibotPill());
  }

}