import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../getx_helper/auth_controller.dart';
import '../../../widgets/backward_button.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_input_button.dart';
import '../../../widgets/forward_button.dart';
import '../../../widgets/text_field.dart';
import 'package:medibot/app/routes/route_path.dart';

class EmergencyInfo extends GetView<AuthController> {
  const EmergencyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 96.h,
            ),
          ],
        ),
        toolbarHeight: 80.h,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomBox(
            boxHeight: 363.h,
            boxWidth: 264.w,
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
            topRight: Radius.circular(17.r),
            bottomLeft: Radius.circular(17.r),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          size: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          text: "What’s your emergency contact’s name?",
                        ),
                      ),
                      CustomInputField(
                        boxHeight: 36.h,
                        boxWidth: 240.w,
                        hintText: "",
                        fontTheme: 'Sansation',
                        textController: controller.emergencynameController,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          size: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          text: "Emergency contact’s Address",
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomInputField(
                            boxHeight: 36.h,
                            boxWidth: 172.w,
                            hintText: "",
                            fontTheme: 'Sansation',
                            textController: controller.emergencylocationController,
                          ),
                          Obx(
                            () => InputButton(
                              height: 27.5.h,
                              width: 56.w,
                              text: controller.fetchingLocation.value
                                  ? '...'
                                  : "Fetch current location",
                              fontWeight: FontWeight.w500,
                              textsize: 9.sp,
                              onPressed: () async {
                                controller.emergencylocationController.text =await controller.getCurrentLocation();
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          size: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          text: "Emergency contact’s Contact Number",
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomInputField(
                            boxHeight: 36.h,
                            boxWidth: 172.w,
                            hintText: "",
                            fontTheme: 'Sansation',
                            textController: controller.emergencycontactController,
                          ),
                          InputButton(
                            height: 27.5.h,
                            width: 57.w,
                            text: "Select Contact",
                            fontWeight: FontWeight.w500,
                            textsize: 9.sp,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          size: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          text: "Emergency contact’s relation with you?",
                        ),
                      ),
                      CustomInputField(
                        boxHeight: 36.h,
                        boxWidth: 240.w,
                        hintText: "",
                        fontTheme: 'Sansation',
                        textController: controller.emergencyrelationController,
                      )
                    ],
                  ),
                ),
                ForwardButton(
                  width: 255.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 9.w),
                  iconSize: 18.h,
                  onPressed: () {
                    Get.toNamed(RoutePaths.qrScan);
                  },
                ),
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
                if (controller.haveCaretaker.value) {
                  Get.offAndToNamed(RoutePaths.caretakerInformation);
                } else {
                  Get.offAndToNamed(RoutePaths.userInformation);
                }
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
