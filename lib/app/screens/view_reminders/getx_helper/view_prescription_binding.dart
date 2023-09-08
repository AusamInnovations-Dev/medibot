import 'package:get/get.dart';
import 'package:medibot/app/screens/view_reminders/getx_helper/view_prescription_controller.dart';

class ViewPrescriptionBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(ViewPrescriptionController());
  }

}