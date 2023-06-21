import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/cabinet_details/widgets/cabinet_duration_widget.dart';

import '../../../widgets/background_screen_decoration.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/view_pills_controller.dart';
import '../widgets/cabinet_time_interval.dart';


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
                  child: CustomTextField(
                    fontWeight: FontWeight.w700,
                    text: 'Pill Name',
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
                //TODO: have to complete layout
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: CustomTextField(
                    fontWeight: FontWeight.w700,
                    text: 'Dosage',
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
                //Have to complete layout
                Container(
                  padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                  child: CustomTextField(
                    text: "Slot",
                    fontFamily: 'Sansation',
                    size: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                //TODO: Have to complete layout
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: CustomTextField(
                    fontWeight: FontWeight.w700,
                    text: 'Interval',
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),

                //TODO:Have to complete layout

                Container(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CustomTextField(
                    fontWeight: FontWeight.w700,
                    text: 'Time',
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
                //TODO: Have to implement the layout
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
                    CustomBox(
                      borders: Border.all(
                        color: Colors.black26,
                      ),
                      offset: 0,
                      boxHeight: 29.h,
                      boxWidth: 240.w,
                      topLeft: Radius.circular(4.r),
                      topRight: Radius.circular(4.r),
                      bottomLeft: Radius.circular(4.r),
                      bottomRight: Radius.circular(4.r),
                      color: Theme.of(context).colorScheme.primary,
                      body: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            size: 17.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            text: controller.pill.pillsQuantity,
                          )
                        ],
                      ),
                      boxShadow: [],
                    ),
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
                //TODO: Have to complete the layout
              ],
            ),
          ),
        ],
      ),
    );
  }
}
