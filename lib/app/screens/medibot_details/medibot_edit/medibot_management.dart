import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../../sampledata/medicines.dart';
import '../../../widgets/box_field.dart';
import '../../../widgets/text_field.dart';
import '../getx_helper/edit_medibot_controller.dart';
import '../widgets/medibot_edit_time_interval.dart';

class MedibotManagement extends GetView<EditMedibotController> {
  const MedibotManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: "Modify Pill",
      onbottomButtonPressed: () => controller.updatePill(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                text: "Medibot Management",
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
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: 12.w,
              top: 10.h,
              right: 12.w,
              bottom: 15.h,
            ),
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: 530.h,
              maxWidth: 350.w
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 11.w),
                    child: CustomTextField(
                      text: "Slot ${controller.pill.first.slot}",
                      fontFamily: 'Sansation',
                      size: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.pill.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              text: "Medicine ${index+1}",
                              fontFamily: 'Sansation',
                              size: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 5.h,),
                            DropdownButtonFormField(
                              isDense: true,
                              value: controller.medicineCategory[index],
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
                                controller.medicineCategory[index] = value!;
                              },
                            ),
                            SizedBox(height: 10.h,),
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
                                    cursorColor: Colors.black,
                                    controller: controller.pillName[index],
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
                                      hintText: controller.medicineCategory[index] != 'Select Category *' ? '${controller.medicineCategory[index]} Name *' : 'Medicine Name *',
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
                                    controller.pillName[index].text = suggestion as String;
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
                                      cursorColor: Colors.black,
                                      controller: controller.dosageController[index],
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
                                      value: controller.dosage[index],
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
                                        controller.dosage[index] = value!;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  controller.pill.first.slot != 6 ? CustomTextField(
                    fontWeight: FontWeight.w400,
                    text: "Interval",
                    color: Colors.black,
                    size: 15.sp,
                    textAlign: TextAlign.start,
                  ): Container(),
                  controller.pill.first.slot != 6 ? SizedBox(height: 10.h,): Container(),
                  controller.pill.first.slot != 6 ? Container(
                    margin: EdgeInsets.only(bottom: 20.h, right: 5.w),
                    child: DropdownButtonFormField(
                      value: controller.interval.value,
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
                            width: 250.w,
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
                  ): Container(),
                  Obx(
                        () => MedibotEditTimeInterval(
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
                              boxWidth: 220.w,
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
                                    width: 210.w,
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
                  SizedBox(height: 10.h,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
