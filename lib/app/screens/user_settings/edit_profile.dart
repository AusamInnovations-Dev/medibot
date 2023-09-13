import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/user_settings/get_helper/user_setting_controller.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/box_field.dart';
import 'package:medibot/app/widgets/custom_input_button.dart';

import '../../services/user.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/forward_button.dart';
import '../../widgets/text_field.dart';

class UserProfile extends GetView<UserSettingController> {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nameController = TextEditingController(text: UserStore.to.profile.username);
    controller.addressController = TextEditingController(text: UserStore.to.profile.address);
    controller.ageController = TextEditingController(text: UserStore.to.profile.age.toString());
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
                  text: "Edit User Profile",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ]),
          CustomBox(
            margin: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            topLeft: Radius.circular(17.r),
            bottomRight: Radius.circular(17.r),
            boxHeight: MediaQuery.of(context).size.height * 0.5,
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
                        text: "What's your name",
                        fontFamily: 'Sansation',
                        size: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    CustomInputField(
                      boxHeight: 39.h,
                      textController: controller.nameController,
                      boxWidth: 293.w,
                      hintText: "",
                      fontTheme: 'Sansation',
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 3.w),
                      child: CustomTextField(
                        text: "And your age please?",
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
                      type: TextInputType.number,
                      textController: controller.ageController,
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
                        text: "Address",
                        fontFamily: 'Sansation',
                        size: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomInputField(
                          bottomr: Radius.zero,
                          textController: controller.addressController,
                          topr: Radius.zero,
                          boxHeight: 118.h,
                          boxWidth: 217.w,
                          hintText: "",
                          fontTheme: 'Sansation',
                        ),
                        InputButton(
                          height: 110.h,
                          width: 63.w,
                          text: "Fetch current location",
                          fontWeight: FontWeight.w500,
                          textsize: 9.sp,
                          onPressed: () async {
                            controller.addressController.text = await controller.getCurrentLocation();
                          },
                        )
                      ],
                    ),
                  ],
                ),
                ForwardButton(
                  width: 290.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 9.w),
                  iconSize: 20.h,
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
                      controller.updateProfile();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
      bottomButtonText: "",
      onbottomButtonPressed: () {},
    );
  }
}
