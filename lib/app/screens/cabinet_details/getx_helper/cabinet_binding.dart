
import 'package:get/get.dart';
import 'package:medibot/app/screens/cabinet_details/getx_helper/cabinet_controller.dart';

class CabinetBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => CabinetController());
  }

}