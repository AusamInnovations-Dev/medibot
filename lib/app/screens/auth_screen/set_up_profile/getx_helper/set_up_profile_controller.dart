import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../models/user_model/user_model.dart';
import '../../../../routes/route_path.dart';
import '../../../../services/firestore.dart';
import '../../../../services/user.dart';

class SetUpProfileController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController caretakernameController = TextEditingController();
  TextEditingController caretakerphoneController = TextEditingController();
  TextEditingController caretakerlocationController = TextEditingController();

  TextEditingController emergencynameController = TextEditingController();
  TextEditingController emergencylocationController = TextEditingController();
  TextEditingController emergencycontactController = TextEditingController();
  TextEditingController emergencyrelationController = TextEditingController();

  TextEditingController qrscancodeController = TextEditingController();

  TextEditingController newreminderController = TextEditingController();

  var haveCaretaker = false.obs;
  var fetchingLocation = false.obs;
  var resendingOtp = false.obs;
  var uploadingData = false.obs;
  var verifyingOtp = false.obs;

  handleSignInByPhone() async {
    if (phoneController.text.length == 10) {
      try{
        resendingOtp.value = true;
        await FirebaseFireStore.to.handleSignInByPhone(phoneController.text);
        Get.snackbar(
          "Auth",
          "OTP Sent successfully",
          icon: const Icon(
            Icons.check_sharp,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
        Future.delayed(const Duration(seconds: 60), () => resendingOtp.value = false);
      }catch(err){
        Get.snackbar(
          "Auth",
          '$err',
          icon: const Icon(
            Icons.crisis_alert,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
        Future.delayed(const Duration(seconds: 30), () => resendingOtp.value = false);
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

  otpVerification() async {
    verifyingOtp.value = true;
    try{
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
        } else {
          if (UserStore.to.profile.userStatus != AuthStatus.newUser) {
            Get.offAllNamed(RoutePaths.homeScreen);
          } else {
            Get.offAllNamed(RoutePaths.userInformation);
          }
        }
      }
      verifyingOtp.value = false;
    }catch(err){
      verifyingOtp.value = false;
    }
  }

  bool validate(String phoneNumber) {
    if (phoneNumber.length == 10 && int.tryParse(phoneNumber) != null) {
      return true;
    } else {
      return false;
    }
  }

  resendOtp() async {
    try{
      resendingOtp.value = true;
      await FirebaseFireStore.to.handleSignInByPhone(phoneController.text);
      Get.snackbar(
        "Auth",
        "OTP Sent successfully",
        icon: const Icon(
          Icons.check_sharp,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
      Future.delayed(const Duration(seconds: 60), () => resendingOtp.value = false);
    }catch(err){
      Get.snackbar(
        "Auth",
        '$err',
        icon: const Icon(
          Icons.crisis_alert,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        colorText: Colors.black,
      );
      Future.delayed(const Duration(seconds: 30), () => resendingOtp.value = false);
    }
  }

  Future<bool> checkUserAccountByPhone() async {
    return await FirebaseFireStore.to.checkUserAccountByPhone(phoneController.text);
  }

  Future<bool> checkUserAccountByMail() async {
    return await FirebaseFireStore.to.checkUserAccountByPhone(emailController.text);
  }

  Future<String> getCurrentLocation() async {
    try{
      bool isServiceEnabled = false;
      fetchingLocation.value = true;
      LocationPermission permission;

      isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        Get.snackbar(
          "Location",
          "Please make sure that you have turned on location in your device",
          icon: const Icon(
            Icons.location_pin,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          colorText: Colors.black,
        );
        fetchingLocation.value = false;
        return '';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Permission Denied');
          permission = await Geolocator.requestPermission();
        }
      }
      if (permission == LocationPermission.deniedForever) {
        fetchingLocation.value = false;
        return Future.error('Permission Denied forever');
      }
      var pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      fetchingLocation.value = false;
      return await _getAddressFromLatLng(pos);
    }catch(err){
      Get.snackbar(
        "Location",
        err.toString(),
        icon: const Icon(
          Icons.location_pin,
          color: Colors.black,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xffA9CBFF),
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        colorText: Colors.black,
      );
      fetchingLocation.value = false;
      return '';
    }
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    final placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMark[0];
    log('This is the current location: ${place.name}, ${place.country}');
    return '${place.subLocality} ${place.subAdministrativeArea!}, ${place.postalCode}';
  }

  updateUserData() async {
    uploadingData.value = true;
    if (haveCaretaker.value) {
      await FirebaseFireStore.to.updateUserData(
        UserStore.to.profile.copyWith(
          age: int.parse(ageController.text),
          address: locationController.text,
          emergencyPerson: EmergencyPersonModel(
            emergencyName: emergencynameController.text,
            emergencyAddress: emergencylocationController.text,
            emergencyPhone: emergencycontactController.text,
            emergencyRelation: emergencyrelationController.text,
          ),
          careTaker: CareTakerModel(
            uid: '',
            careTakerName: caretakernameController.text,
            caretakerPhone: caretakerphoneController.text,
            careTakerAddress: caretakerlocationController.text,
          ),
          physicalDeviceLink: '',
          email: emailController.text,
          username: nameController.text,
          userProfile: '',
          userStatus: AuthStatus.existingUser,
        ),
      );
    } else {
      log(UserStore.to.profile.toString());
      await FirebaseFireStore.to.updateUserData(
        UserModel(
          uid: UserStore.to.uid,
          age: int.parse(ageController.text),
          address: locationController.text,
          emergencyPerson: EmergencyPersonModel(
            emergencyName: emergencynameController.text,
            emergencyAddress: emergencylocationController.text,
            emergencyPhone: emergencycontactController.text,
            emergencyRelation: emergencyrelationController.text,
          ),
          cabinetDetail: 'djmmI5mwGsNzprQFbu49',
          phoneNumber: UserStore.to.profile.phoneNumber,
          careTaker: const CareTakerModel(
            careTakerAddress: '',
            careTakerName: '',
            caretakerPhone: '',
            uid: '',
          ),
          physicalDeviceLink: '',
          email: emailController.text,
          username: nameController.text,
          userProfile: '',
          userStatus: AuthStatus.existingUser,
        ),
      );
    }
    uploadingData.value = false;
  }

  Future<void> handleSignInByEmail() async {
    if(await FirebaseFireStore.to.handleSignInByEmail(emailController.text, passwordController.text)){
      if (UserStore.to.profile.userStatus != AuthStatus.newUser) {
        Get.offAllNamed(RoutePaths.homeScreen);
      } else {
        Get.offAllNamed(RoutePaths.userInformation);
      }
    }else{
      Get.snackbar(
        "Auth Error",
        "Please check your email and password and try again",
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

  Future<void> handleSignUpByEmail() async {
    if(await FirebaseFireStore.to.handleSignUpByEmail(emailController.text, passwordController.text)){
      Get.offAllNamed(RoutePaths.userInformation);
    }else {
      Get.snackbar(
        "Auth Error",
        "Please check your email and password and try again",
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
}