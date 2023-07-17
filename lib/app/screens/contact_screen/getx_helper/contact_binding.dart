
import 'package:get/get.dart';

import 'contact_controller.dart';

class ContactBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.put(ContactController());
  }
  
}