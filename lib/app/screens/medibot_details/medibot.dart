import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../routes/route_path.dart';
import '../../services/user.dart';
import '../../widgets/text_field.dart';
import 'getx_helper/medibot_controller.dart';

class MedibotDetail extends GetView<MedibotController> {
  const MedibotDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: 'Pair Device',
      onbottomButtonPressed: () {
        if (UserStore.to.profile.medibotDetail == '') {
          Get.toNamed(RoutePaths.qrScan);
        } else {
          Get.snackbar(
            "Medibot",
            "Your application is already connected to the device",
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xffA9CBFF),
            margin: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            colorText: Colors.black,
          );
        }
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                fontWeight: FontWeight.w700,
                text: "Existing Pills",
                size: 18.sp,
                color: Colors.black,
              )
            ],
          ),
          Obx(
            () => !controller.isLoading.value
                ? Column(
                    children: [
                      controller.slot1.isNotEmpty
                          ? Obx(
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
                                                  'remainingDays': controller
                                                      .slot1remainingDay.value,
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
                                                      width: 200.w,
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
                                                        maxWidth: 100.w,
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
                            )
                          : Container(),
                      controller.slot2.isNotEmpty
                          ? Obx(
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
                                                width: 200.w,
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
                                                    maxWidth: 100.w,
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
                      )
                          : Container(),
                      controller.slot3.isNotEmpty
                          ? Obx(
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
                                                width: 200.w,
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
                                                    maxWidth: 100.w,
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
                      )
                          : Container(),
                      controller.slot4.isNotEmpty
                          ? Obx(
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
                                                width: 200.w,
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
                                                    maxWidth: 100.w,
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
                      )
                          : Container(),
                      controller.slot5.isNotEmpty
                          ? Obx(
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
                                                width: 200.w,
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
                                                    maxWidth: 100.w,
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
                      )
                          : Container(),
                      controller.slot6.isNotEmpty
                          ? Obx(
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
                                                width: 200.w,
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
                                                    maxWidth: 100.w,
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
                      )
                          : Container(),
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 95.w, vertical: 30.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150.w, 20.h),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                padding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  //horizontal: 100.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              onPressed: () {
                Get.toNamed(RoutePaths.addpillmedibot);
              },
              child: CustomTextField(
                fontWeight: FontWeight.bold,
                text: "Add Pills to Medibot",
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
