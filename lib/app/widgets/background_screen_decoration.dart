import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medibot/app/widgets/forward_button.dart';
import 'package:medibot/app/widgets/text_field.dart';

class ScreenDecoration extends StatelessWidget {
  final Widget body;
  final String bottomButtonText;
  final bool haveArrow;
  final Function()? onbottomButtonPressed;
  const ScreenDecoration(
      {required this.body,
      this.onbottomButtonPressed,
      this.bottomButtonText = '',
      this.haveArrow = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: SvgPicture.asset(
                "assets/images/uppercircle.svg",
                height: 160.h,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.w, left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    size: 30.sp,
                    fontWeight: FontWeight.w700,
                    text: "MediBot",
                    color: Colors.black,
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 35.w),
                      child: body,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: bottomButtonText != ''
          ? haveArrow ?
           Container(
                  height: 50.h,
                  margin: EdgeInsets.only(
                    bottom: 10.h,
                    right: 20.w,
                    left: 20.w,
                    top: 10.h,
                  ),
                  alignment: Alignment.center,
                  child: ForwardButton(
                    width: 330.w,
                    text: bottomButtonText,
                    padding: EdgeInsets.symmetric(vertical: 18.w),
                    iconSize: 22.h,
                    onPressed: onbottomButtonPressed ??
                        () {
                          log('Hello');
                        },
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(
                    bottom: 2.h,
                    right: 20.w,
                    left: 20.w,
                    top: 2.h,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: CustomTextField(
                      text: "Change PIN",
                      fontFamily: 'Sansation',
                      size: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                )
          : Container(
              height: 0,
            ),
    );
  }
}
