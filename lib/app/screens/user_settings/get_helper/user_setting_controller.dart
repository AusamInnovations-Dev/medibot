
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medibot/app/services/firestore.dart';

import '../../../models/user_model/user_model.dart';
import '../../../services/user.dart';

class UserSettingController extends GetxController {

  var fetchingLocation = false.obs;
  var haveCaretaker = false.obs;
  TextEditingController nameController = TextEditingController(text: UserStore.to.profile.username);
  TextEditingController ageController = TextEditingController(text: UserStore.to.profile.age.toString());
  TextEditingController caretakernameController = TextEditingController(text: UserStore.to.profile.careTaker.careTakerName);
  TextEditingController caretakerphoneController = TextEditingController(text: UserStore.to.profile.careTaker.caretakerPhone);
  TextEditingController caretakerlocationController = TextEditingController(text: UserStore.to.profile.careTaker.careTakerAddress);
  TextEditingController emergencynameController = TextEditingController(text: UserStore.to.profile.emergencyPerson.emergencyName);
  TextEditingController emergencylocationController = TextEditingController(text: UserStore.to.profile.emergencyPerson.emergencyAddress);
  TextEditingController emergencycontactController = TextEditingController(text: UserStore.to.profile.emergencyPerson.emergencyPhone);
  TextEditingController emergencyrelationController = TextEditingController(text: UserStore.to.profile.emergencyPerson.emergencyRelation);
  TextEditingController addressController = TextEditingController(text: UserStore.to.profile.address);

  Future<void> updateProfile() async {
    await FirebaseFireStore.to.updateUserData(
      UserStore.to.profile.copyWith(
        age: int.parse(ageController.text),
        address: addressController.text,
        username: nameController.text,
        careTaker: UserStore.to.profile.careTaker,
      )
    );
    Get.back();
  }

  updateEmergencyContact() async {
    await FirebaseFireStore.to.updateUserData(
        UserStore.to.profile.copyWith(
          emergencyPerson: EmergencyPersonModel(
            emergencyName: emergencynameController.text,
            emergencyAddress: emergencylocationController.text,
            emergencyPhone: emergencycontactController.text,
            emergencyRelation: emergencyrelationController.text,
          ),
        )
    );
    Get.back();
  }

  updateCareTaker() async {
    await FirebaseFireStore.to.updateUserData(
        UserStore.to.profile.copyWith(
          careTaker: UserStore.to.profile.careTaker.copyWith(
            careTakerName: caretakernameController.text,
            caretakerPhone: caretakerphoneController.text,
            careTakerAddress: caretakerlocationController.text,
          ),
        )
    );
    Get.back();
  }

  Future<String> getCurrentLocation() async {
    bool isServiceEnabled = false;
    fetchingLocation.value = true;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('error');
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
      return Future.error('Permission Denied forever');
    }
    var pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    fetchingLocation.value = false;
    return await _getAddressFromLatLng(pos);
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    final placeMark =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMark[0];
    log('This is the current location: ${place.name}, ${place.country}');
    return '${place.subLocality} ${place.subAdministrativeArea!}, ${place.postalCode}';
  }


}