import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/view_reminders/widget/select_duration.dart';
import '../../sampledata/medicines.dart';
import '../../widgets/background_screen_decoration.dart';
import '../../widgets/text_field.dart';
import 'getx_helper/add_prescription_controller.dart';

class AddPrescriptions extends GetView<AddPrescriptionController> {
  const AddPrescriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: 'Add Prescription',
      onbottomButtonPressed: () async {
        if(!controller.uploading.value){
          if (controller.pickedImage == null && controller.durationDates.isEmpty) {
            Get.snackbar(
              "Pills Reminder",
              "Please either select a media or fill the manual details properly",
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
                        text: "Are you sure you want to add this prescription",
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
                            if (await controller.addPrescription() != '') {
                              Get.back();
                              Get.snackbar(
                                "Pills Reminder",
                                "Your prescription is added successfully",
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
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Add Prescription",
            fontFamily: 'Sansation',
            size: 23.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.imageUrl.isNotEmpty ?
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 15.w,
                    runSpacing: 10.h,
                    runAlignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(controller.imageUrl.length, (i) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: Get.context!,
                          traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                          builder: (context) => Material(
                            type: MaterialType.transparency,
                            child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                contentPadding: EdgeInsets.zero,
                                content: InteractiveViewer(
                                  child: Image.file(
                                    File(controller.imageUrl[i]),
                                    fit: BoxFit.contain,
                                    height: 500.h,
                                  ),
                                ),
                                icon: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                )
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: controller.imageUrl.length == 1
                            ? MediaQuery.of(context).size.width
                            : controller.imageUrl.length % 3 == 1 && i == controller.imageUrl.length-1
                            ? MediaQuery.of(context).size.width
                            : controller.imageUrl.length % 3 == 2 && (i <= controller.imageUrl.length-1 && i >= controller.imageUrl.length-2)
                            ? 140.w
                            : 90.w,
                        child: controller.imageUrl[i].startsWith('http')
                            ? Image.network(controller.imageUrl[i])
                            : Image.file(File(controller.imageUrl[i])),
                      ),
                    )),
                  ): Container(),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(350.w, 50.h),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(
                          vertical: 1.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17.r),
                            bottomRight: Radius.circular(17.r),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await controller.upload();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30.sp,
                            color: Colors.black,
                          ),
                          CustomTextField(
                            fontWeight: FontWeight.bold,
                            text: "Upload Prescription media",
                            color: Colors.black,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: CustomTextField(
                      fontWeight: FontWeight.bold,
                      text: "Or Enter Prescription Manually",
                      color: Colors.black,
                      size: 15.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17.r),
                        bottomRight: Radius.circular(17.r),
                      ),
                    ),
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
                            hintText: 'Medicine Category',
                            hintStyle: TextStyle(
                              fontFamily: 'Sansation',
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          items: SampleMedicine.medicineCategory.map((element) => DropdownMenuItem(
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
                            controller.medicineCategory.value = value!;
                          },
                        ),
                        SizedBox(height: 15.h),
                        Obx(
                         () => TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              cursorColor: Colors.black,
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
                                hintText: controller.medicineCategory.value != 'Select Medicine ' ? '${controller.medicineCategory.value} Name ' : 'Medicine Name ',
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
                        Container(
                          margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
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
                                  items: SampleMedicine.medicinePower.map((element) => DropdownMenuItem(
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
                          margin: EdgeInsets.only(bottom: 20.h),
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
                            items: ['Once a Day (24 Hours)', 'Twice a Day (12 Hours)', 'Thrice a Day (8 Hours)', 'Custom', 'Hourly']
                                .map(
                                  (element) => DropdownMenuItem(
                                value: element,
                                child: SizedBox(
                                  width: 260.w,
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
                            ).toList(),
                            onChanged: (value) {
                              controller.interval.value = value!;
                            },
                          ),
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
                        const SelectPrescriptionDuration(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
