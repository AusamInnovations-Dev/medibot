import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/reminder/getx_helper/set_reminder_controller.dart';
import 'package:medibot/app/screens/reminder/widgets/time_interval.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import '../../routes/route_path.dart';
import '../../sampledata/medicines.dart';
import '../../widgets/box_field.dart';
import '../../widgets/text_field.dart';
import 'widgets/select_duration.dart';

class SetReminderScreen extends GetView<SetReminderController> {
  const SetReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: '',
      onbottomButtonPressed: () async {
        log('Hello world');
        if (await controller.uploadPillsReminderData()) {
          Get.snackbar(
            "Pills Reminder",
            "Your pill is scheduled successfully.",
            icon: const Icon(
              Icons.check_sharp,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
          Get.offAndToNamed(RoutePaths.homeScreen);
        } else {
          Get.snackbar(
            "Pills Reminder",
            "Some error has occurred while uploading the data.",
            icon: const Icon(
              Icons.check_sharp,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        }
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Add Reminder",
            fontFamily: 'Sansation',
            size: 23.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      style: TextStyle(
                        fontFamily: 'Sansation',
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      controller: controller.pillName,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.primary,
                        focusColor: Theme.of(context).colorScheme.primary,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black26,
                          ),
                        ),
                        hintText: 'Pill Name',
                        hintStyle: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context, itemData) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          border: Border.all(
                            color: Colors.white12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 5.r,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: CustomTextField(
                          fontWeight: FontWeight.w700,
                          text: itemData,
                          color: Colors.black,
                          size: 16.sp,
                        ),
                      );
                    },
                    hideOnEmpty: true,
                    onSuggestionSelected: (Object? suggestion) {
                      controller.pillName.text = suggestion as String;
                    },
                    suggestionsCallback: (String pattern) {
                      return SampleMedicine.sampleMedicines
                          .where((element) => element.startsWith(pattern));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h, right: 12.w, bottom: 15.h),
                  child: DropdownButtonFormField(
                    dropdownColor: Theme.of(context).colorScheme.primary,
                    focusColor: Theme.of(context).colorScheme.primary,
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      focusColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      hintText: 'Dosage',
                      hintStyle: TextStyle(
                        fontFamily: 'Sansation',
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    items: SampleMedicine.medicinePower
                        .map(
                          (element) => DropdownMenuItem(
                            value: element,
                            child: SizedBox(
                              width: 280.w,
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
                Container(
                  margin: EdgeInsets.only(bottom: 20.h, right: 12.w),
                  child: DropdownButtonFormField(
                    value: 'Once a Day',
                    dropdownColor: Theme.of(context).colorScheme.primary,
                    focusColor: Theme.of(context).colorScheme.primary,
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.primary,
                      focusColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      hintText: 'Interval',
                      hintStyle: TextStyle(
                        fontFamily: 'Sansation',
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    items:
                        ['Once a Day', 'Twice a Day', 'Thrice a Day', 'Custom']
                            .map(
                              (element) => DropdownMenuItem(
                                value: element,
                                child: SizedBox(
                                  width: 280.w,
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
                    onChanged: (value) {
                      controller.interval.value = value!;
                      if (controller.interval.value == 'Custom') {
                        controller.gererateCustomTimeInterval();
                      } else {
                        controller.selectingTimeIntervals();
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CustomTextField(
                    fontWeight: FontWeight.w400,
                    text: 'Set Time',
                    color: Colors.black,
                    size: 14.sp,
                  ),
                ),
                Obx(
                  () => TimeInterval(
                    interval: controller.interval.value,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      fontWeight: FontWeight.w400,
                      text: "Quantity",
                      color: Colors.black,
                      size: 15.sp,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.pillQuantity.value != 1) {
                              controller.pillQuantity.value--;
                            }
                          },
                          child: CustomBox(
                            borders: Border.all(
                              color: Colors.black26,
                            ),
                            offset: 0,
                            color: Theme.of(context).colorScheme.primary,
                            boxHeight: 29.h,
                            boxWidth: 35.w,
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
                            boxShadow: [],
                          ),
                        ),
                        Obx(
                          () => CustomBox(
                            borders: Border.all(
                              color: Colors.black26,
                            ),
                            offset: 0,
                            boxHeight: 29.h,
                            boxWidth: 240.w,
                            topLeft: Radius.circular(4.r),
                            topRight: Radius.circular(4.r),
                            bottomLeft: Radius.circular(4.r),
                            bottomRight: Radius.circular(4.r),
                            color: Theme.of(context).colorScheme.primary,
                            body: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  size: 17.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  text:
                                      controller.pillQuantity.value.toString(),
                                )
                              ],
                            ),
                            boxShadow: [],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.pillQuantity.value != 10) {
                              controller.pillQuantity.value++;
                            }
                          },
                          child: CustomBox(
                              borders: Border.all(
                                color: Colors.black26,
                              ),
                              offset: 0,
                              color: Theme.of(context).colorScheme.primary,
                              boxHeight: 29.h,
                              boxWidth: 35.w,
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
                              boxShadow: []),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  fontWeight: FontWeight.w400,
                  text: "Duration",
                  color: Colors.black,
                  size: 15.sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 7.h,
                ),
                const SelectDuration(),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
