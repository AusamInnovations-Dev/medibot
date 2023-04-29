import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/box_field.dart';

import '../../widgets/text_field.dart';

class StockView extends StatelessWidget {
  const StockView({Key? key}) : super(key: key);

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
                    text: "Cabinet Management",
                    fontFamily: 'Sansation',
                    size: 23.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  CustomTextField(
                    fontWeight: FontWeight.w700,
                    text: "Existing Pills",
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
                      boxHeight: 230.h,
                      boxWidth: 320.w,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            fontWeight: FontWeight.w700,
                            size: 17.sp,
                            text: "Slot 1",
                            color: Colors.black,
                          ),
                          CustomTextField(
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Pill Name",
                            color: Colors.black,
                          ),
                          CustomTextField(
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Interval",
                            color: Colors.black,
                          ),
                          CustomTextField(
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Morning, Afternoon, Evening, Night",
                            maxLines: 2,
                            color: Colors.black,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: const [
                                TextSpan(text: 'Remaining Pills '),
                                TextSpan(
                                  text: '    30',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: const [
                                TextSpan(text: 'Remaining Days '),
                                TextSpan(
                                  text: '   10',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  CustomBox(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 12.h),
                      topLeft: Radius.circular(17.r),
                      bottomRight: Radius.circular(17.r),
                      boxHeight: 230.h,
                      boxWidth: 320.w,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            fontWeight: FontWeight.w700,
                            size: 17.sp,
                            text: "Slot 1",
                            color: Colors.black,
                          ),
                          CustomTextField(
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Pill Name",
                            color: Colors.black,
                          ),
                          CustomTextField(
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Interval",
                            color: Colors.black,
                          ),
                          CustomTextField(
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            size: 17.sp,
                            text: "Morning, Afternoon, Evening, Night",
                            maxLines: 2,
                            color: Colors.black,
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: const [
                                TextSpan(text: 'Remaining Pills '),
                                TextSpan(
                                  text: '    30',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: const [
                                TextSpan(text: 'Remaining Days '),
                                TextSpan(
                                  text: '   10',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  //CustomBox(boxHeight: 243.h, boxWidth: 320.w, body: Column())
                ],
              ),
            )
          ]),
    );
  }
}
