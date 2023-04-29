import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/backward_button.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_input_button.dart';
import '../../../widgets/forward_button.dart';
import '../../../widgets/text_field.dart';

class CaretakerInfo extends StatelessWidget {
  const CaretakerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              text: "MediBot",
              fontFamily: 'Sansation',
              size: 34.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            SvgPicture.asset(
              "assets/images/cylinder.svg",
              height: 96.h,
            ),
          ],
        ),
        toolbarHeight: 80.h,
      ),
      body: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomBox(
            boxHeight: 320.h,
            boxWidth: 264.w,
            margin: const EdgeInsets.symmetric(horizontal: 48),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
            topRight: Radius.circular(17.r),
            bottomLeft: Radius.circular(17.r),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 22.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 3.w),
                          child: CustomTextField(
                              size: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              text: "What's your caretaker's name?"),
                        ),
                        CustomInputField(
                            boxHeight: 36.h,
                            boxWidth: 232.w,
                            hintText: "",
                            fontTheme: 'Sansation')
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                            size: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            text: "Caretaker's Address"),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomInputField(
                              boxHeight: 36.h,
                              boxWidth: 167.w,
                              hintText: "",
                              fontTheme: 'Sansation'),
                          InputButton(
                              height: 27.5.h,
                              width: 57.w,
                              text: "Fetch current location",
                              fontWeight: FontWeight.w500,
                              textsize: 9.sp,
                              onPressed: (() {}))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3.w),
                        child: CustomTextField(
                            size: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            text: "Caretaker's Contact Number"),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomInputField(
                              boxHeight: 36.h,
                              boxWidth: 167.w,
                              hintText: "",
                              fontTheme: 'Sansation'),
                          InputButton(
                              height: 27.5.h,
                              width: 57.w,
                              text: "Select Contact",
                              fontWeight: FontWeight.w500,
                              textsize: 9.sp,
                              onPressed: (() {}))
                        ],
                      ),
                    ],
                  ),
                ),
                ForwardButton(
                  width: 255.w,
                  text: 'Continue',
                  padding: EdgeInsets.symmetric(vertical: 9.w),
                  iconSize: 18.h,
                  onPressed: () {
                    log('HelloWorld');
                  },
                )
              ],
            )),
      )),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/images/circlular.svg",
            height: 145.h,
          ),
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: BackwardButton(
              text: 'Go Back',
              onPressed: () {},
              iconSize: 18.w,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              width: 120.w,
            ),
          )
        ],
      ),
    );
  }
}
