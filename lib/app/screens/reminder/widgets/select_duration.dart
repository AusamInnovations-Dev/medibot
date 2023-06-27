import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/reminder/getx_helper/set_reminder_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';

class SelectDuration extends GetView<SetReminderController> {
  const SelectDuration({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Row(
                children: [
                  Transform.scale(
                    scaleX: 1.5,
                    scaleY: 1.5,
                    child: Checkbox(
                      activeColor: const Color(0xffCEE2FF),
                      checkColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      value: controller.isRange.value,
                      onChanged: (value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              content: SizedBox(
                                height: 200.h,
                                width: 300.w,
                                child: getDateRangePicker(context),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  CustomTextField(
                    size: 13.sp,
                    fontWeight: FontWeight.w400,
                    text: "Date Range",
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Obx(
              () => Row(
                children: [
                  Transform.scale(
                    scaleX: 1.5,
                    scaleY: 1.5,
                    child: Checkbox(
                      activeColor: Theme.of(context).colorScheme.primary,
                      focusColor: Theme.of(context).colorScheme.primary,
                      checkColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      value: controller.isIndividual.value,
                      hoverColor: Colors.black,
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).colorScheme.primary),
                      onChanged: (value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              content: SizedBox(
                                height: 200.h,
                                width: 300.w,
                                child: getMultipleDates(context),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.w),
                    child: CustomTextField(
                      size: 13.sp,
                      fontWeight: FontWeight.w400,
                      text: "Pick Individual Date(s)",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Obx(
          () => Container(
            margin: EdgeInsets.only(right: 11.w),
            //height: 100.h,
            width: 360.w,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.durationDates.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    child: CustomBox(
                      boxHeight: 36.h,
                      boxWidth: 200.w,
                      topLeft: Radius.circular(4.r),
                      topRight: Radius.circular(4.r),
                      bottomLeft: Radius.circular(4.r),
                      bottomRight: Radius.circular(4.r),
                      boxShadow: [],
                      borders: Border.all(color: Colors.black26),
                      body: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 11.h, horizontal: 7.w),
                        child: CustomTextField(
                          fontWeight: FontWeight.w400,
                          text:
                              '${controller.durationDates[index].day}/${controller.durationDates[index].month}/${controller.durationDates[index].year}',
                          color: Colors.black,
                          size: 12.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(110.w, 20.h),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              padding: EdgeInsets.symmetric(
                vertical: 1.h,
                //horizontal: 100.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            onPressed: () async {
              if (await controller.uploadPillsReminderData() != '') {
                Get.back();
              }
            },
            child: CustomTextField(
              fontWeight: FontWeight.bold,
              text: "Add Pill",
              size: 12.sp,
              color: Colors.black,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget getDateRangePicker(context) {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      cancelText: 'Cancel',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      rangeSelectionColor: Theme.of(context).colorScheme.secondary,
      selectionMode: DateRangePickerSelectionMode.range,
      showActionButtons: true,
      enablePastDates: false,
      selectionTextStyle: const TextStyle(color: Colors.black),
      rangeTextStyle: const TextStyle(color: Colors.black),
      onCancel: () => Navigator.pop(context),
      onSubmit: (value) {
        if (value is PickerDateRange) {
          final DateTime rangeStartDate = value.startDate!;
          final DateTime rangeEndDate = value.endDate!;
          controller.durationDates.clear();
          controller.durationDates.add(rangeStartDate);
          controller.durationDates.add(rangeEndDate);
          controller.isRange.value = true;
          controller.isIndividual.value = false;
          Navigator.pop(context);
        }
      },
    );
  }

  getMultipleDates(BuildContext context) {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      cancelText: 'Cancel',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      rangeSelectionColor: Theme.of(context).colorScheme.secondary,
      selectionMode: DateRangePickerSelectionMode.multiple,
      showActionButtons: true,
      enablePastDates: false,
      selectionTextStyle: const TextStyle(color: Colors.black),
      rangeTextStyle: const TextStyle(color: Colors.black),
      onCancel: () => Navigator.pop(context),
      onSubmit: (value) {
        if (value is PickerDateRange) {
          final DateTime rangeStartDate = value.startDate!;
          final DateTime rangeEndDate = value.endDate!;
          controller.durationDates.clear();
          controller.durationDates.add(rangeStartDate);
          controller.durationDates.add(rangeEndDate);
        } else if (value is List<DateTime>) {
          controller.durationDates.value = value;
          controller.isRange.value = false;
          controller.isIndividual.value = true;
          Navigator.pop(context);
        }
      },
    );
  }
}
