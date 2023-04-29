import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medibot/app/widgets/box_field.dart';

import '../../widgets/background_screen_decoration.dart';
import '../../widgets/text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Good Morning, username!",
            fontFamily: 'Sansation',
            size: 23.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 30.w,
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomBox(
                        boxHeight: 90.h,
                        boxWidth: 140.w,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomBox(
                        boxHeight: 90.h,
                        boxWidth: 140.w,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomBox(
                        boxHeight: 90.h,
                        boxWidth: 140.w,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomBox(
                        boxHeight: 90.h,
                        boxWidth: 140.w,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
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
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomBox(
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
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
      ),
    );
  }
}
