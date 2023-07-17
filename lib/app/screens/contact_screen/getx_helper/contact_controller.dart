import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactController extends GetxController {

  List<Contact> contacts = [];
  RxList<Contact> selectedContacts = <Contact>[].obs;
  var loadingContact = true.obs;

  TextEditingController searchContact = TextEditingController();

  @override
  void onInit() async {
    await askPermissions();
    super.onInit();
  }

  Future<void> askPermissions() async {
    loadingContact.value = true;
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      ContactsService.getContacts().then((value) {
        for(var contact in value){
          if(contact.phones != null){
            contacts.add(contact);
          }
        }
        selectedContacts.value = contacts;
        loadingContact.value = false;
      });
    } else {
      _handleInvalidPermissions(permissionStatus);
      loadingContact.value = false;
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      Get.snackbar(
        "Contacts",
        "Access Denied to read contacts",
        icon: const Icon(
          Icons.person,
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
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Get.snackbar(
        "Contacts",
        "Can't access your device contacts",
        icon: const Icon(
          Icons.person,
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
    }
  }

  void searchYourContact(value) {
    loadingContact.value = true;
    selectedContacts.value = [];
    if(value.isEmpty){
      selectedContacts.value = contacts;
    }else{
      selectedContacts.addAll(contacts.where((element) => element.displayName!.trim().startsWith(value)));
    }
    loadingContact.value = false;
  }
}