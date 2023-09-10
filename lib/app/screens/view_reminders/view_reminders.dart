import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medibot/app/screens/view_reminders/getx_helper/view_controller.dart';

import '../../routes/route_path.dart';
import '../../services/user.dart';
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
                UserStore.to.profile.medibotDetail.isNotEmpty ? Column(
                  children: [
                    controller.slot1.isNotEmpty ?
                    Obx(
                          () => Container(
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
                                  ],
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: controller.slot1.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var days = 0;
                                      if(controller.slot1[index].isRange){
                                        days = DateTime.parse(controller.slot1[index].pillsDuration[1]).difference(DateTime.parse(controller.slot1[index].pillsDuration[0])).inDays+1;
                                      }else {
                                        days = controller.slot1[index].pillsDuration.length;
                                      }
                                      var prescription = '${controller.slot1[index].medicineCategory} ${controller.slot1[index].pillName} ${controller.slot1[index].dosage} ${controller.slot1[index].pillsInterval.length} ${controller.slot1[index].pillsInterval.length > 1 ? 'times' : 'time'} a day for $days days';
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h,),
                                          const Divider(
                                            color: Colors.black26,
                                            // thickness: 1,
                                            height: 2,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            alignment: Alignment.topLeft,
                                            child: CustomTextField(
                                              fontWeight: FontWeight.w600,
                                              size: 14.sp,
                                              text: prescription,
                                              color: Colors.black,
                                              // maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ) : Container(),
                    controller.slot2.isNotEmpty ?
                    Obx(
                          () => Container(
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
                                CustomTextField(
                                  fontWeight: FontWeight.w700,
                                  size: 17.sp,
                                  text: "Slot 2",
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5.h,),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: controller.slot2.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var days = 0;
                                      if(controller.slot2[index].isRange){
                                        days = DateTime.parse(controller.slot2[index].pillsDuration[1]).difference(DateTime.parse(controller.slot2[index].pillsDuration[0])).inDays+1;
                                      }else {
                                        days = controller.slot2[index].pillsDuration.length;
                                      }
                                      var prescription = '${controller.slot2[index].medicineCategory} ${controller.slot2[index].pillName} ${controller.slot2[index].dosage} ${controller.slot2[index].pillsInterval.length} ${controller.slot2[index].pillsInterval.length > 1 ? 'times' : 'time'} a day for $days days';
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4.h,),
                                          const Divider(
                                            color: Colors.black26,
                                            // thickness: 1,
                                            height: 2,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            alignment: Alignment.topLeft,
                                            child: CustomTextField(
                                              fontWeight: FontWeight.w600,
                                              size: 14.sp,
                                              text: prescription,
                                              color: Colors.black,
                                              // maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ) : Container(),
                    controller.slot3.isNotEmpty ?
                    Obx(
                          () => Container(
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
                                CustomTextField(
                                  fontWeight: FontWeight.w700,
                                  size: 17.sp,
                                  text: "Slot 3",
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5.h,),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: controller.slot3.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var days = 0;
                                      if(controller.slot3[index].isRange){
                                        days = DateTime.parse(controller.slot3[index].pillsDuration[1]).difference(DateTime.parse(controller.slot3[index].pillsDuration[0])).inDays+1;
                                      }else {
                                        days = controller.slot3[index].pillsDuration.length;
                                      }
                                      var prescription = '${controller.slot3[index].medicineCategory} ${controller.slot3[index].pillName} ${controller.slot3[index].dosage} ${controller.slot3[index].pillsInterval.length} ${controller.slot3[index].pillsInterval.length > 1 ? 'times' : 'time'} a day for $days days';
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h,),
                                          const Divider(
                                            color: Colors.black26,
                                            // thickness: 1,
                                            height: 2,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            alignment: Alignment.topLeft,
                                            child: CustomTextField(
                                              fontWeight: FontWeight.w600,
                                              size: 14.sp,
                                              text: prescription,
                                              color: Colors.black,
                                              // maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ) : Container(),
                    controller.slot4.isNotEmpty ?
                    Obx(
                          () => Container(
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
                                CustomTextField(
                                  fontWeight: FontWeight.w700,
                                  size: 17.sp,
                                  text: "Slot 4",
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5.h,),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: controller.slot4.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var days = 0;
                                      if(controller.slot4[index].isRange){
                                        days = DateTime.parse(controller.slot4[index].pillsDuration[1]).difference(DateTime.parse(controller.slot4[index].pillsDuration[0])).inDays+1;
                                      }else {
                                        days = controller.slot4[index].pillsDuration.length;
                                      }
                                      var prescription = '${controller.slot4[index].medicineCategory} ${controller.slot4[index].pillName} ${controller.slot4[index].dosage} ${controller.slot4[index].pillsInterval.length} ${controller.slot4[index].pillsInterval.length > 1 ? 'times' : 'time'} a day for $days days';
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h,),
                                          const Divider(
                                            color: Colors.black26,
                                            // thickness: 1,
                                            height: 2,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            alignment: Alignment.topLeft,
                                            child: CustomTextField(
                                              fontWeight: FontWeight.w600,
                                              size: 14.sp,
                                              text: prescription,
                                              color: Colors.black,
                                              // maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    )  : Container(),
                    controller.slot5.isNotEmpty ?
                    Obx(
                          () => Container(
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
                                CustomTextField(
                                  fontWeight: FontWeight.w700,
                                  size: 17.sp,
                                  text: "Slot 5",
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5.h,),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: controller.slot5.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var days = 0;
                                      if(controller.slot5[index].isRange){
                                        days = DateTime.parse(controller.slot5[index].pillsDuration[1]).difference(DateTime.parse(controller.slot5[index].pillsDuration[0])).inDays+1;
                                      }else {
                                        days = controller.slot5[index].pillsDuration.length;
                                      }
                                      var prescription = '${controller.slot5[index].medicineCategory} ${controller.slot5[index].pillName} ${controller.slot5[index].dosage} ${controller.slot5[index].pillsInterval.length} ${controller.slot5[index].pillsInterval.length > 1 ? 'times' : 'time'} a day for $days days';
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h,),
                                          const Divider(
                                            color: Colors.black26,
                                            // thickness: 1,
                                            height: 2,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            alignment: Alignment.topLeft,
                                            child: CustomTextField(
                                              fontWeight: FontWeight.w600,
                                              size: 14.sp,
                                              text: prescription,
                                              color: Colors.black,
                                              // maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ) : Container(),
                    controller.slot6.isNotEmpty ?
                    Obx(
                          () => Container(
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
                                CustomTextField(
                                  fontWeight: FontWeight.w700,
                                  size: 17.sp,
                                  text: "Slot 6 (SOS)",
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5.h,),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    itemCount: controller.slot6.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var days = 0;
                                      if(controller.slot6[index].isRange){
                                        days = DateTime.parse(controller.slot6[index].pillsDuration[1]).difference(DateTime.parse(controller.slot6[index].pillsDuration[0])).inDays+1;
                                      }else {
                                        days = controller.slot6[index].pillsDuration.length;
                                      }
                                      var prescription = '${controller.slot6[index].medicineCategory} ${controller.slot6[index].pillName} ${controller.slot6[index].dosage}';
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8.h,),
                                          const Divider(
                                            color: Colors.black26,
                                            // thickness: 1,
                                            height: 2,
                                          ),
                                          SizedBox(height: 8.h,),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                                            alignment: Alignment.topLeft,
                                            child: CustomTextField(
                                              fontWeight: FontWeight.w600,
                                              size: 14.sp,
                                              text: prescription,
                                              color: Colors.black,
                                              // maxLines: 4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ) : Container(),
                    SizedBox(height: 15.h),
                  ],
                ) : Column(
                  children: [
                    SizedBox(height: 15.h),
                    SizedBox(height: 5.h),
                    Obx(
                      () => Container(
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
                          children: [
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
                            MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                      itemCount: controller.reminders.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var days = 0;
                                        if(controller.reminders[index].isRange){
                                          days = DateTime.parse(controller.reminders[index].pillsDuration[1]).difference(DateTime.parse(controller.reminders[index].pillsDuration[0])).inDays+1;
                                        }else {
                                          days = controller.reminders[index].pillsDuration.length;
                                        }
                                        var prescription = '${controller.reminders[index].medicineCategory} ${controller.reminders[index].pillName} ${controller.reminders[index].dosage} ${controller.reminders[index].pillsInterval.length} ${controller.reminders[index].pillsInterval.length > 1 ? 'times' : 'time'} a day for $days days';
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10.h,),
                                            const Divider(
                                              color: Colors.black26,
                                              // thickness: 1,
                                              height: 2,
                                            ),
                                            SizedBox(height: 10.h,),
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                                              alignment: Alignment.topLeft,
                                              child: CustomTextField(
                                                fontWeight: FontWeight.w600,
                                                size: 14.sp,
                                                text: prescription,
                                                color: Colors.black,
                                                // maxLines: 4,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ),
                    SizedBox(height: 20.h,),
                  ],
                )
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
