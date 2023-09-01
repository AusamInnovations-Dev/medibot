import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medibot/app/screens/view_reminders/getx_helper/view_controller.dart';

import '../../routes/route_path.dart';
import '../../widgets/background_screen_decoration.dart';
import '../../widgets/box_field.dart';
import '../../widgets/custom_text_view.dart';
import '../../widgets/text_field.dart';

class ViewReminders extends GetView<ViewController> {
  const ViewReminders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Medibot Reminders",
            fontFamily: 'Sansation',
            size: 23.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          CustomTextField(
            fontWeight: FontWeight.w700,
            text: "Existing Reminders",
            size: 18.sp,
            color: Colors.black,
          ),
          Obx(
           () => !controller.isLoading.value ?
           Column(
              children: [
                controller.slot1.isNotEmpty ?
                Obx(
                 () => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutePaths.viewslot,
                        arguments: {
                          'pill': controller.slot1,
                        },
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                          // topLeft: Radius.zero,
                          bottomRight: Radius.circular(15.r),
                          // bottomLeft: Radius.zero,
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                size: 17.sp,
                                text: "Slot 1",
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.medibotManagement,
                                    arguments: {
                                      'pill': controller.slot1,
                                      'remainingDays': controller.slot1remainingDay.value,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Edit",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.addPillInExistingSlot,
                                    arguments: {
                                      'pillModel': controller.slot1.first,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Add",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Remaining Pills ',
                                ),
                                TextSpan(
                                  text: '    ${controller.slot1.first.pillsQuantity}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h,),
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
                                const TextSpan(
                                  text: 'Remaining Days ',
                                ),
                                TextSpan(
                                  text:
                                  '   ${controller.slot1remainingDay.value}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: controller.slot1.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    const Divider(
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextField(
                                              fontWeight: FontWeight.w400,
                                              size: 17.sp,
                                              text: 'Medicine Type: ',
                                              color: Colors.black,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 120.w,
                                                  minWidth: 10.w
                                              ),
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w400,
                                                size: 17.sp,
                                                text: controller.slot1[index].medicineCategory,
                                                color: Colors.black,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              showDialog(
                                                context: Get.context!,
                                                barrierDismissible: false,
                                                traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                                builder: (context) => WillPopScope(
                                                  onWillPop: () async => false,
                                                  child: Obx(
                                                   () => AlertDialog(
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
                                                              text: "Do you want to remove ${controller.slot1[index].pillName}",
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
                                                                onTap: (){
                                                                  controller.deletePill(controller.slot1[index].uid, index, 1);
                                                                  Get.back();
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
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              // color: Colors.white,
                                              size: 20.h,
                                            )
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot1[index].pillName,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 150.w,
                                              minWidth: 10.w
                                          ),
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot1[index].dosage,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),
                controller.slot2.isNotEmpty ?
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutePaths.viewslot,
                        arguments: {
                          'pill': controller.slot2,
                        },
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                          // topLeft: Radius.zero,
                          bottomRight: Radius.circular(15.r),
                          // bottomLeft: Radius.zero,
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                size: 17.sp,
                                text: "Slot 2",
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.medibotManagement,
                                    arguments: {
                                      'pill': controller.slot2,
                                      'remainingDays': controller.slot2remainingDay.value,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Edit",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.addPillInExistingSlot,
                                    arguments: {
                                      'pillModel':
                                      controller.slot2.first,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Add",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Remaining Pills ',
                                ),
                                TextSpan(
                                  text: '    ${controller.slot2.first.pillsQuantity}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h,),
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
                                const TextSpan(
                                  text: 'Remaining Days ',
                                ),
                                TextSpan(
                                  text:
                                  '   ${controller.slot2remainingDay.value}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: controller.slot2.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    const Divider(
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextField(
                                              fontWeight: FontWeight.w400,
                                              size: 17.sp,
                                              text: 'Medicine Type: ',
                                              color: Colors.black,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 120.w,
                                                  minWidth: 10.w
                                              ),
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w400,
                                                size: 17.sp,
                                                text: controller.slot2[index].medicineCategory,
                                                color: Colors.black,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            showDialog(
                                              context: Get.context!,
                                              barrierDismissible: false,
                                              traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                              builder: (context) => WillPopScope(
                                                onWillPop: () async => false,
                                                child: Obx(
                                                  () => AlertDialog(
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
                                                            text: "Do you want to remove ${controller.slot2[index].pillName}",
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
                                                              onTap: (){
                                                                controller.deletePill(controller.slot2[index].uid, index, 2);
                                                                Get.back();
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
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot2[index].pillName,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 150.w,
                                              minWidth: 10.w
                                          ),
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot2[index].dosage,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),
                controller.slot3.isNotEmpty ?
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutePaths.viewslot,
                        arguments: {
                          'pill': controller.slot3,
                        },
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                          // topLeft: Radius.zero,
                          bottomRight: Radius.circular(15.r),
                          // bottomLeft: Radius.zero,
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                size: 17.sp,
                                text: "Slot 3",
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.medibotManagement,
                                    arguments: {
                                      'pill': controller.slot3,
                                      'remainingDays': controller.slot3remainingDay.value,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Edit",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.addPillInExistingSlot,
                                    arguments: {
                                      'pillModel':
                                      controller.slot3.first,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Add",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Remaining Pills ',
                                ),
                                TextSpan(
                                  text: '    ${controller.slot3.first.pillsQuantity}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h,),
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
                                const TextSpan(
                                  text: 'Remaining Days ',
                                ),
                                TextSpan(
                                  text:
                                  '   ${controller.slot3remainingDay.value}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: controller.slot3.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    const Divider(
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextField(
                                              fontWeight: FontWeight.w400,
                                              size: 17.sp,
                                              text: 'Medicine Type: ',
                                              color: Colors.black,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 120.w,
                                                  minWidth: 10.w
                                              ),
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w400,
                                                size: 17.sp,
                                                text: controller.slot3[index].medicineCategory,
                                                color: Colors.black,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: Get.context!,
                                              barrierDismissible: false,
                                              traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                              builder: (context) => WillPopScope(
                                                onWillPop: () async => false,
                                                child: Obx(
                                                  () => AlertDialog(
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
                                                            text: "Do you want to remove ${controller.slot3[index].pillName}",
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
                                                              onTap: (){
                                                                controller.deletePill(controller.slot3[index].uid, index, 3);
                                                                Get.back();
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
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot3[index].pillName,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 150.w,
                                              minWidth: 10.w
                                          ),
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot3[index].dosage,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),
                controller.slot4.isNotEmpty ?
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutePaths.viewslot,
                        arguments: {
                          'pill': controller.slot4,
                        },
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                          // topLeft: Radius.zero,
                          bottomRight: Radius.circular(15.r),
                          // bottomLeft: Radius.zero,
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                size: 17.sp,
                                text: "Slot 4",
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.medibotManagement,
                                    arguments: {
                                      'pill': controller.slot4,
                                      'remainingDays': controller.slot4remainingDay.value,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Edit",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.addPillInExistingSlot,
                                    arguments: {
                                      'pillModel':
                                      controller.slot4.first,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Add",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Remaining Pills ',
                                ),
                                TextSpan(
                                  text: '    ${controller.slot4.first.pillsQuantity}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h,),
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
                                const TextSpan(
                                  text: 'Remaining Days ',
                                ),
                                TextSpan(
                                  text:
                                  '   ${controller.slot4remainingDay.value}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: controller.slot4.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    const Divider(
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextField(
                                              fontWeight: FontWeight.w400,
                                              size: 17.sp,
                                              text: 'Medicine Type: ',
                                              color: Colors.black,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 120.w,
                                                  minWidth: 10.w
                                              ),
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w400,
                                                size: 17.sp,
                                                text: controller.slot4[index].medicineCategory,
                                                color: Colors.black,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: Get.context!,
                                              barrierDismissible: false,
                                              traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                              builder: (context) => WillPopScope(
                                                onWillPop: () async => false,
                                                child: Obx(
                                                  () => AlertDialog(
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
                                                            text: "Do you want to remove ${controller.slot4[index].pillName}",
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
                                                              onTap: (){
                                                                controller.deletePill(controller.slot4[index].uid, index, 4);
                                                                Get.back();
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
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot4[index].pillName,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 150.w,
                                              minWidth: 10.w
                                          ),
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot4[index].dosage,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )  : Container(),
                controller.slot5.isNotEmpty ?
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutePaths.viewslot,
                        arguments: {
                          'pill': controller.slot5,
                        },
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                          // topLeft: Radius.zero,
                          bottomRight: Radius.circular(15.r),
                          // bottomLeft: Radius.zero,
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                size: 17.sp,
                                text: "Slot 5",
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.medibotManagement,
                                    arguments: {
                                      'pill': controller.slot5,
                                      'remainingDays': controller.slot5remainingDay.value,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Edit",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.addPillInExistingSlot,
                                    arguments: {
                                      'pillModel':
                                      controller.slot5.first,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Add",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Remaining Pills ',
                                ),
                                TextSpan(
                                  text: '    ${controller.slot5.first.pillsQuantity}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h,),
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
                                const TextSpan(
                                  text: 'Remaining Days ',
                                ),
                                TextSpan(
                                  text:
                                  '   ${controller.slot5remainingDay.value}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: controller.slot5.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    const Divider(
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextField(
                                              fontWeight: FontWeight.w400,
                                              size: 17.sp,
                                              text: 'Medicine Type: ',
                                              color: Colors.black,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 120.w,
                                                  minWidth: 10.w
                                              ),
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w400,
                                                size: 17.sp,
                                                text: controller.slot5[index].medicineCategory,
                                                color: Colors.black,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: Get.context!,
                                              barrierDismissible: false,
                                              traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                              builder: (context) => WillPopScope(
                                                onWillPop: () async => false,
                                                child: Obx(
                                                  () => AlertDialog(
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
                                                            text: "Do you want to remove ${controller.slot5[index].pillName}",
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
                                                              onTap: (){
                                                                controller.deletePill(controller.slot5[index].uid, index, 5);
                                                                Get.back();
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
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot5[index].pillName,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 150.w,
                                              minWidth: 10.w
                                          ),
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot5[index].dosage,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),
                controller.slot6.isNotEmpty ?
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutePaths.viewslot,
                        arguments: {
                          'pill': controller.slot6,
                        },
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                          // topLeft: Radius.zero,
                          bottomRight: Radius.circular(15.r),
                          // bottomLeft: Radius.zero,
                          topLeft: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                size: 17.sp,
                                text: "Slot 6",
                                color: Colors.black,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.medibotManagement,
                                    arguments: {
                                      'pill': controller.slot6,
                                      'remainingDays': controller.slot6remainingDay.value,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Edit",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    RoutePaths.addPillInExistingSlot,
                                    arguments: {
                                      'pillModel':
                                      controller.slot6.first,
                                    },
                                  );
                                },
                                child: CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: "Add",
                                  size: 12.sp,
                                  color: Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          RichText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: 'Sansation',
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Remaining Pills ',
                                ),
                                TextSpan(
                                  text: '    ${controller.slot6.first.pillsQuantity}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h,),
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
                                const TextSpan(
                                  text: 'Remaining Days ',
                                ),
                                TextSpan(
                                  text:
                                  '   ${controller.slot6remainingDay.value}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontFamily: 'Sansation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              itemCount: controller.slot6.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    const Divider(
                                      color: Colors.black26,
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextField(
                                              fontWeight: FontWeight.w400,
                                              size: 17.sp,
                                              text: 'Medicine Type: ',
                                              color: Colors.black,
                                              maxLines: 1,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 120.w,
                                                  minWidth: 10.w
                                              ),
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w400,
                                                size: 17.sp,
                                                text: controller.slot6[index].medicineCategory,
                                                color: Colors.black,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: Get.context!,
                                              barrierDismissible: false,
                                              traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                              builder: (context) => WillPopScope(
                                                onWillPop: () async => false,
                                                child: Obx(
                                                  () => AlertDialog(
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
                                                            text: "Do you want to remove ${controller.slot6[index].pillName}",
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
                                                              onTap: (){
                                                                controller.deletePill(controller.slot6[index].uid, index, 6);
                                                                Get.back();
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
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot6[index].pillName,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 150.w,
                                              minWidth: 10.w
                                          ),
                                          child: CustomTextField(
                                            fontWeight: FontWeight.w400,
                                            size: 17.sp,
                                            text: controller.slot6[index].dosage,
                                            color: Colors.black,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) : Container(),
                SizedBox(height: 15.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: Alignment.topLeft,
                  child: CustomTextField(
                    fontWeight: FontWeight.w700,
                    size: 20.sp,
                    text: 'App Reminders',
                    color: Colors.black,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: controller.reminders.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var remainingDays = 0;
                        if(controller.reminders[index].isRange){
                          remainingDays = DateTime.parse(controller.reminders[index].pillsDuration.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays+1;
                          if(remainingDays < 0){
                            remainingDays = 0;
                          }
                        }else{
                          var difference = 0;
                          for (var date in controller.reminders[index].pillsDuration) {
                            if (DateTime.parse(date).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
                              difference++;
                            }
                          }
                          remainingDays = difference;
                        }
                        return Container(
                          constraints: BoxConstraints(
                            minHeight: 10.h,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                              // topLeft: Radius.zero,
                              bottomRight: Radius.circular(15.r),
                              // bottomLeft: Radius.zero,
                              topLeft: Radius.circular(15.r),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: CustomTextField(
                                          fontWeight: FontWeight.w400,
                                          size: 17.sp,
                                          text: 'Remaining Days: ',
                                          color: Colors.black,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 150.w,
                                            minWidth: 10.w
                                        ),
                                        child: CustomTextField(
                                          fontWeight: FontWeight.w400,
                                          size: 17.sp,
                                          text: remainingDays.toString(),
                                          color: Colors.black,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: Get.context!,
                                        barrierDismissible: false,
                                        traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                                        builder: (context) => WillPopScope(
                                          onWillPop: () async => false,
                                          child: Obx(
                                                () => AlertDialog(
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
                                                      text: "Do you want to remove ${controller.reminders[index].pillName}",
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
                                                        onTap: (){
                                                          controller.deleteReminderPill(controller.reminders[index].uid, index);
                                                          AwesomeNotifications().dismissNotificationsByGroupKey(controller.reminders[index].uid);
                                                          Get.back();
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
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20.h,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextField(
                                    fontWeight: FontWeight.w400,
                                    size: 17.sp,
                                    text: 'Medicine Type: ',
                                    color: Colors.black,
                                    maxLines: 1,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 120.w,
                                        minWidth: 10.w
                                    ),
                                    child: CustomTextField(
                                      fontWeight: FontWeight.w400,
                                      size: 17.sp,
                                      text: controller.reminders[index].medicineCategory,
                                      color: Colors.black,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: CustomTextField(
                                      fontWeight: FontWeight.w400,
                                      size: 17.sp,
                                      text: controller.reminders[index].pillName,
                                      color: Colors.black,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 150.w,
                                        minWidth: 10.w
                                    ),
                                    child: CustomTextField(
                                      fontWeight: FontWeight.w400,
                                      size: 17.sp,
                                      text: controller.reminders[index].dosage,
                                      color: Colors.black,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
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
                                    SizedBox(height: 5.h,),
                                    CustomTextView(
                                      boxHeight: 36.h,
                                      boxWidth: 329.w,
                                      Text: controller.reminders[index].interval,
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
                                    Container(
                                      margin: EdgeInsets.only(top: 5.h),
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                            itemCount: controller.reminders[index].pillsInterval.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index1) {
                                              var pillIntervals = [];
                                              for(var interval in controller.reminders[index].pillsInterval){
                                                String hour, minute, period;
                                                String date = DateFormat('hh:mm:a').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(interval.substring(0,2)), int.parse(interval.substring(5,7))));
                                                hour = DateFormat('hh').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(interval.substring(0,2)), int.parse(interval.substring(5,7))));
                                                minute = DateFormat('mm').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(interval.substring(0,2)), int.parse(interval.substring(5,7))));
                                                period = date.substring(6,8);
                                                pillIntervals.add({
                                                  'hour': '$hour H',
                                                  'minute': '$minute M',
                                                  'period': period,
                                                });
                                              }
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
                                                      // Text: controller.reminders[index].pillsInterval[index1],
                                                      Text: pillIntervals[index1]['hour'],
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
                                                      // Text: controller.reminders[index].pillsInterval[index1],
                                                      Text: pillIntervals[index1]['minute'],
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    CustomTextView(
                                                      boxHeight: 32.h,
                                                      boxWidth: 59.w,
                                                      // Text: controller.reminders[index].pillsInterval[index1],
                                                      Text: pillIntervals[index1]['period'],
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CustomTextField(
                                fontWeight: FontWeight.w700,
                                text: "Stock",
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
                                  Text: controller.reminders[index].pillsQuantity,
                                  textAlign: TextAlign.center,
                                ),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20.w, bottom: 5.h),
                                    child: CustomTextField(
                                      size: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      text: controller.reminders[index].isIndividual
                                          ? "Individual Date(s)"
                                          : 'Range',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 11.w, bottom: 15.h),
                                    width: 360.w,
                                    child: MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: !controller.reminders[index].isRange ?
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.reminders[index].pillsDuration.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index1) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(vertical: 6.h),
                                            child: CustomBox(
                                              boxHeight: 36.h,
                                              boxWidth: 200.w,
                                              color: Theme.of(context).colorScheme.secondary,
                                              topLeft: Radius.circular(4.r),
                                              topRight: Radius.circular(4.r),
                                              bottomLeft: Radius.circular(4.r),
                                              bottomRight: Radius.circular(4.r),
                                              boxShadow: const [],
                                              body: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 11.h,
                                                  horizontal: 7.w,
                                                ),
                                                child: CustomTextField(
                                                  fontWeight: FontWeight.w400,
                                                  text: '${DateTime.parse(controller.reminders[index].pillsDuration[index1]).day}/${DateTime.parse(controller.reminders[index].pillsDuration[index1]).month}/${DateTime.parse(controller.reminders[index].pillsDuration[index1]).year}',
                                                  color: Colors.black,
                                                  size: 12.sp,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ) : Column(
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
                                              color: Theme.of(context).colorScheme.secondary,
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
                                                  text: '${DateTime.parse(controller.reminders[index].pillsDuration[0]).day}/${DateTime.parse(controller.reminders[index].pillsDuration[0]).month}/${DateTime.parse(controller.reminders[index].pillsDuration[0]).year}',
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
                                              color: Theme.of(context).colorScheme.secondary,
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
                                                  text: '${DateTime.parse(controller.reminders[index].pillsDuration[1]).day}/${DateTime.parse(controller.reminders[index].pillsDuration[1]).month}/${DateTime.parse(controller.reminders[index].pillsDuration[1]).year}',
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
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  )
                ),
                SizedBox(height: 20.h,),
              ],
            ) : Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
