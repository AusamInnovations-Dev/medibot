import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/cabinet_details/getx_helper/cabinet_controller.dart';

import '../../../../routes/route_path.dart';
import '../../../../sampledata/medicines.dart';
import '../../../../widgets/background_screen_decoration.dart';
import '../../../../widgets/box_field.dart';
import '../../../../widgets/text_field.dart';

class AddPill extends GetView<CabinetController> {
  const AddPill({Key? key}) : super(key: key);

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
                  text: "Add Pills to Cabinet",
                  fontFamily: 'Sansation',
                  size: 23.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )
              ]),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 5.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 11.w),
                      child: CustomTextField(
                        text: "Pill Name",
                        fontFamily: 'Sansation',
                        size: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
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
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 11.h, top: 11.h),
                      child: CustomTextField(
                        text: "Slot",
                        fontFamily: 'Sansation',
                        size: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 5.h,
                        right: 11.w,
                      ),
                      child: DropdownButtonFormField(
                        value: 'Slot 1',
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
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        items: [
                          'Slot 1',
                          'Slot 2',
                          'Slot 3',
                          'Slot 4',
                          'Slot 5',
                          'Slot 6',
                        ]
                            .map(
                              (element) => DropdownMenuItem(
                                value: element,
                                child: SizedBox(
                                  //width: 150.w,

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
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        fontWeight: FontWeight.w400,
                        text: "Total Number of Tablets",
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
                                    text: controller.pillQuantity.value
                                        .toString(),
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
                              boxShadow: [],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
              top: 225.w,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210.w, 20.h),
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
                if (await controller.uploadCabinetPills()) {
                  Get.back();
                }
              },
              child: CustomTextField(
                fontWeight: FontWeight.bold,
                text: "Add Pill to Cabinet",
                size: 12.sp,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
