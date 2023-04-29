import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/background_screen_decoration.dart';
import '../../widgets/box_field.dart';
import '../../widgets/text_field.dart';

class EditSlot extends StatelessWidget {
  const EditSlot({Key? key}) : super(key: key);

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
                text: "Edit Reminder",
                fontFamily: 'Sansation',
                size: 23.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              CustomTextField(
                fontWeight: FontWeight.w700,
                text: "Select Slots",
                color: Colors.black,
                fontFamily: 'Sansation',
                size: 18.sp,
              )
            ],
          ),
          CustomBox(
              margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 9.h),
              topLeft: Radius.circular(17.r),
              bottomRight: Radius.circular(17.r),
              boxHeight: 120.h,
              boxWidth: 320.w,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'Sansation',
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: 'Select Slot for '),
                        TextSpan(
                          text: 'Pill 1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: 293.w,
                    height: 39.h,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                          child: Text('Hello'),
                        )
                      ],
                      onChanged: (value) {},
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        shadows: [],
                        color: Colors.black,
                        size: 30.sp,
                      ),
                    ),
                  )
                ],
              )),
          CustomBox(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 9.h),
              topLeft: Radius.circular(17.r),
              bottomRight: Radius.circular(17.r),
              boxHeight: 120.h,
              boxWidth: 320.w,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 17.sp,
                        fontFamily: 'Sansation',
                        color: Colors.black,
                      ),
                      children: const [
                        TextSpan(text: 'Select Slot for '),
                        TextSpan(
                          text: 'Pill 2',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    width: 293.w,
                    height: 39.h,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: DropdownButtonFormField<String>(
                      items: [],
                      onChanged: (value) {},
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        shadows: [],
                        color: Colors.black,
                        size: 30.sp,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
