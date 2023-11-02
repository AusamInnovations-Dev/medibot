import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/user_settings/get_helper/user_setting_controller.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../routes/route_path.dart';
import '../../services/user.dart';
import '../../widgets/box_field.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_input_button.dart';
import '../../widgets/forward_button.dart';
import '../../widgets/text_field.dart';

class CaretakerSettings extends GetView<UserSettingController> {
  const CaretakerSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.caretakernameController =
        TextEditingController(text: UserStore.to.profile.careTaker.careTakerName);
    controller.caretakerphoneController =
        TextEditingController(text: UserStore.to.profile.careTaker.caretakerPhone);
    controller.caretakerlocationController =
        TextEditingController(text: UserStore.to.profile.careTaker.careTakerAddress);

    return ScreenDecoration(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  text: "Edit Caretaker",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ]),
          CustomBox(
            margin: EdgeInsets.symmetric(vertical: 55.h, horizontal: 15.h),
            padding: EdgeInsets.only(left: 12.w, top: 20.h, right: 12.w),
            topLeft: Radius.circular(17.r),
            bottomRight: Radius.circular(17.r),
            boxHeight: MediaQuery.of(context).size.height * 0.51,
            boxWidth: MediaQuery.of(context).size.width * 0.86,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 3.w),
                      child: CustomTextField(
                        text: "What’s your caretaker’s name?",
                        fontFamily: 'Sansation',
                        size: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    CustomInputField(
                      boxHeight: 39.h,
                      boxWidth: 293.w,
                      hintText: "",
                      showSuffix: false,
                      textController: controller.caretakernameController,
                      fontTheme: 'Sansation',
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 6.w),
                      child: CustomTextField(
                        text: "Caretaker's Address",
                        fontFamily: 'Sansation',
                        size: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        CustomInputField(
                          bottomr: Radius.zero,
                          topr: Radius.zero,
                          boxHeight: 118.h,
                          boxWidth: 210.w,
                          showSuffix: false,
                          textController: controller.caretakerlocationController,
                          hintText: "",
                          fontTheme: 'Sansation',
                        ),
                        InputButton(
                          height: 110.h,
                          width: 60.w,
                          text: "Fetch current location",
                          fontWeight: FontWeight.w500,
                          textsize: 9.sp,
                          onPressed: () async {
                            controller.caretakerlocationController.text =
                                await controller.getCurrentLocation();
                          },
                        )
                      ],
                    ),
                  ],
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
                          text: "Caretaker’s Contact Number",
                        ),
                      ),
                      Row(
                        children: [
                          CustomInputField(
                            bottomr: Radius.zero,
                            showSuffix: false,
                            textController: controller.caretakerphoneController,
                            topr: Radius.zero,
                            boxHeight: 36.h,
                            boxWidth: 199.w,
                            type: TextInputType.number,
                            hintText: "",
                            fontTheme: 'Sansation',
                          ),
                          InputButton(
                            height: 27.55.h,
                            width: 73.w,
                            text: "Select Contact",
                            fontWeight: FontWeight.w500,
                            textsize: 9.sp,
                            onPressed: () async {
                              var contact =
                                  await Get.toNamed(RoutePaths.contactPage);
                              controller.caretakerphoneController.text =
                                  contact['contact'];
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      ForwardButton(
                        width: 290.w,
                        text: 'Continue',
                        padding: EdgeInsets.symmetric(vertical: 9.w),
                        iconSize: 20.h,
                        onPressed: () {
                          if (int.tryParse(
                                      controller.caretakerphoneController.text) ==
                                  null ||
                              controller.caretakerphoneController.text.length !=
                                  10) {
                            Get.snackbar(
                              "User Settings ",
                              "Please enter a valid phone number",
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
                          } else {
                            controller.updateCareTaker();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
