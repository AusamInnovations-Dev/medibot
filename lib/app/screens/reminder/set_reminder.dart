import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/box_field.dart';
import 'package:medibot/app/widgets/circular_button.dart';
import 'package:medibot/app/widgets/custom_checkbox.dart';
import 'package:medibot/app/widgets/forward_button.dart';

import '../../widgets/custom_input.dart';
import '../../widgets/text_field.dart';

class SetReminder extends StatelessWidget {
  final List<String> interval = ["Morning", "Afternoon", "Evening", "Night"];
  SetReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: 'Continue',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                text: "Add Reminder",
                fontFamily: 'Sansation',
                size: 23.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              CustomTextField(
                fontWeight: FontWeight.w700,
                text: "Add Pills",
                color: Colors.black,
                fontFamily: 'Sansation',
                size: 18.sp,
              )
            ],
          ),
          CustomBox(
              margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 9.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              topLeft: Radius.circular(17.r),
              bottomRight: Radius.circular(17.r),
              boxHeight: 304.h,
              boxWidth: 320.w,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 3.w),
                          child: CustomTextField(
                            text: "Pill Name",
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
                          fontTheme: 'Sansation',
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    child: CustomTextField(
                      text: "Interval",
                      fontFamily: 'Sansation',
                      size: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Wrap(
                      runSpacing: 10.w,
                      spacing: 20.w,
                      children: List.generate(
                        4,
                        (index) => CustomCheckBox(
                          text: interval[index],
                          checked: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    child: CustomTextField(
                      text: "Duration",
                      fontFamily: 'Sansation',
                      size: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.primary,
                        width: 140.w,
                        height: 39.h,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                                color: Colors.black,
                                size: 11.sp,
                                fontWeight: FontWeight.w100,
                                text: "Start Date"),
                            Icon(Icons.calendar_today_outlined)
                          ],
                        ),
                      ),
                      Container(
                        color: Theme.of(context).colorScheme.primary,
                        width: 140.w,
                        height: 39.h,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                                color: Colors.black,
                                size: 11.sp,
                                fontWeight: FontWeight.w100,
                                text: "End Date"),
                            Icon(Icons.calendar_today_outlined)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 9.h),
            child: ElevatedButton(
              onPressed: () {
                // controller.handleSigning();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 0),
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(
                  vertical: 11.h,
                  // horizontal: 100.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
              child: CustomTextField(
                text: "Add new pill +",
                fontFamily: 'Sansation',
                size: 13.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
