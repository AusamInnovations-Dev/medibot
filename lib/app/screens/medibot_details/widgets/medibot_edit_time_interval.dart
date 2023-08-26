import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/sampledata/medicines.dart';
import 'package:medibot/app/screens/medibot_details/getx_helper/edit_medibot_controller.dart';
import 'package:medibot/app/widgets/box_field.dart';

import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/text_field.dart';

class MedibotEditTimeInterval extends GetView<EditMedibotController> {
  final String interval;

  const MedibotEditTimeInterval({required this.interval, super.key});

  @override
  Widget build(BuildContext context) {
    if (interval != 'Custom') {
      if (interval != 'Hourly') {
        return Obx(
              () => MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.timeIntervals.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomDropDown(
                        boxWidth: 68.w,
                        boxHeight: 30.h,
                        value:
                        controller.timeIntervals[index]['hour'] as String,
                        margin: EdgeInsets.symmetric(
                          vertical: 2.h,
                        ),
                        dropDownColor: Theme.of(context).colorScheme.primary,
                        focusColor: Theme.of(context).colorScheme.primary,
                        onChange: (value) {
                          controller.timeIntervals[index]['hour'] = value;
                        },
                        items: SampleMedicine.hours
                            .map(
                              (element) => DropdownMenuItem(
                            value: element,
                            child: SizedBox(
                              width: 30.w,
                              child: Text(
                                element,
                                style: TextStyle(
                                  fontFamily: 'Sansation',
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: ':',
                        size: 20.sp,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomDropDown(
                        boxWidth: 68.w,
                        boxHeight: 30.h,
                        margin: EdgeInsets.symmetric(
                          vertical: 2.h,
                        ),
                        value:
                        controller.timeIntervals[index]['minute'] as String,
                        dropDownColor: Theme.of(context).colorScheme.primary,
                        focusColor: Theme.of(context).colorScheme.primary,
                        onChange: (value) {
                          controller.timeIntervals[index]['minute'] = value;
                        },
                        items: SampleMedicine.minute
                            .map(
                              (element) => DropdownMenuItem(
                            value: element,
                            child: SizedBox(
                              width: 32.w,
                              child: Text(
                                element,
                                style: TextStyle(
                                  fontFamily: 'Sansation',
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      CustomDropDown(
                        boxWidth: 68.w,
                        boxHeight: 30.h,
                        margin: EdgeInsets.symmetric(
                          vertical: 2.h,
                        ),
                        value:
                        controller.timeIntervals[index]['period'] as String,
                        dropDownColor: Theme.of(context).colorScheme.primary,
                        focusColor: Theme.of(context).colorScheme.primary,
                        onChange: (value) {
                          controller.timeIntervals[index]['period'] = value;
                        },
                        items: ['AM', 'PM']
                            .map(
                              (element) => DropdownMenuItem(
                            value: element,
                            child: SizedBox(
                              width: 30.w,
                              child: Text(
                                element,
                                style: TextStyle(
                                  fontFamily: 'Sansation',
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return Obx(
              () => Column(
            children: [
              CustomDropDown(
                boxWidth: 100.w,
                boxHeight: 30.h,
                margin: EdgeInsets.symmetric(
                  vertical: 2.h,
                ),
                value: controller.hourlyInterval.value,
                dropDownColor: Theme.of(context).colorScheme.primary,
                focusColor: Theme.of(context).colorScheme.primary,
                onChange: (value) {
                  controller.hourlyInterval.value = value;
                  controller.checkIfIncreasePossible();
                },
                items: ['01 H', '02 H', '03 H', '04 H', '06 H']
                    .map(
                      (element) => DropdownMenuItem(
                    value: element,
                    child: SizedBox(
                      width: 30.w,
                      child: Text(
                        element,
                        style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeLeft: true,
                child: Obx(
                      () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.timeIntervals.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.removeHourlyTimeInterval(index);
                              },
                              child: index == controller.timeIntervals.length - 1 && index != 0
                                  ? CustomBox(
                                offset: 0,
                                color:
                                Theme.of(context).colorScheme.primary,
                                boxHeight: 29.h,
                                topLeft: Radius.circular(4.r),
                                topRight: Radius.circular(4.r),
                                bottomLeft: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                                body: CustomTextField(
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                  text: '-',
                                  fontWeight: FontWeight.w400,
                                  size: 25.sp,
                                ),
                                boxWidth: 33.w,
                                boxShadow: const [],
                              )
                                  : SizedBox(
                                height: 29.h,
                                width: 33.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomDropDown(
                              boxWidth: 68.w,
                              boxHeight: 30.h,
                              margin: EdgeInsets.symmetric(
                                vertical: 2.h,
                              ),
                              value: controller.timeIntervals[index]['hour']
                              as String,
                              dropDownColor:
                              Theme.of(context).colorScheme.primary,
                              focusColor: Theme.of(context).colorScheme.primary,
                              onChange: (value) {
                                controller.timeIntervals[index]['hour'] = value;
                                controller.pillsTime[index] = TimeOfDay(
                                  hour: int.parse(value.substring(0, 2)),
                                  minute: controller.pillsTime[index].minute,
                                );
                              },
                              items: SampleMedicine.hours
                                  .map(
                                    (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 30.w,
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            CustomTextField(
                              fontWeight: FontWeight.w700,
                              text: ':',
                              size: 20.sp,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            CustomDropDown(
                              boxWidth: 68.w,
                              boxHeight: 30.h,
                              margin: EdgeInsets.symmetric(
                                vertical: 2.h,
                              ),
                              value: controller.timeIntervals[index]['minute']
                              as String,
                              dropDownColor:
                              Theme.of(context).colorScheme.primary,
                              focusColor: Theme.of(context).colorScheme.primary,
                              onChange: (value) {
                                log('hello');
                                controller.timeIntervals[index]['minute'] =
                                    value;
                                controller.pillsTime[index] = TimeOfDay(
                                  hour: controller.pillsTime[index].hour,
                                  minute: int.parse(value.substring(0, 2)),
                                );
                              },
                              items: SampleMedicine.minute
                                  .map(
                                    (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 32.w,
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomDropDown(
                              boxWidth: 68.w,
                              boxHeight: 30.h,
                              margin: EdgeInsets.symmetric(
                                vertical: 2.h,
                              ),
                              value: controller.timeIntervals[index]['period'] as String,
                              dropDownColor: Theme.of(context).colorScheme.primary,
                              focusColor: Theme.of(context).colorScheme.primary,
                              onChange: (value) {
                                controller.timeIntervals[index]['period'] =
                                    value;
                              },
                              items: ['AM', 'PM']
                                  .map(
                                    (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 30.w,
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Obx(
                                  () => controller.increasePossible.value
                                  ? GestureDetector(
                                onTap: () {
                                  controller.addHourlyTimeInterval();
                                },
                                child: index == controller.timeIntervals.length - 1
                                    ? CustomBox(
                                  offset: 0,
                                  color: Theme.of(context).colorScheme.primary,
                                  boxHeight: 29.h,
                                  topLeft: Radius.circular(4.r),
                                  topRight: Radius.circular(4.r),
                                  bottomLeft: Radius.circular(4.r),
                                  bottomRight: Radius.circular(4.r),
                                  body: CustomTextField(
                                    color: Colors.black,
                                    textAlign: TextAlign.center,
                                    text: '+',
                                    fontWeight: FontWeight.w400,
                                    size: 25.sp,
                                  ),
                                  boxWidth: 33.w,
                                  boxShadow: const [],
                                )
                                    : SizedBox(
                                  height: 29.h,
                                  width: 33.w,
                                ),
                              )
                                  : SizedBox(
                                height: 29.h,
                                width: 33.w,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } else {
      return Obx(
            () => MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeLeft: true,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.timeIntervals.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.removeCustomTimeInterval(index);
                      },
                      child: index == controller.timeIntervals.length - 1 && index != 0
                          ? CustomBox(
                        offset: 0,
                        color: Theme.of(context).colorScheme.primary,
                        boxHeight: 29.h,
                        topLeft: Radius.circular(4.r),
                        topRight: Radius.circular(4.r),
                        bottomLeft: Radius.circular(4.r),
                        bottomRight: Radius.circular(4.r),
                        body: CustomTextField(
                          color: Colors.black,
                          textAlign: TextAlign.center,
                          text: '-',
                          fontWeight: FontWeight.w400,
                          size: 25.sp,
                        ),
                        boxWidth: 33.w,
                        boxShadow: const [],
                      )
                          : SizedBox(
                        height: 29.h,
                        width: 33.w,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomDropDown(
                      boxWidth: 68.w,
                      boxHeight: 30.h,
                      margin: EdgeInsets.symmetric(
                        vertical: 2.h,
                      ),
                      value: controller.timeIntervals[index]['hour'] as String,
                      dropDownColor: Theme.of(context).colorScheme.primary,
                      focusColor: Theme.of(context).colorScheme.primary,
                      onChange: (value) {
                        controller.timeIntervals[index]['hour'] = value;
                      },
                      items: SampleMedicine.hours
                          .map(
                            (element) => DropdownMenuItem(
                          value: element,
                          child: SizedBox(
                            width: 30.w,
                            child: Text(
                              element,
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomTextField(
                      fontWeight: FontWeight.w700,
                      text: ':',
                      size: 20.sp,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomDropDown(
                      boxWidth: 68.w,
                      boxHeight: 30.h,
                      margin: EdgeInsets.symmetric(
                        vertical: 2.h,
                      ),
                      value:
                      controller.timeIntervals[index]['minute'] as String,
                      dropDownColor: Theme.of(context).colorScheme.primary,
                      focusColor: Theme.of(context).colorScheme.primary,
                      onChange: (value) {
                        controller.timeIntervals[index]['minute'] = value;
                      },
                      items: SampleMedicine.minute
                          .map(
                            (element) => DropdownMenuItem(
                          value: element,
                          child: SizedBox(
                            width: 32.w,
                            child: Text(
                              element,
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomDropDown(
                      boxWidth: 68.w,
                      boxHeight: 30.h,
                      margin: EdgeInsets.symmetric(
                        vertical: 2.h,
                      ),
                      value:
                      controller.timeIntervals[index]['period'] as String,
                      dropDownColor: Theme.of(context).colorScheme.primary,
                      focusColor: Theme.of(context).colorScheme.primary,
                      onChange: (value) {
                        controller.timeIntervals[index]['period'] = value;
                      },
                      items: ['AM', 'PM']
                          .map(
                            (element) => DropdownMenuItem(
                          value: element,
                          child: SizedBox(
                            width: 30.w,
                            child: Text(
                              element,
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addCustomTimeInterval();
                      },
                      child: index == controller.timeIntervals.length - 1
                          ? CustomBox(
                        offset: 0,
                        color: Theme.of(context).colorScheme.primary,
                        boxHeight: 29.h,
                        topLeft: Radius.circular(4.r),
                        topRight: Radius.circular(4.r),
                        bottomLeft: Radius.circular(4.r),
                        bottomRight: Radius.circular(4.r),
                        body: CustomTextField(
                          color: Colors.black,
                          textAlign: TextAlign.center,
                          text: '+',
                          fontWeight: FontWeight.w400,
                          size: 25.sp,
                        ),
                        boxWidth: 33.w,
                        boxShadow: const [],
                      )
                          : SizedBox(
                        height: 29.h,
                        width: 33.w,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
