import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/route_path.dart';
import '../../../services/firestore.dart';
import 'package:flutter/services.dart';

class QrController extends GetxController {
  var platform = const MethodChannel('MedibotChannel');
  var uploadingData = false.obs;
  var isScanning = true.obs;

  onScanQrCode(data) async {
    try{
      uploadingData.value = true;
      isScanning.value = false;
      var medibotData = await FirebaseFireStore.to.getMedibotId('djmmI5mwGsNzprQFbu49');

      await platform.invokeMethod('connectToWiFi', {'ssid': medibotData.data()!['ssId'], 'password': medibotData.data()!['password']}).then((value) {
        log('This is the data : $value');
        if(value == "false"){
          isScanning.value = true;
          uploadingData.value = false;
          Get.snackbar(
            "MediBot",
            "Some error occurred",
            icon: const Icon(
              Icons.crisis_alert_outlined,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }else {
          uploadingData.value = false;
          Get.offAndToNamed(RoutePaths.setupFinished);
        }
      });

    }catch(err){
      log(err.toString());
      isScanning.value = true;
      uploadingData.value = false;
    }
  }

  onSkip() {
    Get.offAndToNamed(RoutePaths.setupFinished);
  }

}