import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../widgets/text_field.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
                text: "User Settings",
                fontFamily: 'Sansation',
                size: 23.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ]),
        Container(
          margin: EdgeInsets.only(top: 100.h, left: 7.w, bottom: 10.h),
          width: 320.w,
          height: 250.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // controller.handleSigning();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 0),
                  backgroundColor: Color(0xffE1EDFF),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    // horizontal: 100.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
                child: CustomTextField(
                  text: "Edit User Profile",
                  fontFamily: 'Sansation',
                  size: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // controller.handleSigning();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 0),
                  backgroundColor: Color(0xffE1EDFF),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    // horizontal: 100.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
                child: CustomTextField(
                  text: "Change PIN",
                  fontFamily: 'Sansation',
                  size: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // controller.handleSigning();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 0),
                  backgroundColor: Color(0xffE1EDFF),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    // horizontal: 100.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
                child: CustomTextField(
                  text: "Change Care Taker Info",
                  fontFamily: 'Sansation',
                  size: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
