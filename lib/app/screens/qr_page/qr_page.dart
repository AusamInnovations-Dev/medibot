import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/qr_page/getx_helper/qr_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../widgets/backward_button.dart';
import '../../widgets/box_field.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/forward_button.dart';
import '../../widgets/text_field.dart';
import 'package:medibot/app/routes/route_path.dart';

class Qrcode extends GetView<QrController> {
  const Qrcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              text: "MediBot",
              fontFamily: 'Sansation',
              size: 34.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            SvgPicture.asset(
              "assets/images/cylinder.svg",
              height: 90.h,
            ),
          ],
        ),
        toolbarHeight: 80.h,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomBox(
            boxHeight: 370.h,
            boxWidth: 264.w,
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            topRight: Radius.circular(17.r),
            bottomLeft: Radius.circular(17.r),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          size: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          text: "Have a physical device? Scan QR",
                        ),
                      ),
                      Obx(
                        () => CustomBox(
                          boxHeight: 200.h,
                          boxWidth: 232.w,
                          boxShadow: [],
                          body: !controller.isScanning.value ?
                          MobileScanner(
                            onDetect: (BarcodeCapture barcodes) {
                              var data = barcodes.raw;
                              controller.isScanning.value = true;
                              log('QR Code scanner Id: $data');
                              log('QR Code scanner Id: ${data.first['displayValue']}');
                              Future.delayed(const Duration(seconds: 1), () {

                              });
                            },
                          ) : const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff041c50),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ForwardButton(
                  width: 235.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  iconSize: 18.h,
                  onPressed: () async {
                    await controller.onScanQrCode();
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    await controller.onSkip();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 0),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      // horizontal: 100.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.r),
                    ),
                  ),
                  child: Obx(
                    () => !controller.uploadingData.value
                        ? CustomTextField(
                            text: "No thanks, Skip",
                            fontFamily: 'Sansation',
                            size: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )
                        : Container(
                            alignment: Alignment.center,
                            height: 13.h,
                            width: 13.h,
                            child: const CircularProgressIndicator(),
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutePaths.createUser);
                    },
                    child: Text(
                      "Purchase Device",
                      style: TextStyle(
                        fontFamily: 'Sansation',
                        fontSize: 13.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/images/circlular.svg",
            height: 145.h,
          ),
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: BackwardButton(
              text: 'Go Back',
              onPressed: () {
                Get.back();
              },
              iconSize: 18.w,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              width: 120.w,
            ),
          )
        ],
      ),
    );
  }
}
