import 'package:get/get.dart';
import 'package:medibot/app/screens/qr_page/getx_helper/qr_controller.dart';

class QrBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(QrController());
  }

}