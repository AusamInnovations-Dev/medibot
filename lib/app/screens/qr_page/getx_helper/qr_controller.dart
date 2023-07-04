import 'package:get/get.dart';

import '../../../routes/route_path.dart';

class QrController extends GetxController {

  var uploadingData = false.obs;
  var isScanning = false.obs;

  onScanQrCode() async {
    uploadingData.value = true;

    //TODO: Have to implement qr code scanning

    uploadingData.value = false;
    Get.offAndToNamed(RoutePaths.setupFinished);
  }

  onSkip() {
    Get.offAndToNamed(RoutePaths.setupFinished);
  }

}