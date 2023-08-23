import 'package:get/get.dart';

import 'edit_medibot_controller.dart';

class EditMedibotBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(EditMedibotController());
  }

}