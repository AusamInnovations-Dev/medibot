import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../models/user_model/user_model.dart';
import '../../../routes/route_path.dart';
import '../../../services/user.dart';
import '../../../widgets/text_field.dart';

class Setup extends StatefulWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => (FirebaseAuth.instance.currentUser == null)
          ? Get.offAllNamed(RoutePaths.signInScreen)
          : UserStore.to.profile.userStatus == AuthStatus.newUser
              ? Get.offAllNamed(RoutePaths.userInformation)
              : Get.offAllNamed(RoutePaths.homeScreen),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/cylinder.svg",
                    height: 111.h,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 210.h,
              left: 85.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/img_1.png",
                    height: 170,
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  CustomTextField(
                    textAlign: TextAlign.center,
                    text: "Setup Complete!",
                    fontFamily: 'Sansation',
                    size: 27.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  CustomTextField(
                    textAlign: TextAlign.center,
                    text: "Enjoy using MediBot!",
                    fontFamily: 'Sansation',
                    size: 18.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/images/circlular.svg",
                    height: 150.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
