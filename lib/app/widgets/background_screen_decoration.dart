import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medibot/app/widgets/forward_button.dart';
import 'package:medibot/app/widgets/text_field.dart';

class ScreenDecoration extends StatelessWidget {
  final Widget body;
  final String? bottomButtonText;
  const ScreenDecoration(
      {required this.body, this.bottomButtonText = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              "assets/images/uppercircle.svg",
              height: 175.h,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.w, left: 10.w),
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
                    margin: EdgeInsets.only(top: 50.w),
                    child: body,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomButtonText != ''
          ? Container(
              height: 50.h,
              margin: EdgeInsets.only(bottom: 20.h, right: 20.w, left: 20.w),
              alignment: Alignment.center,
              // child: ForwardBustton(
              //   width: 330.w,
              //   text: 'Continue',
              //   padding: EdgeInsets.symmetric(vertical: 18.w),
              //   iconSize: 22.h,
              //   onPressed: () {
              //     log('HelloWorld');
              //   },
              // ),
            )
          : Container(
              height: 0,
            ),
    );
  }
}
