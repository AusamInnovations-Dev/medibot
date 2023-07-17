import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/screens/user_settings/get_helper/user_setting_controller.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';
import 'package:medibot/app/routes/route_path.dart';
import '../../widgets/text_field.dart';

class UserSetting extends GetView<UserSettingController> {
  const UserSetting({Key? key}) : super(key: key);

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
                text: "User Settings",
                fontFamily: 'Sansation',
                size: 23.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 110.h, left: 7.w, bottom: 10.h),
            width: 320.w,
            height: 250.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutePaths.editUserInformation);
                    // controller.handleSigning();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 0),
                    backgroundColor: Color(0xffE1EDFF),
                    padding: EdgeInsets.symmetric(
                      vertical: 13.h,
                      // horizontal: 100.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: CustomTextField(
                    text: "Edit User Profile",
                    fontFamily: 'Sansation',
                    size: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutePaths.editCaretakerInformation);
                    // controller.handleSigning();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 0),
                    backgroundColor: Color(0xffE1EDFF),
                    padding: EdgeInsets.symmetric(
                      vertical: 13.h,
                      // horizontal: 100.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: CustomTextField(
                    text: "Change CareTaker Info",
                    fontFamily: 'Sansation',
                    size: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutePaths.editEmergencyInformation);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 0),
                    backgroundColor: Color(0xffE1EDFF),
                    padding: EdgeInsets.symmetric(
                      vertical: 13.h,
                      // horizontal: 100.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: CustomTextField(
                    text: "Change Emergency Info",
                    fontFamily: 'Sansation',
                    size: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // controller.handleSigning();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 0),
                    backgroundColor: Color(0xffE1EDFF),
                    padding: EdgeInsets.symmetric(
                      vertical: 13.h,
                      // horizontal: 100.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                  child: CustomTextField(
                    text: "Change PIN",
                    fontFamily: 'Sansation',
                    size: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
