import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/background_screen_decoration.dart';
import '../../widgets/text_field.dart';
import 'getx_helper/history_details_controller.dart';

class HistoryDetailsPage extends GetView<HistoryDetailsController> {
  const HistoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                    controller.morning.isNotEmpty ?
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                topRight: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                                bottomRight: Radius.circular(5.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: CustomTextField(
                              text: 'Morning',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.morning.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 180.w,
                                      child: CustomTextField(
                                        fontWeight: FontWeight.bold,
                                        text: controller.morning[index]['pillName'],
                                        color: Colors.black,
                                        size: 18.sp,
                                      ),
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: controller.morning[index]['schedule'],
                                      color: controller.morning[index]['schedule'] == 'Missed' ? Colors.red : controller.morning[index]['schedule'] != 'Taken' ? Colors.amber :  Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : Container(),
                    controller.afternoon.isNotEmpty ?
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 10.h
                      ),
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                topRight: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                                bottomRight: Radius.circular(5.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: CustomTextField(
                              text: 'Afternoon',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.afternoon.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 180.w,
                                      child: CustomTextField(
                                        fontWeight: FontWeight.bold,
                                        text: controller.afternoon[index]['pillName'],
                                        color: Colors.black,
                                        size: 18.sp,
                                      ),
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: controller.afternoon[index]['schedule'],
                                      color: controller.afternoon[index]['schedule'] == 'Missed' ? Colors.red : controller.afternoon[index]['schedule'] != 'Taken' ? Colors.amber:  Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : Container(),
                    controller.evening.isNotEmpty ?
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 10.h
                      ),
                      margin: EdgeInsets.only(top: 15.h),
                      padding: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                topRight: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                                bottomRight: Radius.circular(5.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: CustomTextField(
                              text: 'Evening',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.evening.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 180.w,
                                      child: CustomTextField(
                                        fontWeight: FontWeight.bold,
                                        text: controller.evening[index]['pillName'],
                                        color: Colors.black,
                                        size: 18.sp,
                                      ),
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: controller.evening[index]['schedule'],
                                      color: controller.evening[index]['schedule'] == 'Missed' ? Colors.red : controller.evening[index]['schedule'] != 'Taken' ? Colors.amber:  Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : Container(),
                    controller.night.isNotEmpty ?
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 10.h
                      ),
                      padding: EdgeInsets.only(
                        bottom: 10.h,
                      ),
                      margin: EdgeInsets.only(top: 15.h, bottom: 40.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                          bottomLeft: Radius.circular(5.r),
                          bottomRight: Radius.circular(5.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                topRight: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                                bottomRight: Radius.circular(5.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: CustomTextField(
                              text: 'Night',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.night.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 180.w,
                                      child: CustomTextField(
                                        fontWeight: FontWeight.bold,
                                        text: controller.night[index]['pillName'],
                                        color: Colors.black,
                                        size: 18.sp,
                                      ),
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: controller.night[index]['schedule'],
                                      color: controller.night[index]['schedule'] == 'Missed' ? Colors.red : controller.night[index]['schedule'] != 'Taken' ? Colors.amber:  Colors.lightGreen,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
