import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/user_settings/get_helper/user_setting_controller.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../routes/route_path.dart';
import '../../widgets/box_field.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_input_button.dart';
import '../../widgets/forward_button.dart';
import '../../widgets/text_field.dart';

class EmergencyInfoSettings extends GetView<UserSettingController> {
  const EmergencyInfoSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBox(
            boxHeight: 367.h,
            boxWidth: 302.w,
            margin: EdgeInsets.symmetric(vertical: 45.h, horizontal: 40.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
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
                        textController: controller.emergencynameController,
                        hintText: "",
                        fontTheme: 'Sansation',
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
                            topr: Radius.zero,
                            bottomr: Radius.zero,
                            boxHeight: 36.h,
                            boxWidth: 172.w,
                            hintText: "",
                            textController:
                                controller.emergencylocationController,
                            fontTheme: 'Sansation',
                          ),
                          InputButton(
                            height: 27.5.h,
                            width: 57.w,
                            text: "Fetch current location",
                            fontWeight: FontWeight.w500,
                            textsize: 9.sp,
                            onPressed: () async {
                              controller.emergencylocationController.text =
                                  await controller.getCurrentLocation();
                            },
                          ),
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
                            topr: Radius.zero,
                            bottomr: Radius.zero,
                            boxHeight: 36.h,
                            boxWidth: 172.w,
                            hintText: "",
                            textController:
                                controller.emergencycontactController,
                            fontTheme: 'Sansation',
                          ),
                          InputButton(
                            height: 27.5.h,
                            width: 57.w,
                            text: "Select Contact",
                            fontWeight: FontWeight.w500,
                            textsize: 9.sp,
                            onPressed: () async {
                              var contact = await Get.toNamed(RoutePaths.contactPage);
                              controller.emergencycontactController.text = contact['contact'];
                            },
                          ),
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
                        textController: controller.emergencyrelationController,
                        boxWidth: 240.w,
                        hintText: "",
                        fontTheme: 'Sansation',
                      )
                    ],
                  ),
                ),
                ForwardButton(
                  width: 290.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 9.w),
                  iconSize: 20.h,
                  onPressed: () {
                    controller.updateEmergencyContact();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
