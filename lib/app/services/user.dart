import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../models/user_model/user_model.dart';
import '../routes/route_path.dart';
import 'firestore.dart';
import 'storage.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;
  RxList<Map<String, dynamic>> skipPills = <Map<String, dynamic>>[].obs;
  String uid = '';
  String userIdKey = 'userIdKey';
  String userNameKey = 'userNameKey';
  String skipPillsKey = 'skipPillsKey';
  String userProfilePicKey = 'userProfilePicKey';
  String userEmailKey = 'userEmailKey';
  final _profile = const UserModel(
    uid: '',
    userProfile: '',
    email: '',
    phoneNumber: '',
    username: '',
    address: '',
    age: 0,
    cabinetDetail: '',
    emergencyPerson: EmergencyPersonModel(
      emergencyAddress: '',
      emergencyName: '',
      emergencyPhone: '',
      emergencyRelation: '',
    ),
    careTaker: CareTakerModel(
      careTakerAddress: '',
      careTakerName: '',
      caretakerPhone: '',
      uid: '',
    ),
    userStatus: AuthStatus.newUser,
    physicalDeviceLink: '',
  ).obs;

  bool get isLogin => _isLogin.value;
  UserModel get profile => _profile.value;
  bool get hasToken => uid.isNotEmpty;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getProfile();
    getSkipPills();
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString(userIdKey, value);
    uid = value;
  }

  void getSkipPills() {
    var skipPillData =  StorageService.to.getList(skipPillsKey);
    skipPills.addAll(skipPillData.map((e) => jsonDecode(e) as Map<String, dynamic>).toList());
  }

  Future<void> setSkipPills(Map<String, dynamic> pill) async {
    String newSkip = jsonEncode(pill);
    List<String> skipInString = skipPills.map((e) => jsonEncode(e)).toList();
    skipInString.add(newSkip);
    await StorageService.to.setList(skipPillsKey, skipInString);
    getSkipPills();
  }

  Future<void> getProfile() async {
    uid = StorageService.to.getString(userIdKey);
    try {
      if (uid.isNotEmpty) {
        _profile(await FirebaseFireStore.to.getUser(uid));
      }
      log('user data: $_profile');
      _isLogin.value = true;
      if(Get.currentRoute != RoutePaths.splashScreen && profile.userStatus == AuthStatus.newUser ){
        Get.offAllNamed(RoutePaths.userInformation);
      }
    } catch (err) {
      log(err.toString());
      _isLogin.value = false;
    }
  }

  Future<void> saveProfile(String profile) async {
    await StorageService.to.setString(userIdKey, profile);
    await getProfile();
    uid = profile;
    log("data is saved: ${_profile.value}");
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(userEmailKey);
    await StorageService.to.remove(userIdKey);
    await StorageService.to.remove(userProfilePicKey);
    await StorageService.to.remove(userNameKey);
    _isLogin.value = false;
    uid = '';
    Get.offAllNamed(RoutePaths.signInScreen);
  }
}
