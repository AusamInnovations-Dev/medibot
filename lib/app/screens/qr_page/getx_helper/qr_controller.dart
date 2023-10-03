import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/API/api_client.dart';
import 'package:medibot/app/services/user.dart';

import '../../../routes/route_path.dart';
import '../../../services/firestore.dart';
import 'package:flutter/services.dart';

import '../../../widgets/custom_input.dart';
import '../../../widgets/text_field.dart';

class QrController extends GetxController {
  var platform = const MethodChannel('MedibotChannel');
  var uploadingData = false.obs;
  var isScanning = true.obs;
  TextEditingController wifiPasswordController = TextEditingController();
  TextEditingController wifiNameController = TextEditingController();

  onScanQrCode(data) async {
    try{
      uploadingData.value = true;
      isScanning.value = false;
      var medibotData = await FirebaseFireStore.to.getMedibotId('$data');

      await platform.invokeMethod('connectToWiFi', {'ssid': medibotData.data()!['ssId'], 'password': medibotData.data()!['password']}).then((value) {
        log('This is the data : $value');
        if(value == "false"){
          isScanning.value = true;
          uploadingData.value = false;
          Get.snackbar(
            "MediBot",
            "Please make sure that your wifi is turned on",
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
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) => Dialog(
              backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: CustomTextField(
                            text: "Please provide Home wifi details",
                            fontFamily: 'Sansation',
                            size: 16.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                            isScanning.value = true;
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 3.w),
                      child: CustomTextField(
                        size: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        text: "Name",
                      ),
                    ),
                    CustomInputField(
                      boxHeight: 35.h,
                      boxWidth: 320.w,
                      hintText: "",
                      fontTheme: 'Sansation',
                      textController: wifiNameController,
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 3.w),
                      child: CustomTextField(
                        size: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        text: "Password",
                      ),
                    ),
                    CustomInputField(
                      boxHeight: 35.h,
                      boxWidth: 320.w,
                      hintText: "",
                      fontTheme: 'Sansation',
                      obsecure: true,
                      textController: wifiPasswordController,
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Response res = await ApiClient.to.postData('http://192.168.4.1:80/', {
                          'name': wifiNameController.text,
                          'password': wifiPasswordController.text,
                        });
                        if(res.body != null && res.statusCode == 200){
                          Get.back();
                          await FirebaseFireStore.to.updateUserData(
                            UserStore.to.profile.copyWith(
                             medibotDetail: data,
                            )
                          );
                          Get.offAndToNamed(RoutePaths.setupFinished);
                        }else{
                          Get.back();
                          Get.snackbar(
                            "MediBot",
                            "Connection Failed with status code: ${res.statusCode}",
                            icon: const Icon(
                              Icons.crisis_alert,
                              color: Colors.black,
                            ),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(0xffA9CBFF),
                            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                            colorText: Colors.black,
                          );
                          isScanning.value = true;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width, 0),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        padding: EdgeInsets.symmetric(
                          vertical: 11.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.r),
                        ),
                      ),
                      child: CustomTextField(
                        text: "submit",
                        fontFamily: 'Sansation',
                        size: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
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