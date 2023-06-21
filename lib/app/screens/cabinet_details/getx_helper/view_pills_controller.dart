import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

class ViewPillsController extends GetxController {

  late PillsModel pill;

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    super.onInit();
  }
}