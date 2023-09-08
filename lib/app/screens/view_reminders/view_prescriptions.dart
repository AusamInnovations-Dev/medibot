import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/background_screen_decoration.dart';
import '../../widgets/box_field.dart';
import '../../widgets/custom_text_view.dart';
import '../../widgets/text_field.dart';
import 'package:medibot/app/screens/view_reminders/getx_helper/view_prescription_controller.dart';

class ViewPrescriptions extends GetView<ViewPrescriptionController> {
  const ViewPrescriptions({Key? key}) : super(key: key);

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
            text: "Existing Prescriptions",
            size: 18.sp,
            color: Colors.black,
          ),
          Obx(
            () => !controller.isLoading.value
                ? Column(
                    children: [
                      SizedBox(height: 5.h),
                      Obx(() => MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                itemCount: controller.prescriptions.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var remainingDays = 0;
                                  if (controller.prescriptions[index].isRange!) {remainingDays = DateTime.parse(controller.prescriptions[index].pillsDuration!.last).difference(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)).inDays + 1;
                                    if (remainingDays < 0) {
                                      remainingDays = 0;
                                    }
                                  } else {
                                    var difference = 0;
                                    for (var date in controller.prescriptions[index].pillsDuration!) {
                                      if (DateTime.parse(date).isAfter(DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day))) {
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
                                        controller.prescriptions[index].presImgUrl!.isNotEmpty
                                            ? Container()
                                            : Row(
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
                                                    constraints: BoxConstraints(maxWidth: 120.w, minWidth: 10.w),
                                                    child: CustomTextField(
                                                      fontWeight: FontWeight.w400,
                                                      size: 17.sp,
                                                      text: controller.prescriptions[index].medicineCategory ?? '',
                                                      color: Colors.black,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        controller.prescriptions[index].presImgUrl!.isNotEmpty ?
                                        Wrap(
                                          alignment: WrapAlignment.spaceEvenly,
                                          spacing: 15.w,
                                          runSpacing: 10.h,
                                          runAlignment: WrapAlignment.spaceBetween,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: List.generate(controller.prescriptions[index].presImgUrl!.length, (i) => GestureDetector(
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
                                                      child: Image.network(
                                                        controller.prescriptions[index].presImgUrl![i],
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
                                              width: controller.prescriptions[index].presImgUrl!.length == 1
                                                  ? MediaQuery.of(context).size.width
                                                  : controller.prescriptions[index].presImgUrl!.length % 3 == 1 && i == controller.prescriptions[index].presImgUrl!.length-1
                                                    ? MediaQuery.of(context).size.width
                                                    : controller.prescriptions[index].presImgUrl!.length % 3 == 2 && (i <= controller.prescriptions[index].presImgUrl!.length-1 && i >= controller.prescriptions[index].presImgUrl!.length-2)
                                                    ? 140.w
                                                    : 90.w,
                                              child: Image.network(
                                                controller.prescriptions[index].presImgUrl![i],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                        ) :
                                        Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomTextField(
                                                    fontWeight: FontWeight.w400,
                                                    size: 17.sp,
                                                    text: '${controller.prescriptions[index].medicineCategory} Name:',
                                                    color: Colors.black,
                                                    maxLines: 1,
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(maxWidth: 120.w, minWidth: 10.w),
                                                    child: CustomTextField(
                                                      fontWeight: FontWeight.w400,
                                                      size: 17.sp,
                                                      text: controller.prescriptions[index].pillName ?? '',
                                                      color: Colors.black,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        controller.prescriptions[index].presImgUrl!.isNotEmpty ?
                                        Container() :
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CustomTextField(
                                                  fontWeight: FontWeight.w400,
                                                  size: 17.sp,
                                                  text: 'Dosage:',
                                                  color: Colors.black,
                                                  maxLines: 1,
                                                ),
                                                Container(
                                                  constraints: BoxConstraints(maxWidth: 220.w, minWidth: 10.w),
                                                  child: CustomTextField(
                                                    fontWeight: FontWeight.w400,
                                                    size: 17.sp,
                                                    text: controller.prescriptions[index].dosage ?? '',
                                                    color: Colors.black,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 8.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextField(
                                                    fontWeight: FontWeight.w700,
                                                    text: 'Interval',
                                                    color: Colors.black,
                                                    size: 14.sp,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  CustomTextView(
                                                    boxHeight: 36.h,
                                                    boxWidth: 329.w,
                                                    Text: controller.prescriptions[index].interval!,
                                                    boxcolor: Theme.of(context).colorScheme.secondary,
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                CustomTextField(
                                                  fontWeight: FontWeight.w700,
                                                  text: "Duration: ",
                                                  color: Colors.black,
                                                  size: 15.sp,
                                                  textAlign: TextAlign.start,
                                                ),
                                                CustomTextField(
                                                  size: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                  text: controller
                                                      .prescriptions[index]
                                                      .isIndividual!
                                                      ? "Individual Date(s)"
                                                      : 'Range',
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 11.w, top: 5.h,),
                                              width: 360.w,
                                              child: MediaQuery.removePadding(
                                                context: context,
                                                removeTop: true,
                                                child: !controller.prescriptions[index].isRange! ?
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: controller.prescriptions[index].pillsDuration!.length,
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
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
                                                          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 7.w,),
                                                          child: CustomTextField(
                                                            fontWeight: FontWeight.w400,
                                                            text: '${DateTime.parse(controller.prescriptions[index].pillsDuration![index1]).day}/${DateTime.parse(controller.prescriptions[index].pillsDuration![index1]).month}/${DateTime.parse(controller.prescriptions[index].pillsDuration![index1]).year}',
                                                            color: Colors.black,
                                                            size: 12.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ) :
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextField(
                                                      fontWeight:
                                                      FontWeight.bold,
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
                                                          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 7.w,),
                                                          child: CustomTextField(
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            text: '${DateTime.parse(controller.prescriptions[index].pillsDuration![0]).day}/${DateTime.parse(controller.prescriptions[index].pillsDuration![0]).month}/${DateTime.parse(controller.prescriptions[index].pillsDuration![0]).year}',
                                                            color: Colors.black,
                                                            size: 12.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    CustomTextField(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      text: "To",
                                                      size: 12.sp,
                                                      color: Colors.black,
                                                      textAlign: TextAlign
                                                          .center,
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
                                                          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 7.w,),
                                                          child:
                                                          CustomTextField(
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            text: '${DateTime.parse(controller.prescriptions[index].pillsDuration![1]).day}/${DateTime.parse(controller.prescriptions[index].pillsDuration![1]).month}/${DateTime.parse(controller.prescriptions[index].pillsDuration![1]).year}',
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
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
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
        ],
      ),
    );
  }
}
