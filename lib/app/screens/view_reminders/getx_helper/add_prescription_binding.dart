import 'package:get/get.dart';

import 'add_prescription_controller.dart';

class AddPrescriptionBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(AddPrescriptionController());
  }

}