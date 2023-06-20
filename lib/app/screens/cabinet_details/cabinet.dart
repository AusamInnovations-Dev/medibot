import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/box_field.dart';

import '../../routes/route_path.dart';
import '../../widgets/text_field.dart';
import 'getx_helper/cabinet_controller.dart';

class CabinetDetail extends GetView<CabinetController> {
  const CabinetDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                text: "Cabinet Management",
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
                ? MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeLeft: true,
                    removeRight: true,
                    child: ListView.builder(
                      itemCount: controller.cabinetPillsList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          controller.itemSelected = index;
                          Get.toNamed(RoutePaths.viewslot);
                        },
                        child: CustomBox(
                          margin: EdgeInsets.only(
                            top: 20.h,
                            right: 22.w,
                            left: 8.w,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          topLeft: Radius.circular(17.r),
                          bottomRight: Radius.circular(17.r),
                          boxHeight: 230.h,
                          boxWidth: 230.w,
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextField(
                                    fontWeight: FontWeight.w700,
                                    size: 17.sp,
                                    text:
                                        "Slot ${controller.cabinetPillsList[index].slot}",
                                    color: Colors.black,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(RoutePaths.cabinetmanagement);
                                    },
                                    child: CustomTextField(
                                      fontWeight: FontWeight.bold,
                                      text: "Edit",
                                      size: 12.sp,
                                      color: Colors.black,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              CustomTextField(
                                fontWeight: FontWeight.w400,
                                size: 17.sp,
                                text:
                                    controller.cabinetPillsList[index].pillName,
                                color: Colors.black,
                                maxLines: 1,
                              ),
                              CustomTextField(
                                fontWeight: FontWeight.w400,
                                size: 17.sp,
                                text: "Interval",
                                color: Colors.black,
                              ),
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
                                    const TextSpan(text: 'Remaining Pills '),
                                    TextSpan(
                                      text:
                                          '    ${controller.cabinetPillsList[index].pillsQuantity}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Sansation',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                    const TextSpan(text: 'Remaining Days '),
                                    TextSpan(
                                      text:
                                          '   ${controller.remainingDay[index]}',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Sansation',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                Get.toNamed(RoutePaths.addpillcabinet);
              },
              child: CustomTextField(
                fontWeight: FontWeight.bold,
                text: "Add Pills to Cabinet",
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
