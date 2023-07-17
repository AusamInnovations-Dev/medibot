import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/text_field.dart';
import 'getx_helper/contact_controller.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: CustomTextField(
          text: "Select your contacts",
          fontFamily: 'Sansation',
          size: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Obx(
          () => !controller.loadingContact.value
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 36.h,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Theme.of(context).colorScheme.primary
                            ),
                            child: TextFormField(
                              controller: controller.searchContact,
                              style: TextStyle(
                                fontFamily: 'Sansation',
                                fontSize: 17.sp,
                              ),
                              onChanged: (value){
                                controller.searchYourContact(value);
                              },
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                  fontFamily: 'Sansation',
                                ),
                                hintText: 'Search your contact',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.selectedContacts.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              onTap: () {
                                Get.back(result: {"contact": controller.selectedContacts[index].phones!.first.value});
                              },
                              title: CustomTextField(
                                text: controller.selectedContacts[index].displayName?? '',
                                fontFamily: 'Sansation',
                                size: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
