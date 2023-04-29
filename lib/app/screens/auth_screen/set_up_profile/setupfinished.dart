import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/text_field.dart';

class Setup extends StatelessWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/images/cylinder.svg",
                  height: 111.h,
                ),
              ],
            )),
            Positioned(
                top: 210.h,
                left: 85.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/img_1.png",
                      height: 170,
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    CustomTextField(
                      textAlign: TextAlign.center,
                      text: "Setup Complete!",
                      fontFamily: 'Sansation',
                      size: 27.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    CustomTextField(
                      textAlign: TextAlign.center,
                      text: "Enjoy using MediBot!",
                      fontFamily: 'Sansation',
                      size: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ],
                )),
            Positioned(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/images/circlular.svg",
                  height: 150.h,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
