import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/auth_screen/getx_helper/auth_controller.dart';
import 'package:medibot/app/widgets/custom_input.dart';
import '../../widgets/box_field.dart';
import '../../widgets/text_field.dart';

class SignIn extends GetView<AuthController> {
  const SignIn({Key? key}) : super(key: key);

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
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomBox(
                  boxWidth: MediaQuery.of(context).size.width * 0.8,
                  boxHeight: MediaQuery.of(context).size.height * 0.5,
                  margin: const EdgeInsets.symmetric(horizontal: 48),
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                  topRight: Radius.circular(17.r),
                  bottomLeft: Radius.circular(17.r),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              fontTheme: 'Sansation',
                              type: TextInputType.number,
                              textController: controller.phoneController,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
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
                                text: "Email Address",
                              ),
                            ),
                            CustomInputField(
                              boxHeight: 35.h,
                              boxWidth: 265.w,
                              hintText: "",
                              fontTheme: 'Sansation',
                              textController: controller.emailController,
                            ),
                            SizedBox(height: 8.h,),
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
                              boxWidth: 265.w,
                              hintText: "",
                              fontTheme: 'Sansation',
                              obsecure: true,
                              textController: controller.passwordController,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {

                          if(controller.phoneController.text.isNotEmpty && controller.emailController.text.isNotEmpty){
                            Get.snackbar(
                              "Auth Error",
                              "Please select any one field to login.",
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
                          }else{
                            if(controller.phoneController.text.isNotEmpty){
                              if (controller.validate(controller.phoneController.text)) {
                                if (await controller.checkUserAccountByPhone()) {
                                  await controller.handleSignInByPhone();
                                  Get.toNamed(RoutePaths.otpConfirmation);
                                }else{
                                  Get.snackbar(
                                    "Auth Error",
                                    "User doesn't exist with this phone number",
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
                              } else {
                                Get.snackbar(
                                  "Auth Error",
                                  "Please enter a valid phone number",
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
                            }else if(controller.emailController.text.isNotEmpty){
                              if(await controller.checkUserAccountByMail()) {
                                if(GetUtils.isEmail(controller.emailController.text)) {
                                  await controller.handleSignInByEmail();
                                }else {
                                    Get.snackbar(
                                      "Auth Error",
                                      "Please enter a valid email address",
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
                              }else {
                                Get.snackbar(
                                  "Auth Error",
                                  "You Don't have any account with this number/email please create one.",
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
                            }
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
                          text: "Login",
                          fontFamily: 'Sansation',
                          size: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutePaths.createUser);
                        },
                        child: CustomTextField(
                          text: "Don't have an account yet? Create One",
                          fontFamily: 'Sansation',
                          size: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
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
        children: [
          SvgPicture.asset(
            "assets/images/circlular.svg",
            height: 145.h,
          ),
        ],
      ),
    );
  }
}
