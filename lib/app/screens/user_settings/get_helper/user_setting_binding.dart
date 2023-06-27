
import 'package:get/get.dart';
import 'package:medibot/app/screens/user_settings/get_helper/user_setting_controller.dart';

class UserSettingBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(UserSettingController());
  }

}