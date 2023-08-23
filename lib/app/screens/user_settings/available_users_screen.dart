import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medibot/app/services/firestore.dart';
import 'package:medibot/app/services/user.dart';
import 'package:medibot/app/widgets/background_screen_decoration.dart';

import '../../models/user_model/user_model.dart';
import '../../routes/route_path.dart';
import '../../widgets/text_field.dart';

class AvailableUsrsPage extends StatefulWidget {
  const AvailableUsrsPage({Key? key}) : super(key: key);

  @override
  State<AvailableUsrsPage> createState() => _AvailableUsrsPageState();
}

class _AvailableUsrsPageState extends State<AvailableUsrsPage> {

  List<UserModel> users = [];
  var uid = UserStore.to.uid;
  var loading = false;

  @override
  void initState() {
    getAvailableUsers();
    super.initState();
  }

  getAvailableUsers() async {
    loading = true;
    UserStore.to.getCurrentUsers();
    if(UserStore.to.users.isNotEmpty){
      var data = await FirebaseFireStore.to.getAvailableUsers();
      log(data.docs.toString());
      for(var userData in data.docs){
        users.add(UserModel.fromJson(userData.data()));
      }
      log(users.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenDecoration(
      bottomButtonText: 'Add Profile',
      onbottomButtonPressed: () {
        Get.toNamed(RoutePaths.signInScreen);
      },
      body: !loading ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            text: "Available Users!",
            fontFamily: 'Sansation',
            size: 23.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          ListView.builder(
            itemCount: users.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () async {
                  if(UserStore.to.uid != users[index].uid){
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
                      builder: (context) =>WillPopScope(
                        onWillPop: () async => false,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                text: 'Entering to \n${users[index].username} Account',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                size: 16.sp,
                                maxLines: 2,
                              ),
                              SizedBox(height: 15.h,),
                              LinearProgressIndicator(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(30.r),
                                color: const Color(0xff041c50),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    setState(() {
                      uid = users[index].uid;
                    });
                    await UserStore.to.switchUser(users[index].uid);
                    Future.delayed(const Duration(seconds: 1), () {
                      Get.back();
                      Get.offAllNamed(RoutePaths.homeScreen);
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    border: Border.all(
                      color: uid == users[index].uid
                          ? const Color(0xff041c50)
                          : Colors.black12,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      SizedBox(
                        width: 20.w,
                      ),
                      CustomTextField(
                        text: users[index].username,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ) : Container(
        margin: EdgeInsets.symmetric(vertical: 50.h),
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
