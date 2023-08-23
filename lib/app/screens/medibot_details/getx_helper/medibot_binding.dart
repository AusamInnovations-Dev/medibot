
import 'package:get/get.dart';

import 'medibot_controller.dart';

class MedibotBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => MedibotController());
  }

}