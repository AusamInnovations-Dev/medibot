import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../sampledata/medicines.dart';
import '../../../widgets/background_screen_decoration.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/custom_text_view.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/add_existing_slot_controller.dart';

class AddPillInExistingSlot extends GetView<AddExistingSlotController> {
  const AddPillInExistingSlot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: 'Add Medicine',
      onbottomButtonPressed: () async {
        if (controller.pillName.text.isEmpty ||
            controller.medicineCategory.value == 'Select Category') {
          Get.snackbar(
            "Pills Reminder",
            "Please enter a valid medicine name and category",
            icon: const Icon(
              Icons.crisis_alert,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            colorText: Colors.black,
          );
        } else {
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: CustomTextField(
                      text: "Are you sure you want to add in this existing slot",
                      fontFamily: 'Sansation',
                      size: 15.sp,
                      maxLines: 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: CustomTextField(
                          text: "No",
                          fontFamily: 'Sansation',
                          size: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          if (await controller.uploadMedibotPills()) {
                            Get.back();
                            Get.snackbar(
                              "Pills Reminder",
                              "Pills is added to your cabinet.",
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
                        child: CustomTextField(
                          text: "Yes",
                          fontFamily: 'Sansation',
                          size: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Medibot Management",
            fontFamily: 'Sansation',
            size: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          CustomTextField(
            fontWeight: FontWeight.w700,
            text: "Add Medicine in Slot ${controller.pill.slot}",
            size: 18.sp,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                  isDense: true,
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  focusColor: Theme.of(context).colorScheme.primary,
                  style: TextStyle(
                    fontFamily: 'Sansation',
                    fontSize: 15.sp,
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
                    hintText: 'Medicine Category *',
                    hintStyle: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  items: SampleMedicine.medicineCategory
                      .map((element) => DropdownMenuItem(
                            value: element,
                            child: SizedBox(
                              width: 100.w,
                              child: Text(
                                element,
                                style: TextStyle(
                                  fontFamily: 'Sansation',
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.medicineCategory.value = value!;
                  },
                ),
                SizedBox(height: 15.h),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: Obx(
                    () => TypeAheadField(
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
                          hintText: controller.medicineCategory.value !=
                                  'Select Category *'
                              ? '${controller.medicineCategory.value} Name *'
                              : 'Medicine Name *',
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
                        return SampleMedicine.sampleMedicines.where((element) => element.toLowerCase().startsWith(pattern.toLowerCase()));

                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.h, right: 5.w, bottom: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120.w,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          controller: controller.dosageController,
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
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          isDense: true,
                          dropdownColor: Theme.of(context).colorScheme.primary,
                          focusColor: Theme.of(context).colorScheme.primary,
                          style: TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 15.sp,
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
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          value: controller.dosage,
                          items: SampleMedicine.medicinePower
                              .map(
                                (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      element,
                                      style: TextStyle(
                                        fontFamily: 'Sansation',
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.dosage = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //Have to complete layout
                Container(
                  padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        text: "Slot",
                        fontFamily: 'Sansation',
                        size: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 329.w,
                        Text: controller.pill.slot.toString(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: 'Interval',
                        color: Colors.black,
                        size: 14.sp,
                      ),
                      CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 329.w,
                        Text: controller.pill.interval,
                        boxcolor: Theme.of(context).colorScheme.secondary,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w700,
                        text: 'Time Interval',
                        color: Colors.black,
                        size: 14.sp,
                      ),
                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                itemCount: controller.pillIntervals.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 4.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomTextView(
                                          boxHeight: 32.h,
                                          boxWidth: 59.w,
                                          Text: controller.pillIntervals[index]['hour'],
                                          textAlign: TextAlign.center,
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
                                        CustomTextView(
                                          boxHeight: 32.h,
                                          boxWidth: 65.w,
                                          Text: controller.pillIntervals[index]['minute'],
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        CustomTextView(
                                          boxHeight: 32.h,
                                          boxWidth: 59.w,
                                          Text: controller.pillIntervals[index]['period'],
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      fontWeight: FontWeight.w700,
                      text: "Quantity",
                      color: Colors.black,
                      size: 15.sp,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: CustomTextView(
                        boxHeight: 36.h,
                        boxWidth: 250.w,
                        Text: controller.pill.pillsQuantity,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextField(
                  fontWeight: FontWeight.w700,
                  text: "Duration",
                  color: Colors.black,
                  size: 15.sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
                      child: CustomTextField(
                        size: 13.sp,
                        fontWeight: FontWeight.w400,
                        text: controller.pill.isIndividual
                            ? "Individual Date(s)"
                            : 'Range',
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 11.w),
                      width: 360.w,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.pill.pillsDuration.length,
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
                                    text: '${DateTime.parse(controller.pill.pillsDuration[index]).day}/${DateTime.parse(controller.pill.pillsDuration[index]).month}/${DateTime.parse(controller.pill.pillsDuration[index]).year}',
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
