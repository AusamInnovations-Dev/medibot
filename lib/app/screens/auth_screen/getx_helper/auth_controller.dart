import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/firestore.dart';

class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  var haveCaretaker = false.obs;
  var fetchingLocation = false.obs;


  handleSignInByPhone() async {
    if (phoneController.text.length == 10) {
      await FirebaseFireStore.to.handleSignInByPhone(phoneController.text);
    } else {
      Get.snackbar(
        "Auth Error",
        "Please check the credential entered and try again",
        icon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
    }
  }

  otpVerification() async {
    if (phoneController.text.length == 10) {
      if (!await FirebaseFireStore.to.verifyOtp(phoneController.text, otpController.text)) {
        Get.snackbar(
          "Auth Error",
          "Please check your otp and try again",
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
      }
    } else {
      Get.snackbar(
        "Auth Error",
        "Please check the credential entered and try again",
        icon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
    }
  }

  bool validate(String phoneNumber) {
    if (phoneNumber.length == 10 && int.tryParse(phoneNumber) != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkUserAccount() async {
    return await FirebaseFireStore.to.checkUserAccount(phoneController.text);
  }

  Future<void> getCurrentLocation() async {
    bool isServiceEnabled = false;
    fetchingLocation.value = true;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnabled){
      return Future.error('error');
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        log('Permission Denied');
        permission = await Geolocator.requestPermission();
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error('Permission Denied forever');
    }
    var pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(pos);
    fetchingLocation.value = false;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        position.latitude, position.longitude)
        .then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      locationController.text= '${place.subLocality} ${place.subAdministrativeArea!}, ${place.postalCode}';
      log('This is the current location: ${place.name}, ${place.country}');
    });
  }
}
