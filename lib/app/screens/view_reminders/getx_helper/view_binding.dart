import 'package:get/get.dart';

import 'view_controller.dart';

class ViewBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(ViewController());
  }

}