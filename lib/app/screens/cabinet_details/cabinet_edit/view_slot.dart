import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/widgets/custom_text_view.dart';

import '../../../widgets/background_screen_decoration.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/view_pills_controller.dart';

class ViewSlot extends GetView<ViewPillsController> {
  const ViewSlot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: '',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Cabinet Management",
            fontFamily: 'Sansation',
            size: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          CustomTextField(
            fontWeight: FontWeight.w700,
            text: "View Slot",
            size: 18.sp,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: 'Pill Name',
                        color: Colors.black,
                        size: 14.sp,
                      ),
                      CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 329.w,
                        Text: controller.pill.pillName,
                      )
                    ],
                  ),
                ),
                //TODO: have to complete layout
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: 'Dosage',
                        color: Colors.black,
                        size: 14.sp,
                      ),
                      CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 329.w,
                        Text: controller.pill.dosage,
                      )
                    ],
                  ),
                ),
                //Have to complete layout
                Container(
                  padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        text: "Slot",
                        fontFamily: 'Sansation',
                        size: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 329.w,
                        Text: controller.pill.slot.toString(),
                      )
                    ],
                  ),
                ),
                //TODO: Have to complete layout
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: 'Interval',
                        color: Colors.black,
                        size: 14.sp,
                      ),
                      CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 329.w,
                        Text: controller.pill.interval,
                        boxcolor: Theme.of(context).colorScheme.secondary,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: 'Set Time',
                        color: Colors.black,
                        size: 14.sp,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        padding: EdgeInsets.only(top: 10.h),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: controller.pillIntervals.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomTextView(
                                      boxHeight: 32.h,
                                      boxWidth: 59.w,
                                      Text: controller.pillIntervals[index]['hour'],
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomTextField(
                                      fontWeight: FontWeight.w700,
                                      text: ':',
                                      size: 20.sp,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomTextView(
                                      boxHeight: 32.h,
                                      boxWidth: 65.w,
                                      Text: controller.pillIntervals[index]['minute'],
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomTextView(
                                      boxHeight: 32.h,
                                      boxWidth: 59.w,
                                      Text: controller.pillIntervals[index]['period'],
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      fontWeight: FontWeight.w700,
                      text: "Quantity",
                      color: Colors.black,
                      size: 15.sp,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Center(
                      child: CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 250.w,
                        Text: controller.pill.pillsQuantity,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  fontWeight: FontWeight.w700,
                  text: "Duration",
                  color: Colors.black,
                  size: 15.sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: CustomTextField(
                        size: 13.sp,
                        fontWeight: FontWeight.w400,
                        text: controller.pill.isIndividual
                            ? "Individual Date(s)"
                            : 'Range',
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 11.w),
                      //height: 100.h,
                      width: 360.w,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.pill.pillsDuration.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              child: CustomBox(
                                boxHeight: 36.h,
                                boxWidth: 200.w,
                                topLeft: Radius.circular(4.r),
                                topRight: Radius.circular(4.r),
                                bottomLeft: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                                boxShadow: [],
                                borders: Border.all(color: Colors.black26),
                                body: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 11.h, horizontal: 7.w),
                                  child: CustomTextField(
                                    fontWeight: FontWeight.w400,
                                    text:
                                        '${DateTime.parse(controller.pill.pillsDuration[index]).day}/${DateTime.parse(controller.pill.pillsDuration[index]).month}/${DateTime.parse(controller.pill.pillsDuration[index]).year}',
                                    color: Colors.black,
                                    size: 12.sp,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
