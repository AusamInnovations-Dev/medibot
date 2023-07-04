import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/routes/route_path.dart';
import 'package:medibot/app/screens/history/getx_helper/history_controller.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/widgets/custom_input_button.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/box_field.dart';
import '../../widgets/text_field.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Obx(
        () => !controller.loadingUserData.value
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      text: "History",
                      fontFamily: 'Sansation',
                      size: 23.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      child: TableCalendar(
                        firstDay: DateTime(DateTime.now().year, DateTime.now().month-1),
                        lastDay: DateTime(DateTime.now().year, DateTime.now().month+1),
                        headerVisible: true,
                        currentDay: DateTime.now(),
                        focusedDay: DateTime.now(),
                        shouldFillViewport: false,
                        calendarFormat: CalendarFormat.month,
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, date, date1) {
                            var state = controller.checkForSuccess(date);
                            return GestureDetector(
                              onTap: (){
                                if(state != 'NoPillsScheduled' && !date.isAfter(DateTime.now())) {
                                  Get.toNamed(
                                      RoutePaths.historyDetailsPage,
                                      arguments: {
                                        'date': date,
                                        'todayReminders': controller.todayReminders(date),
                                      }
                                  );
                                }
                              },
                              child: Container(
                                height: 35.h,
                                width: 40.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: date.isAfter(DateTime.now())
                                      ? Theme.of(context).colorScheme.primary
                                      : state == 'NoPillsScheduled'
                                      ? Colors.grey[200]
                                      : state == 'AllPillsTaken'
                                      ? Colors.lightGreenAccent
                                      : state == 'NoPillsTaken'
                                      ? Colors.red
                                      : Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  date.day.toString(),
                                ),
                              ),
                            );
                          },
                          todayBuilder: (context, date, date1) {
                            return Container(
                              height: 35.h,
                              width: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(date.day.toString()),
                            );
                          },
                          outsideBuilder: (context, date, date1) {
                            var state = controller.checkForSuccess(date);
                            return GestureDetector(
                              onTap: (){
                                if(state != 'NoPillsScheduled' && !date.isAfter(DateTime.now())) {
                                  Get.toNamed(
                                      RoutePaths.historyDetailsPage,
                                      arguments: {
                                        'date': date,
                                        'todayReminders': controller.todayReminders(date),
                                      }
                                  );
                                }
                              },
                              child: Container(
                                height: 35.h,
                                width: 40.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: date.isAfter(DateTime.now())
                                      ? Theme.of(context).colorScheme.primary
                                      : state == 'NoPillsScheduled'
                                      ? Colors.grey[200]
                                      : state == 'AllPillsTaken'
                                      ? Colors.lightGreenAccent
                                      : state == 'NoPillsTaken'
                                      ? Colors.red
                                      : Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  date.day.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    CustomBox(
                      boxHeight: 90.h,
                      boxWidth: 320.w,
                      bottomRight: Radius.circular(15.r),
                      topLeft: Radius.circular(15.r),
                      margin: EdgeInsets.only(top: 30.h),
                      body: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextField(
                                    fontWeight: FontWeight.bold,
                                    text: 'Missed Dosage',
                                    color: Colors.black,
                                    size: 18.sp,
                                  ),
                                  CustomTextField(
                                    fontWeight: FontWeight.bold,
                                    text: '${controller.totalPillsDosage.value - controller.totalTakenPillsDosage.value}',
                                    color: Colors.red,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  fontWeight: FontWeight.bold,
                                  text: 'Upcoming Doses',
                                  color: Colors.black,
                                  size: 18.sp,
                                ),
                                Obx(
                                  () => CustomTextField(
                                    fontWeight: FontWeight.bold,
                                    text: '${controller.upComingDosage.value}',
                                    color: Colors.red,
                                    size: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 0),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 15.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          child: CustomTextField(
                            fontWeight: FontWeight.bold,
                            text: "Export as PDF",
                            color: Colors.black,
                            size: 13.sp,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 0),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 15.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          child: CustomTextField(
                            fontWeight: FontWeight.bold,
                            text: "Export to another application",
                            color: Colors.black,
                            size: 13.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(vertical: 50.h),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
      ),
    );
  }
}
