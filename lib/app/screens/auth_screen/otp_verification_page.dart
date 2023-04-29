
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/user_model/user_model.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/getx_helper/auth_controller.dart';
import 'package:medibot/app/widgets/box_field.dart';

import '../../services/user.dart';
import '../../widgets/backward_button.dart';
import '../../widgets/forward_button.dart';
import '../../widgets/text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends GetView<AuthController> {
  OtpVerificationScreen({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code = "";
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
            boxHeight: 270.h,
            boxWidth: 160.w,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            topRight: Radius.circular(17.r),
            bottomLeft: Radius.circular(17.r),
            body: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Sansation',
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'An One Time Password has been sent to '),
                      TextSpan(
                        text: '+91 XXXXXX ${controller.phoneController.text.substring(7, 10)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sansation',
                        ),
                      ),
                      const TextSpan(text: ', please enter the OTP here.'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 25.w, bottom: 15.w, left: 10.w, right: 10.w),
                  child: Center(
                    child: PinCodeTextField(
                      autoFocus: true,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.none,
                      cursorColor: Colors.black,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        fieldOuterPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        inactiveColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        // borderWidth: 0,
                        selectedFillColor:
                            Theme.of(context).colorScheme.primary,
                        activeColor: Theme.of(context).colorScheme.primary,
                        activeFillColor: Theme.of(context).colorScheme.primary,
                        inactiveFillColor:
                            Theme.of(context).colorScheme.primary,
                        errorBorderColor: null,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.zero,
                        fieldHeight: 50,
                        fieldWidth: 40,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      onCompleted: (value) {},
                      onChanged: (value) {
                        code = value;
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                      controller: controller.otpController,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 22.w),
                  child: CustomTextField(
                    size: 12.sp,
                    fontWeight: FontWeight.w500,
                    text: "Not yet received? Send Again",
                    color: Colors.black,
                  ),
                ),
                ForwardButton(
                  width: 255.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 9.w),
                  iconSize: 18.h,
                  onPressed: () async {
                    try {
                      await controller.otpVerification();
                      if (UserStore.to.profile.userStatus != AuthStatus.newUser) {
                        Get.offAllNamed(RoutePaths.homeScreen);
                      } else {
                        Get.offAllNamed(RoutePaths.userInformation);
                      }
                    } catch (e) {
                      log('This is the error $e');
                      Get.snackbar(
                        "Authentication",
                        "invalid otp entered",
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
