import 'package:get/get.dart';

import '../../../models/pills_models/pills_model.dart';

class EditCabinetController extends GetxController{

  late PillsModel pill;
  late int remainingDay;

  @override
  void onInit() {
    pill = Get.arguments['pill'];
    remainingDay = Get.arguments['remainingDays'];
    super.onInit();
  }
}