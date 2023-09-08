import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/route_path.dart';
import '../../widgets/background_screen_decoration.dart';
import '../../widgets/text_field.dart';

class ViewOptions extends StatelessWidget {
  const ViewOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Prescription Modes!",
            fontFamily: 'Sansation',
            size: 23.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          SizedBox(height: 40.h,),
          GestureDetector(
            onTap: () async {
              Get.toNamed(RoutePaths.viewPrescriptions);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                  color: const Color(0xff041c50)
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.medical_information),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomTextField(
                    text: 'View Prescriptions',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    size: 15.sp,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.toNamed(RoutePaths.addPrescriptions);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                    color: const Color(0xff041c50)
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomTextField(
                    text: 'Add Prescriptions',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    size: 15.sp,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
