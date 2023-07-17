import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetService {

  Future<bool> checkInternetSourceStatus() async {
    try{
      var connection = await Connectivity().checkConnectivity();
      if(connection == ConnectivityResult.none){
        Get.snackbar(
          "Medibot",
          "No internet connection!",
          icon: const Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4_outlined,
            color: Colors.black,
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xffA9CBFF),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          colorText: Colors.black,
        );
        return false;
      }else{
        return true;
      }
    }catch(err){
      return false;
    }
  }

  Future<bool> checkInternetStatus() async {
    Connectivity().onConnectivityChanged.listen((event) async {
      try{
        await InternetConnectionChecker().hasConnection.then((value) {
          return value;
        });
      }catch(err){
        log('Internet status: $err');
      }
    });
    return false;
  }
}