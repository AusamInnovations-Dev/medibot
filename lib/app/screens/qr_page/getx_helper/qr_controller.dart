import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/services/user.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../routes/route_path.dart';
import '../../../services/firestore.dart';
import 'package:flutter/services.dart';

import '../../../widgets/custom_input.dart';
import '../../../widgets/text_field.dart';

class QrController extends GetxController {
  var platform = const MethodChannel('MedibotChannel');
  final dio = Dio();
  var uploadingData = false.obs;
  var isScanning = true.obs;
  TextEditingController wifiPasswordController = TextEditingController();
  TextEditingController wifiNameController = TextEditingController();

  onScanQrCode(data) async {
    try {
      uploadingData.value = true;
      isScanning.value = false;
      // var medibotData = await FirebaseFireStore.to.getMedibotId('$data');

      // await platform.invokeMethod(
      //     'connectToWifi', {'ssid': 'OPPO A78 5G', 'password': 'OPPO A78 5G'});

      // final String ipAddress = await platform.invokeMethod('getIpAddress');
      // final List<WifiNetwork> availableNetworks =
      //     await WiFiForIoTPlugin.loadWifiList();
      // // Find the WiFi network that you want to connect to.
      // final WifiNetwork targetNetwork =
      //     availableNetworks.firstWhere((network) => network.ssid == 'OPPO A78 5G');

      // Connect to the WiFi network.

      // Check if the connection was successful.
      // print(
      // '**************************** Medibot Data ${medibotData.data()!['ssId']}  ${medibotData.data()!['password']}.');
      String? ssid = 'shubham-lenovo-ideapad';
      // medibotData.data()!['ssId'];
      String? pass = 'Shubham100';
      // medibotData.data()!['password'];
      // await WiFiForIoTPlugin.findAndConnect(ssid ?? "", password: pass ?? "")
      await WiFiForIoTPlugin.getIP().then((value) async {
        if (value != null) {
          // String? ip = await WiFiForIoTPlugin.getIP();
          print('**************************** Successfully connected to $value.');

          // print(
          //     '::::::::::::::::::::::::::::::::::: In Controller - Outer $ipAddress:::::::::::::::::::::::::::::::::::');
          if (false) {
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
          } else {
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
                        showSuffix: false,
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
                        showSuffix: true,
                        textController: wifiPasswordController,
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Response res =
                          //     await ApiClient.to.postData('http://$value/', {
                          //   'SSID': wifiNameController.text,
                          //   'pass': wifiPasswordController.text,
                          // });
                          final res = await dio.get(
                              'http://192.168.4.1?SSID=${wifiNameController.text}&pass=${wifiPasswordController.text}');

                          print(
                              '::::::::::::::::::::::::::::::::::: In Controller - Connecting ${res.data} :::::::::::::::::::::::::::::::::::');
                          if (res.data != null && res.statusCode == 200) {
                            Get.back();
                            await FirebaseFireStore.to
                                .updateUserData(UserStore.to.profile.copyWith(
                              medibotDetail: data,
                            ));
                            Get.offAndToNamed(RoutePaths.setupFinished);
                          } else {
                            print(
                                '::::::::::::::::::::::::::::::::::: In Controller - Connection Error ${res.data} :::::::::::::::::::::::::::::::::::');

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
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
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
        } else {
          Get.snackbar(
            "MediBot",
            "Failed to connect.",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
          print('**************************** Failed to connect to.');
        }
      }).onError((error, stackTrace) {
        Get.snackbar(
          "MediBot",
          "$error",
          icon: const Icon(
            Icons.crisis_alert,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
        print('**************************** Failed to connect to. $error');
      });
    } catch (e) {
      print('**************************** Error: $e');
    }
  }

  onSkip() {
    Get.offAndToNamed(RoutePaths.setupFinished);
  }
}
