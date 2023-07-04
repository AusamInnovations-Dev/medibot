import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/background_screen_decoration.dart';
import '../../widgets/box_field.dart';
import '../../widgets/text_field.dart';
import 'getx_helper/history_details_controller.dart';

class HistoryDetailsPage extends GetView<HistoryDetailsController> {
  const HistoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Obx(
          () => !controller.isLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomTextField(
                      text: "History",
                      fontFamily: 'Sansation',
                      size: 23.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    CustomTextField(
                      color: Colors.black,
                      size: 18.sp,
                      fontWeight: FontWeight.w700,
                      text: "Day View - ${controller.date.day}/${controller.date.month}/${controller.date.year}",
                    ),
                    controller.morning != [] ?
                    CustomBox(
                      margin: EdgeInsets.only(top: 30.h),
                      body: Column(
                        children: [
                          CustomBox(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            boxWidth: double.maxFinite,
                            boxHeight: 40.h,
                            topLeft: Radius.circular(5.r),
                            topRight: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                            bottomRight: Radius.circular(5.r),
                            body: CustomTextField(
                              text: 'Morning',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.morning.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextField(
                                    fontWeight: FontWeight.bold,
                                    text: controller.morning[index]['pillName'],
                                    color: Colors.black,
                                    size: 18.sp,
                                  ),
                                  CustomTextField(
                                    fontWeight: FontWeight.bold,
                                    text: controller.morning[index]['schedule'],
                                    color: Colors.lightGreen,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      boxHeight: 160.h,
                      boxWidth: double.maxFinite,
                    ) : Container(),
                    controller.afternoon != [] ?
                    CustomBox(
                      margin: EdgeInsets.only(top: 30.h),
                      body: Column(
                        children: [
                          CustomBox(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            boxWidth: double.maxFinite,
                            boxHeight: 40.h,
                            topLeft: Radius.circular(5.r),
                            topRight: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                            bottomRight: Radius.circular(5.r),
                            body: CustomTextField(
                              text: 'Afternoon',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          Container(
                            height: 100.h,
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 1',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Taken',
                                      color: Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 2',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Not Taken',
                                      color: Colors.red,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 3',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Not Taken',
                                      color: Colors.red,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      boxHeight: 160.h,
                      boxWidth: double.maxFinite,
                    ) : Container(),
                    controller.evening != [] ?
                    CustomBox(
                      margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                      body: Column(
                        children: [
                          CustomBox(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            boxWidth: double.maxFinite,
                            boxHeight: 40.h,
                            topLeft: Radius.circular(5.r),
                            topRight: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                            bottomRight: Radius.circular(5.r),
                            body: CustomTextField(
                              text: 'Evening',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          Container(
                            height: 100.h,
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 1',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Taken',
                                      color: Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 2',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Not Taken',
                                      color: Colors.red,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 3',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Not Taken',
                                      color: Colors.red,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      boxHeight: 160.h,
                      boxWidth: double.maxFinite,
                    ) : Container(),
                    controller.night != [] ?
                    CustomBox(
                      margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
                      body: Column(
                        children: [
                          CustomBox(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            boxWidth: double.maxFinite,
                            boxHeight: 40.h,
                            topLeft: Radius.circular(5.r),
                            topRight: Radius.circular(5.r),
                            bottomLeft: Radius.circular(5.r),
                            bottomRight: Radius.circular(5.r),
                            body: CustomTextField(
                              text: 'Night',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          Container(
                            height: 100.h,
                            margin: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 1',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Taken',
                                      color: Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 2',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Not Taken',
                                      color: Colors.red,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Pill 3',
                                      color: Colors.black,
                                      size: 18.sp,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: 'Not Taken',
                                      color: Colors.red,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      boxHeight: 160.h,
                      boxWidth: double.maxFinite,
                    ) : Container(),

                  ],
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: const CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
