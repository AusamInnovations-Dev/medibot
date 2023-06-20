
import 'package:get/get.dart';
import 'package:medibot/app/screens/reminder/getx_helper/set_reminder_controller.dart';

class SetReminderBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SetReminderController());
  }

}