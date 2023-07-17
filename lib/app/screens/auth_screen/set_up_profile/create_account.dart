import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/getx_helper/auth_controller.dart';
import 'package:medibot/app/widgets/box_field.dart';
import 'package:medibot/app/widgets/custom_input.dart';
import 'package:medibot/app/widgets/forward_button.dart';

import '../../../widgets/backward_button.dart';
import '../../../widgets/text_field.dart';

class CreateAccount extends GetView<AuthController> {
  const CreateAccount({Key? key}) : super(key: key);
  static String verify = "";

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
            boxHeight: 350,
            boxWidth: 264,
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
            topRight: Radius.circular(17.r),
            bottomLeft: Radius.circular(17.r),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          size: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          text: "Phone Number",
                        ),
                      ),
                      CustomInputField(
                        boxHeight: 35.h,
                        boxWidth: 265.w,
                        hintText: "",
                        textController: controller.phoneController,
                        fontTheme: 'Sansation',
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: CustomTextField(
                    fontWeight: FontWeight.w600,
                    text: "or",
                    size: 13.sp,
                    fontFamily: 'Sansation',
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          fontWeight: FontWeight.w600,
                          size: 13.sp,
                          text: "Email Address",
                          color: Colors.black,
                        ),
                      ),
                      CustomInputField(
                        boxHeight: 35.h,
                        boxWidth: 265.w,
                        hintText: "",
                        fontTheme: 'Sansation',
                      ),
                    ],
                  ),
                ),
                ForwardButton(
                  width: 255.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 11.w),
                  iconSize: 18.h,
                  onPressed: () async {
                    if (controller.validate(controller.phoneController.text)) {
                      await controller.handleSignInByPhone();
                      Get.toNamed(RoutePaths.otpConfirmation);
                    } else {
                      Get.snackbar(
                        "Auth Error",
                        "Please enter a valid auth credentials",
                        icon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xffA9CBFF),
                        margin: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 10.w,
                        ),
                        colorText: Colors.black,
                      );
                    }
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
