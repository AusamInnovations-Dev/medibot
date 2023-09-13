import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../widgets/backward_button.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_input_button.dart';
import '../../../widgets/forward_button.dart';
import '../../../widgets/text_field.dart';
import 'package:medibot/app/routes/route_path.dart';

import 'getx_helper/set_up_profile_controller.dart';

class EmergencyInfo extends GetView<SetUpProfileController> {
  const EmergencyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5.w, left: 10.w, bottom: 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: 80.h,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                alignment: Alignment.center,
                child: CustomBox(
                  boxHeight: MediaQuery.of(context).size.height * 0.5,
                  boxWidth: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 38),
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
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
                              boxWidth: 250.w,
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
                                  boxWidth: 180.w,
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
                                  boxWidth: 180.w,
                                  hintText: "",
                                  fontTheme: 'Sansation',
                                  type: TextInputType.number,
                                  textController: controller.emergencycontactController,
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
                      Obx(
                        () => Container(
                          child: !controller.uploadingData.value ?
                          ForwardButton(
                            width: 255.w,
                            text: 'Continue',
                            padding: EdgeInsets.symmetric(vertical: 9.w),
                            iconSize: 18.h,
                            onPressed: () async {
                              if(int.tryParse(controller.emergencycontactController.text) == null || controller.emergencycontactController.text.length != 10){
                                Get.snackbar(
                                  "User Settings ",
                                  "Please enter a valid phone number",
                                  icon: const Icon(
                                    Icons.crisis_alert,
                                    color: Colors.black,
                                  ),
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: const Color(0xffA9CBFF),
                                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                  colorText: Colors.black,
                                );
                              }else{
                                await controller.updateUserData();
                                Get.toNamed(RoutePaths.qrScan);
                              }
                            },
                          ) : const Center(child: CircularProgressIndicator(),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
