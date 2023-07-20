
import 'package:get/get.dart';

import 'add_existing_slot_controller.dart';

class AddExistingSlotBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(AddExistingSlotController());
  }

}