import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../widgets/box_field.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_input_button.dart';
import '../../widgets/text_field.dart';

class CaretakerSettings extends StatelessWidget {
  const CaretakerSettings({Key? key}) : super(key: key);

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
                  text: "Edit Caretaker",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ]),
          CustomBox(
              margin: EdgeInsets.symmetric(vertical: 55.h, horizontal: 15.h),
              padding: EdgeInsets.only(left: 12.w, top: 20.h, right: 12.w),
              topLeft: Radius.circular(17.r),
              bottomRight: Radius.circular(17.r),
              boxHeight: 320.h,
              boxWidth: 302.w,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                          text: "What’s your caretaker’s name?",
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
                        padding: EdgeInsets.only(bottom: 6.w),
                        child: CustomTextField(
                          text: "Caretaker's Address",
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
                              boxWidth: 216.w,
                              hintText: "",
                              fontTheme: 'Sansation'),
                          InputButton(
                              height: 110.h,
                              width: 57.w,
                              
                              text: "Fetch current location",
                              fontWeight: FontWeight.w500,
                              textsize: 9.sp,
                              onPressed: (() {}))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 3.w),
                          child: CustomTextField(
                              size: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              text: "Caretaker’s Contact Number"),
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomInputField(
                                bottomr: Radius.zero,
                                topr: Radius.zero,
                                boxHeight: 36.h,
                                boxWidth: 199.w,
                                hintText: "",
                                fontTheme: 'Sansation'),
                            InputButton(
                                height: 27.55.h,
                                width: 73.w,
                                text: "Select Contact",
                                fontWeight: FontWeight.w500,
                                textsize: 9.sp,
                                onPressed: (() {}))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
