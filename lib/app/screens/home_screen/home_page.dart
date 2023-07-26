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
            ? controller.haveInternet.value
                ? UserStore.to.profile.userStatus == AuthStatus.existingUser
                    ? !controller.loadingUserData.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "${controller.greeting.value},",
                                fontFamily: 'Sansation',
                                size: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              CustomTextField(
                                text: "${UserStore.to.profile.username}!",
                                fontFamily: 'Sansation',
                                size: 23.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              Stack(
                                children: [
                                  CustomBox(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                      horizontal: 23.w,
                                    ),
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r),
                                    bottomLeft: Radius.circular(10.r),
                                    bottomRight: Radius.circular(10.r),
                                    boxHeight: 263.h,
                                    boxWidth: 290.w,
                                    body: Column(
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
                                            percent: (controller
                                                    .pillsTaken.value /
                                                controller.pillsToTake.value),
                                            backgroundColor: Colors.white,
                                            center: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: 15.h,
                                                    bottom: 8.h,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      CustomTextField(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        text: "Due at",
                                                        size: 15.sp,
                                                        color: Colors.black,
                                                      ),
                                                      CustomTextField(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        text: controller
                                                                .reminderList
                                                                .isEmpty
                                                            ? '--/--'
                                                            : controller.checkDue() !=
                                                                    ''
                                                                ? controller
                                                                    .checkDue()
                                                                : '--/--',
                                                        size: 18.sp,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8.h),
                                                  child: Column(
                                                    children: [
                                                      CustomTextField(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        text: "Last Taken at",
                                                        size: 15.sp,
                                                        color: Colors.black,
                                                      ),
                                                      Obx(
                                                        () => CustomTextField(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          text: controller
                                                                  .historyList
                                                                  .isEmpty
                                                              ? '--/--'
                                                              : controller
                                                                      .historyList[controller
                                                                          .pillIndex
                                                                          .value]
                                                                      .timeTaken
                                                                      .isEmpty
                                                                  ? '--/--'
                                                                  : "${controller.historyList[controller.pillIndex.value].timeTaken.last.hour > 12 ? (controller.historyList[controller.pillIndex.value].timeTaken.last.hour - 12) > 9 ? controller.historyList[controller.pillIndex.value].timeTaken.last.hour - 12 : '0${controller.historyList[controller.pillIndex.value].timeTaken.last.hour - 12}' : controller.historyList[controller.pillIndex.value].timeTaken.last.hour}:${(controller.historyList[controller.pillIndex.value].timeTaken.last.minute) > 9 ? controller.historyList[controller.pillIndex.value].timeTaken.last.minute : '0${controller.historyList[controller.pillIndex.value].timeTaken.last.minute}'} ${controller.historyList[controller.pillIndex.value].timeTaken.last.hour > 12 ? 'PM' : 'AM'}",
                                                          size: 15.sp,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      ),
                                                      CustomTextField(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        text: controller
                                                                .findPillStatus()
                                                            ? "On Time"
                                                            : "Not On Time",
                                                        size: 12.sp,
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
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(55.w, 3.h),
                                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 1.h,
                                                ),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: CustomTextField(
                                                fontWeight: FontWeight.bold,
                                                text: "Edit",
                                                color: Colors.black,
                                                size: 13.sp,
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 120.w,
                                                  alignment: Alignment.center,
                                                  child: CustomTextField(
                                                    fontWeight: FontWeight.bold,
                                                    text: controller.reminderList.isEmpty
                                                        ? '--/--'
                                                        : controller.reminderList[controller.pillIndex.value].pillName,
                                                    color: Colors.black,
                                                    size: 18.sp,
                                                  ),
                                                ),
                                                CustomTextField(
                                                  fontWeight: FontWeight.bold,
                                                  text: "1 Tablet(s)",
                                                  color: Colors.black,
                                                  size: 9.sp,
                                                ),
                                              ],
                                            ),
                                            Obx(
                                              () => ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(55.w, 3.h),
                                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.r),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (!controller.isTaking.value && !controller.isSkipping.value) {
                                                    await controller.skipPill();
                                                  }
                                                },
                                                child:
                                                    !controller.isSkipping.value
                                                        ? CustomTextField(
                                                            fontWeight: FontWeight.bold,
                                                            text: "Skip",
                                                            color: Colors.black,
                                                            size: 13.sp,
                                                          )
                                                        : SizedBox(
                                                            height: 18.h,
                                                            width: 18.w,
                                                            child: const CircularProgressIndicator(),
                                                          ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Obx(
                                          () => ElevatedButton(
                                            onPressed: () async {
                                              if (!controller.isTaking.value && !controller.isSkipping.value) {
                                                await controller.takeNowPill();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(MediaQuery.of(context).size.width * 0.805, 0,),
                                              backgroundColor: Theme.of(context).colorScheme.secondary,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 12.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5.r),
                                              ),
                                            ),
                                            child: !controller.isTaking.value
                                                ? CustomTextField(
                                                    fontWeight: FontWeight.bold,
                                                    text: "Take Now",
                                                    color: Colors.black,
                                                    size: 18.sp,
                                                  )
                                                : SizedBox(
                                                    height: 18.h,
                                                    width: 18.w,
                                                    child: const CircularProgressIndicator(),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 90.h,
                                    child: Visibility(
                                      visible: controller.pillIndex > 0,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if(controller.isSkipping.value || controller.isTaking.value){

                                          }else{
                                            controller.pillIndex.value--;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.r),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 90.h,
                                    right: 0.w,
                                    child: Visibility(
                                      visible: controller.pillIndex.value < controller.reminderList.length - 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if(controller.isSkipping.value || controller.isTaking.value){

                                          }else{
                                            controller.pillIndex.value += 1;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.r),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 10.w,
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 10.w,
                                        right: 5.w,
                                      ),
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
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                              ),
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
                                              margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                                      margin: EdgeInsets.only(left: 10.w, right: 10.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (UserStore.to.profile.cabinetDetail == '') {
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
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                              ),
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
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 26.w,
                                              ),
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
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RoutePaths.qrScan);
                                },
                                child: CustomBox(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10.h,
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
                                ),
                              )
                            ],
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 50.h),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                    : Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.offAndToNamed(RoutePaths.userInformation);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 100.h),
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Text(
                              'Please complete your remaining profile.',
                            ),
                          ),
                        ),
                      )
                : Container(
                    margin: EdgeInsets.symmetric(vertical: 100.h),
                    alignment: Alignment.center,
                    child: const Text(
                      'Please Check your network connection',
                    ),
                  )
            : GestureDetector(
                onTap: () {
                  Get.offAndToNamed(RoutePaths.signInScreen);
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 100.h),
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: const Text(
                      'Please click here to login again',
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
