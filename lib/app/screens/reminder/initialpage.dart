import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/custom_input.dart';

import '../../widgets/box_field.dart';
import '../../widgets/text_field.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

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
                text: "Add Reminder",
                fontFamily: 'Sansation',
                size: 23.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  fontWeight: FontWeight.w400,
                  text: "Pill Name",
                  color: Colors.black,
                  size: 13.sp,
                ),
                Container(
                  //color: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 339.w,
                  height: 39.h,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.close_outlined,
                        color: Colors.black,
                        size: 20.sp,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
