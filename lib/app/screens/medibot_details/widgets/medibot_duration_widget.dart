import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/medibot_add_pill_controller.dart';

class MedibotDurationPicker extends GetView<AddMedibotPill> {
  const MedibotDurationPicker({super.key});

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
                      overlayColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.primary),
                      onChanged: (value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
              child: !controller.isRange.value
                  ? ListView.builder(
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
                            boxShadow: const [],
                            borders: Border.all(color: Colors.black26),
                            body: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 11.h,
                                horizontal: 7.w,
                              ),
                              child: CustomTextField(
                                fontWeight: FontWeight.w400,
                                text: '${controller.durationDates[index].day}/${controller.durationDates[index].month}/${controller.durationDates[index].year}',
                                color: Colors.black,
                                size: 12.sp,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          fontWeight: FontWeight.bold,
                          text: "From",
                          size: 12.sp,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          child: CustomBox(
                            boxHeight: 36.h,
                            boxWidth: 400.w,
                            topLeft: Radius.circular(4.r),
                            topRight: Radius.circular(4.r),
                            bottomLeft: Radius.circular(4.r),
                            bottomRight: Radius.circular(4.r),
                            boxShadow: const [],
                            borders: Border.all(color: Colors.black26),
                            body: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 11.h,
                                horizontal: 7.w,
                              ),
                              child: CustomTextField(
                                fontWeight: FontWeight.w400,
                                text:
                                    '${controller.durationDates.first.day}/${controller.durationDates.first.month}/${controller.durationDates.first.year}',
                                color: Colors.black,
                                size: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        CustomTextField(
                          fontWeight: FontWeight.bold,
                          text: "To",
                          size: 12.sp,
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          child: CustomBox(
                            boxHeight: 36.h,
                            boxWidth: 400.w,
                            topLeft: Radius.circular(4.r),
                            topRight: Radius.circular(4.r),
                            bottomLeft: Radius.circular(4.r),
                            bottomRight: Radius.circular(4.r),
                            boxShadow: const [],
                            borders: Border.all(color: Colors.black26),
                            body: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 11.h,
                                horizontal: 7.w,
                              ),
                              child: CustomTextField(
                                fontWeight: FontWeight.w400,
                                text: '${controller.durationDates.last.day}/${controller.durationDates.last.month}/${controller.durationDates.last.year}',
                                color: Colors.black,
                                size: 12.sp,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
      viewSpacing: 30.w,
      backgroundColor: Colors.transparent,
      rangeSelectionColor: const Color(0xff041c50),
      selectionMode: DateRangePickerSelectionMode.range,
      showActionButtons: true,
      enablePastDates: false,
      todayHighlightColor: const Color(0xff041c50),
      selectionShape: DateRangePickerSelectionShape.rectangle,
      monthCellStyle: DateRangePickerMonthCellStyle(
        cellDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
        ),
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
        ),
        todayCellDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: const Color(0xff041c50),
          ),
        ),
      ),
      endRangeSelectionColor: const Color(0xff041c50),
      startRangeSelectionColor: const Color(0xff041c50),
      selectionRadius: 15.r,
      selectionTextStyle: const TextStyle(
        color: Colors.white,
      ),
      rangeTextStyle: const TextStyle(color: Colors.white),
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
      todayHighlightColor: const Color(0xff041c50),
      selectionShape: DateRangePickerSelectionShape.rectangle,
      monthCellStyle: DateRangePickerMonthCellStyle(
        cellDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
        ),
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
        ),
        todayCellDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: const Color(0xff041c50),
          ),
        ),
      ),
      showActionButtons: true,
      enablePastDates: false,
      selectionTextStyle: const TextStyle(color: Colors.white),
      rangeTextStyle: const TextStyle(color: Colors.white),
      selectionColor: const Color(0xff041c50),
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
