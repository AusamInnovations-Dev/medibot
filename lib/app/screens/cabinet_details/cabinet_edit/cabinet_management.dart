import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../../routes/route_path.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/edit_cabinet_controller.dart';

class CabinetManagement extends GetView<EditCabinetController> {
  const CabinetManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      //bottomButtonText: "Modify Pill",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  text: "Cabinet Management",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                CustomTextField(
                  text: "Edit Existing Pill",
                  fontFamily: 'Sansation',
                  size: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )
              ]),
          CustomBox(
              margin: EdgeInsets.symmetric(vertical: 55.h, horizontal: 15.h),
              padding: EdgeInsets.only(
                left: 12.w,
                top: 10.h,
                right: 12.w,
                bottom: 15.h,
              ),
              topLeft: Radius.circular(17.r),
              bottomRight: Radius.circular(17.r),
              boxHeight: 300.h,
              boxWidth: 302.w,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 11.w),
                        child: CustomTextField(
                          text: "Slot 1",
                          fontFamily: 'Sansation',
                          size: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      //TODO: Have to complete layout.
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 11.h),
                        child: CustomTextField(
                          text: "Interval",
                          fontFamily: 'Sansation',
                          size: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.h, right: 2.w),
                        child: DropdownButtonFormField(
                          value: 'Once a Day',
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          focusColor: Theme.of(context).colorScheme.primary,
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                          ),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.primary,
                            focusColor: Theme.of(context).colorScheme.primary,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            hintText: 'Interval',
                            hintStyle: TextStyle(
                              fontFamily: 'Sansation',
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          items: [
                            'Once a Day',
                            'Twice a Day',
                            'Thrice a Day',
                            'Custom'
                          ]
                              .map(
                                (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 220.w,
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  CustomInputField(
                    boxHeight: 39.h,
                    boxWidth: 293.w,
                    hintText: "Remaining Pills",
                    fontTheme: 'Sansation',
                  ),
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'Sansation',
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(text: 'Remaining Days '),
                        TextSpan(
                          text: '   ${controller.remainingDay}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 95.w, vertical: 30.h),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150.w, 20.h),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  padding: EdgeInsets.symmetric(
                    vertical: 1.h,
                    //horizontal: 100.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RoutePaths.cabinetdetail);
                },
                child: CustomTextField(
                  fontWeight: FontWeight.bold,
                  text: "Modify Pill",
                  size: 12.sp,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}
