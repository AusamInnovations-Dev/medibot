
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/set_up_profile/getx_helper/set_up_profile_controller.dart';
import 'package:medibot/app/widgets/custom_input.dart';
import 'package:medibot/app/widgets/custom_input_button.dart';
import 'package:medibot/app/widgets/forward_button.dart';

import '../../../widgets/backward_button.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';

class UserInfo extends GetView<SetUpProfileController> {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5.w, left: 10.w),
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
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomBox(
                  boxHeight: MediaQuery.of(context).size.height * 0.5,
                  boxWidth: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.symmetric(horizontal: 42.w),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  topRight: Radius.circular(17.r),
                  bottomLeft: Radius.circular(17.r),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 22.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 3.w),
                              child: CustomTextField(
                                size: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                text: "What's your name?",
                              ),
                            ),
                            CustomInputField(
                              boxHeight: 36.h,
                              boxWidth: 232.w,
                              hintText: "",
                              fontTheme: 'Sansation',
                              textController: controller.nameController,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 22.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 3.w),
                              child: CustomTextField(
                                size: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                text: "And your age please?",
                              ),
                            ),
                            CustomInputField(
                              boxHeight: 36.h,
                              boxWidth: 232.w,
                              hintText: "",
                              fontTheme: 'Sansation',
                              type: TextInputType.number,
                              textController: controller.ageController,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 12.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 3.w),
                              child: CustomTextField(
                                size: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                text: "Address?",
                              ),
                            ),
                            Row(
                              children: [
                                CustomInputField(
                                  topr: Radius.zero,
                                  bottomr: Radius.zero,
                                  boxHeight: 36.h,
                                  boxWidth: 166.w,
                                  hintText: "",
                                  fontTheme: 'Sansation',
                                  textController: controller.locationController,
                                ),
                                Obx(
                                  () => InputButton(
                                    height: 27.h,
                                    width: 54.w,
                                    text: controller.fetchingLocation.value
                                        ? '...'
                                        : "Fetch current location",
                                    fontWeight: FontWeight.w500,
                                    textsize: 8.sp,
                                    onPressed: () async {
                                      controller.locationController.text = await controller.getCurrentLocation();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: CustomTextField(
                                size: 13.sp,
                                fontWeight: FontWeight.w400,
                                text: "Do you have a caretaker?",
                                color: Colors.black,
                              ),
                            ),
                            Obx(
                              () => Transform.scale(
                                scaleX: 2.0,
                                scaleY: 2.1,
                                child: Checkbox(
                                  activeColor: const Color(0xffCEE2FF),
                                  checkColor: Colors.black,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  value: controller.haveCaretaker.value,
                                  onChanged: (value) {
                                    controller.haveCaretaker.value = value!;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ForwardButton(
                        width: 240.w,
                        text: 'Continue',
                        padding: EdgeInsets.symmetric(vertical: 9.w),
                        iconSize: 18.h,
                        onPressed: () {
                          if(int.tryParse(controller.ageController.text) == null){
                            Get.snackbar(
                              "User Settings",
                              "PLease enter valid age",
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
                            if (controller.haveCaretaker.value) {
                              Get.toNamed(RoutePaths.caretakerInformation);
                            } else {
                              Get.toNamed(RoutePaths.emergencyInformation);
                            }
                          }
                        },
                      )
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
