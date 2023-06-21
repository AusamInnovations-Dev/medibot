import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/box_field.dart';
import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../models/user_model/user_model.dart';
import '../../services/user.dart';
import '../../widgets/background_screen_decoration.dart';
import '../../widgets/text_field.dart';
import 'getx_helper/home_page_controller.dart';

class HomePage extends GetView<HomepageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ScreenDecoration(
        body: UserStore.to.isLogin
            ? UserStore.to.profile.userStatus == AuthStatus.existingUser
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        text: "Good Morning,",
                        fontFamily: 'Sansation',
                        size: 23.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      CustomTextField(
                        text: "username!",
                        fontFamily: 'Sansation',
                        size: 23.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      Stack(children: [
                        CustomBox(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 23.w),
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                            boxHeight: 243.h,
                            boxWidth: 290.w,
                            body: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 7.h),
                                    child: CircularPercentIndicator(
                                      progressColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      radius: 90.r,
                                      lineWidth: 15.0,
                                      percent: .25,
                                      backgroundColor: Colors.white,
                                      center: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 27.h,
                                              bottom: 8.h,
                                            ),
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  fontWeight: FontWeight.bold,
                                                  text: "Due in",
                                                  size: 12.sp,
                                                  color: Colors.black,
                                                ),
                                                CustomTextField(
                                                  fontWeight: FontWeight.bold,
                                                  text: "00 : 05 : 00",
                                                  size: 18.sp,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 15.h),
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  fontWeight: FontWeight.bold,
                                                  text: "Last Taken at",
                                                  size: 8.sp,
                                                  color: Colors.black,
                                                ),
                                                CustomTextField(
                                                  fontWeight: FontWeight.bold,
                                                  text: "08:35 PM",
                                                  size: 10.sp,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                CustomTextField(
                                                  fontWeight: FontWeight.bold,
                                                  text: "On Time",
                                                  size: 8.sp,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(55.w, 3.h),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 1.h,
                                            // horizontal: 100.w,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: CustomTextField(
                                          fontWeight: FontWeight.bold,
                                          text: "Edit",
                                          color: Colors.white,
                                          size: 11.sp,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CustomTextField(
                                            fontWeight: FontWeight.bold,
                                            text: "Pill Name",
                                            color: Colors.black,
                                            size: 15.sp,
                                          ),
                                          CustomTextField(
                                            fontWeight: FontWeight.bold,
                                            text: "1 Tablet(s)",
                                            color: Colors.black,
                                            size: 9.sp,
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(55.w, 3.h),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 1.h,
                                            // horizontal: 100.w,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: CustomTextField(
                                          fontWeight: FontWeight.bold,
                                          text: "Skip",
                                          color: Colors.white,
                                          size: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.805,
                                            0),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                          // horizontal: 100.w,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                      ),
                                      child: CustomTextField(
                                        fontWeight: FontWeight.bold,
                                        text: "Take Now",
                                        color: Colors.white,
                                        size: 18.sp,
                                      )),
                                ],
                              ),
                            )),
                        Positioned(
                          top: 90.h,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.h,
                                  // horizontal: 100.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              )),
                        ),
                        Positioned(
                          top: 90.h,
                          right: 0.w,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.h,
                                  // horizontal: 100.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              )),
                        )
                      ]),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10.w,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10.w, right: 5.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RoutePaths.newreminder);
                                    },
                                    child: CustomBox(
                                      boxHeight: 90.h,
                                      boxWidth: 140.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      body: Align(
                                        alignment: Alignment.center,
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                          size: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          text: "Set new Reminder",
                                          maxLines: 2,
                                        ),
                                      ),
                                      topLeft: Radius.circular(17.r),
                                      bottomRight: Radius.circular(17.r),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RoutePaths.historyPage);
                                    },
                                    child: CustomBox(
                                      boxHeight: 90.h,
                                      boxWidth: 140.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      body: Align(
                                        alignment: Alignment.center,
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                          size: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          text: "History",
                                          maxLines: 2,
                                        ),
                                      ),
                                      topLeft: Radius.circular(17.r),
                                      bottomRight: Radius.circular(17.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w, right: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (UserStore.to.profile.cabinetDetail ==
                                          '') {
                                        Get.snackbar(
                                          "Cabinet",
                                          "Please link with a cabinet for using this feature",
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
                                      } else {
                                        Get.toNamed(RoutePaths.cabinetdetail);
                                      }
                                    },
                                    child: CustomBox(
                                      boxHeight: 90.h,
                                      boxWidth: 140.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      body: Align(
                                        alignment: Alignment.center,
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                          size: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          text: "Cabinet Details",
                                          maxLines: 2,
                                        ),
                                      ),
                                      topRight: Radius.circular(17.r),
                                      bottomLeft: Radius.circular(17.r),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RoutePaths.userSetting);
                                    },
                                    child: CustomBox(
                                      boxHeight: 90.h,
                                      boxWidth: 140.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 26.w),
                                      body: Align(
                                        alignment: Alignment.center,
                                        child: CustomTextField(
                                          textAlign: TextAlign.center,
                                          color: Colors.black,
                                          size: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          text: "User Settings",
                                          maxLines: 2,
                                        ),
                                      ),
                                      topRight: Radius.circular(17.r),
                                      bottomLeft: Radius.circular(17.r),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomBox(
                        margin: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 10.h,
                        ),
                        topLeft: Radius.circular(17.r),
                        bottomRight: Radius.circular(17.r),
                        boxHeight: 58.h,
                        boxWidth: 310.w,
                        body: Align(
                          alignment: Alignment.center,
                          child: CustomTextField(
                            textAlign: TextAlign.center,
                            color: Colors.black,
                            size: 13.sp,
                            fontWeight: FontWeight.w700,
                            text: "Pair Device",
                            maxLines: 2,
                          ),
                        ),
                      )
                    ],
                  )
                : Container()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
                    child: const CircularProgressIndicator(),
                  ),
                ],
              ),
      ),
    );
  }
}
