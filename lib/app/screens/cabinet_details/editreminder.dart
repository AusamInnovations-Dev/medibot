import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../widgets/box_field.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/text_field.dart';

class EditRemindar extends StatelessWidget {
  const EditRemindar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    text: "Edit Reminder",
                    fontFamily: 'Sansation',
                    size: 23.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  CustomTextField(
                    fontWeight: FontWeight.w700,
                    text: "Edit Pill",
                    size: 18.sp,
                    color: Colors.black,
                  )
                ]),
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomBox(
                      margin: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 10.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 12.h),
                      topLeft: Radius.circular(17.r),
                      bottomRight: Radius.circular(17.r),
                      boxHeight: 243.h,
                      boxWidth: 320.w,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          CustomTextField(
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Morning, Afternoon, Evening, Night",
                            maxLines: 2,
                            color: Colors.black,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          )
                        ],
                      )),
                ],
              ),
            )
          ]),
    );
  }
}
