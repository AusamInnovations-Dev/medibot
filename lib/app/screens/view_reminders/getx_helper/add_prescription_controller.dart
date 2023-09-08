import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medibot/app/models/prescription_model/prescription_model.dart';
import 'package:medibot/app/services/firestore.dart';

import '../../../services/user.dart';
import '../../../widgets/text_field.dart';

class AddPrescriptionController extends GetxController {


  PrescriptionModel prescription = PrescriptionModel();
  TextEditingController pillName = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  String dosage = 'Select Dosage';
  Rx<String> medicineCategory = 'Select Category'.obs;
  Rx<String> interval = 'Once a Day (24 Hours)'.obs;
  Rx<bool> isRange = false.obs;
  Rx<bool> isIndividual = false.obs;
  Rx<bool> uploading = false.obs;
  List<XFile>? pickedImage;
  RxList<String> imageUrl = <String>[].obs;
  RxList<DateTime> durationDates = <DateTime>[].obs;

  addPrescription() async {
    try{
      uploading.value = true;
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
        builder: (context) => WillPopScope(
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
                SizedBox(
                  width: 180.w,
                  child: CustomTextField(
                    text: "Wait while we are uploading your prescription...",
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
              ],
            ),
          ),
        ),
      );
      if (pickedImage != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        for (var i = 0; i < imageUrl.length; i++) {
          Reference reference =
              storage.ref("${UserStore.to.uid}/prescription$i.jpg");
          final TaskSnapshot snapshot =
              await reference.putFile(File(imageUrl[i]));
          imageUrl[i] = await snapshot.ref.getDownloadURL();
        }
        await FirebaseFireStore.to.addPrescription(PrescriptionModel(
          userId: UserStore.to.uid,
          interval: '',
          pillsDuration: [],
          pillName: '',
          isRange: false,
          isIndividual: false,
          dosage: '',
          uid: '',
          medicineCategory: '',
          presImgUrl: imageUrl,
        ));
        Get.back();
        uploading.value = false;
        return 'true';
      } else if (pillName.text.isNotEmpty &&
          dosageController.text.isNotEmpty &&
          medicineCategory.value != 'Select Category' &&
          dosage != 'Select Dosage') {
        await FirebaseFireStore.to.addPrescription(PrescriptionModel(
          userId: UserStore.to.uid,
          interval: interval.value,
          pillsDuration: durationDates
              .map((element) => element.toIso8601String())
              .toList(),
          pillName: pillName.text,
          isRange: isRange.value,
          isIndividual: isIndividual.value,
          dosage: '${dosageController.text} $dosage',
          uid: '',
          medicineCategory: medicineCategory.value,
          presImgUrl: [],
        ));
        Get.back();
        uploading.value = false;
        return 'true';
      } else {
        Get.snackbar(
          "MediBot",
          "Please provide necessary information for adding prescription",
          icon: const Icon(
            Icons.crisis_alert_outlined,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
        Get.back();
        uploading.value = false;
        return '';
      }
    }catch(err){
      Get.back();
      Get.snackbar(
        "MediBot",
        "$err",
        icon: const Icon(
          Icons.crisis_alert_outlined,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
      uploading.value = false;
      return "";
    }
  }

  upload() async {
    try {
      pickedImage = (await ImagePicker().pickMultiImage());
      imageUrl.value = pickedImage!.map((e) => e.path).toList();
    } catch (err) {
      log(err.toString());
    }
  }
}