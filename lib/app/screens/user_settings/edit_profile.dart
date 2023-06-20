import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/box_field.dart';
import 'package:medibot/app/widgets/custom_input_button.dart';

import '../../widgets/custom_input.dart';
import '../../widgets/text_field.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  text: "Edit User Profile",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ]),
          CustomBox(
            margin: EdgeInsets.symmetric(vertical: 45.h, horizontal: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            topLeft: Radius.circular(17.r),
            bottomRight: Radius.circular(17.r),
            boxHeight: 340.h,
            boxWidth: 310.w,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 3.w),
                      child: CustomTextField(
                        text: "What's your name",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 3.w),
                      child: CustomTextField(
                        text: "And your age please?",
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 6.w),
                        child: CustomTextField(
                          text: "Address",
                          fontFamily: 'Sansation',
                          size: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomInputField(
                            bottomr: Radius.zero,
                            topr: Radius.zero,
                            boxHeight: 118.h,
                            boxWidth: 217.w,
                            hintText: "",
                            fontTheme: 'Sansation',
                          ),
                          InputButton(
                            height: 110.h,
                            width: 63.w,
                            text: "Fetch current location",
                            fontWeight: FontWeight.w500,
                            textsize: 9.sp,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 28.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: CustomTextField(
                          size: 13.sp,
                          fontWeight: FontWeight.w400,
                          text: "Do you have a caretaker?",
                          color: Colors.black,
                        ),
                      ),
                      Transform.scale(
                        scaleX: 2.0,
                        scaleY: 2.1,
                        child: Checkbox(
                          activeColor: const Color(0xffCEE2FF),
                          checkColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          value: true,
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomButtonText: "",
      onbottomButtonPressed: () {},
    );
  }
}
