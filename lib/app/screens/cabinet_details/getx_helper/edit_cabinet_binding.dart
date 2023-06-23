import 'package:get/get.dart';
import 'package:medibot/app/screens/cabinet_details/getx_helper/edit_cabinet_controller.dart';

class EditCabinetBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(EditCabinetController());
  }

}