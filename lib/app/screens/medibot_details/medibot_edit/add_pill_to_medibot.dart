import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../sampledata/medicines.dart';
import '../../../widgets/background_screen_decoration.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/medibot_add_pill_controller.dart';
import '../widgets/medibot_duration_widget.dart';
import '../widgets/medibot_time_interval.dart';


class AddPill extends GetView<AddMedibotPill> {
  const AddPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: 'Add Medicine',
      onbottomButtonPressed: () async {
        if(controller.pillName.text.isEmpty || controller.medicineCategory.value == 'Select Category'){
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
        }else{
          if(controller.durationDates.isNotEmpty){
            if(controller.slot.value == 0){
              Get.snackbar(
                "Pills Reminder",
                "Please select the slot",
                icon: const Icon(
                  Icons.crisis_alert,
                  color: Colors.black,
                ),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xffA9CBFF),
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                colorText: Colors.black,
              );
            }else{
              if(controller.pillQuantity.text.isEmpty){
                Get.snackbar(
                  "Pills Reminder",
                  "Please enter a valid stock quantity",
                  icon: const Icon(
                    Icons.crisis_alert,
                    color: Colors.black,
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xffA9CBFF),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  colorText: Colors.black,
                );
              }else{
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
                            text: "Remember to add these pills in the Medibot as well to successfully add this reminder.",
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
                                    "Pills is added to your Medibot.",
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
            }
          } else {
            Get.snackbar(
              "Pills Reminder",
              "Please Select the dates to take medicine.",
              icon: const Icon(
                Icons.crisis_alert,
                color: Colors.black,
              ),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color(0xffA9CBFF),
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              colorText: Colors.black,
            );
          }
        }
      },
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  text: "Add Pills to Medibot",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )
              ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20.h, left: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField(
                  isDense: true,
                  autofocus: true,
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
                    enabled: true,
                    prefixText: 'Slot ',
                    hintStyle: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  items: controller.availableSlot
                      .map((element) => DropdownMenuItem(
                    value: element,
                    child: SizedBox(
                      width: 100.w,
                      child: Text(
                        element.toString(),
                        style: TextStyle(
                          fontFamily: 'Sansation',
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )).toList(),
                  onChanged: (value) {
                    controller.slot.value = value!;
                  },
                ),
                SizedBox(height: 15.h),
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
                  )).toList(),
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
                          hintText: controller.medicineCategory.value != 'Select Medicine *' ? '${controller.medicineCategory.value} Name *' : 'Medicine Name *',
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
                      SizedBox(width: 10.w,),
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
                Container(
                  margin: EdgeInsets.only(bottom: 20.h, right: 5.w),
                  child: DropdownButtonFormField(
                    value: 'Once a Day (24 Hours)',
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
                    items: [
                      'Once a Day (24 Hours)',
                      'Twice a Day (12 Hours)',
                      'Thrice a Day (8 Hours)',
                      'Custom',
                      'Hourly'
                    ]
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
                      if (controller.interval.value == 'Custom' || controller.interval.value == 'Hourly') {
                        controller.gererateCustomTimeInterval();
                      } else {
                        controller.selectingTimeIntervals();
                      }
                    },
                  ),
                ),
                Obx(
                  () => MedibotTimeInterval(
                    interval: controller.interval.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w400,
                        text: "Stock *",
                        color: Colors.black,
                        size: 15.sp,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if(controller.pillQuantity.text.isEmpty){
                                controller.pillQuantity.text = '1';
                              }
                              if (int.parse(controller.pillQuantity.text) > 1) {
                                controller.pillQuantity.text = (int.parse(controller.pillQuantity.text) - 1).toString();
                              }
                            },
                            child: CustomBox(
                              borders: Border.all(
                                color: Colors.black26,
                              ),
                              offset: 0,
                              color: Theme.of(context).colorScheme.primary,
                              boxHeight: 30.h,
                              boxWidth: 40.w,
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
                              boxShadow: const [],
                            ),
                          ),
                          CustomBox(
                            borders: Border.all(
                              color: Colors.black26,
                            ),
                            offset: 0,
                            boxHeight: 35.h,
                            boxWidth: 240.w,
                            topLeft: Radius.circular(4.r),
                            topRight: Radius.circular(4.r),
                            bottomLeft: Radius.circular(4.r),
                            bottomRight: Radius.circular(4.r),
                            color: Theme.of(context).colorScheme.primary,
                            body: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 230.w,
                                  decoration: BoxDecoration(
                                    color:  Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(7.r),
                                      topRight: Radius.circular(7.r),
                                      bottomLeft: Radius.circular(7.r),
                                      bottomRight: Radius.circular(7.r),
                                    ),
                                  ),
                                  padding:  EdgeInsets.symmetric(horizontal: 5.w),
                                  child: TextFormField(
                                    controller: controller.pillQuantity,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    style: const TextStyle(fontSize: 17),
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 17,),
                                      hintText: '',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (val){
                                      if (int.parse(controller.pillQuantity.text) < 0 || val == '') {
                                        controller.pillQuantity.text = '1';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            boxShadow: const [],
                          ),
                          GestureDetector(
                            onTap: () {
                              if(controller.pillQuantity.text.isEmpty){
                                controller.pillQuantity.text = '1';
                              }
                              controller.pillQuantity.text = (int.parse(controller.pillQuantity.text) + 1).toString();
                            },
                            child: CustomBox(
                              borders: Border.all(
                                color: Colors.black26,
                              ),
                              offset: 0,
                              color: Theme.of(context).colorScheme.primary,
                              boxHeight: 30.h,
                              boxWidth: 40.w,
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
                              boxShadow: const [],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  fontWeight: FontWeight.w400,
                  text: "Duration *",
                  color: Colors.black,
                  size: 15.sp,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 7.h,
                ),
                const MedibotDurationPicker()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
