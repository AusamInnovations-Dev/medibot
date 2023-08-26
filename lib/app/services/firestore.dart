import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medibot/app/models/pills_models/pills_model.dart';

import '../models/history_model/history_model.dart';
import '../models/user_model/user_model.dart';
import 'user.dart';

class FirebaseFireStore extends GetxController {
  static FirebaseFireStore get to => Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String verificationId = '';
  int? resendToken;

  handleSignInByPhone(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        this.verificationId = verificationId;
        resendToken = forceResendingToken;
      },
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        smsCode: otp,
        verificationId: verificationId,
      );
      final value = await auth.signInWithCredential(credential);
      if (value.user != null) {
        UserModel? user = await getUser(value.user!.uid);
        if (user == null) {
          user = UserModel(
            username: '',
            uid: value.user!.uid,
            userProfile: '',
            phoneNumber: phoneNumber,
            email: '',
            address: '',
            medibotDetail: 'djmmI5mwGsNzprQFbu49',
            age: 0,
            careTaker: const CareTakerModel(
              careTakerAddress: '',
              careTakerName: '',
              caretakerPhone: '',
              uid: '',
            ),
            emergencyPerson: const EmergencyPersonModel(
              emergencyAddress: '',
              emergencyName: '',
              emergencyPhone: '',
              emergencyRelation: '',
            ),
            physicalDeviceLink: '',
            userStatus: AuthStatus.newUser,
          );
          await addUserData(user);
        }
        await UserStore.to.saveProfile(user.uid);
        await UserStore.to.addUsers(user.uid);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<void> addUserData(UserModel user) async {
    await fireStore.collection('Users').doc(user.uid).set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    var userData = await fireStore.collection('Users').doc(userId).get();
    return userData.exists
        ? UserModel.fromJson(userData.data() as Map<String, dynamic>)
        : null;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAvailableUsers() async {
    return await fireStore
        .collection('Users')
        .where('uid', whereIn: UserStore.to.users)
        .get();
  }

  Future<void> updateUserData(UserModel userModel) async {
    await fireStore
        .collection('Users')
        .doc(userModel.uid)
        .set(userModel.toJson());
    await UserStore.to.saveProfile(userModel.uid);
  }

  Future<UserModel?> getUserByPhone(String phoneNumber) async {
    final doc = await fireStore
        .collection("Users")
        .where('phoneNumber', isEqualTo: phoneNumber.trim())
        .get();
    if (doc.docs.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(doc.docs.first.data());
      return userModel;
    } else {
      return null;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final doc = await fireStore
        .collection("Users")
        .where('email', isEqualTo: email.trim())
        .get();
    if (doc.docs.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(doc.docs.first.data());
      return userModel;
    } else {
      return null;
    }
  }

  Future<bool> checkUserAccountByPhone(String phoneNumber) async {
    if (phoneNumber.isNotEmpty) {
      UserModel? userModel = await getUserByPhone(phoneNumber);
      if (userModel != null) {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkUserAccountByMail(String email) async {
    if (email.isNotEmpty) {
      UserModel? userModel = await getUserByEmail(email);
      if (userModel != null) {
        return true;
      }
    }
    return false;
  }

  Future<String> uploadPillsReminderData(PillsModel pillsModel) async {
    var docId = fireStore.collection('pillsReminder').doc().id;
    try {
      await fireStore
          .collection('pillsReminder')
          .doc(docId)
          .set(pillsModel.copyWith(uid: docId).toJson());
      return docId;
    } catch (err) {
      log(err.toString());
      return '';
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMedibotDetail() {
    return fireStore
        .collection('medibot')
        .doc(UserStore.to.profile.medibotDetail)
        .collection('pillsReminder')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMedibotPills() {
    return fireStore
        .collection('medibot')
        .doc(UserStore.to.profile.medibotDetail)
        .collection('pillsReminder')
        .snapshots();
  }

  Future<bool> uploadMedibotPills(PillsModel pillsModel) async {
    var docId = fireStore.collection('medibot').doc().id;
    try {
      await fireStore
          .collection('medibot')
          .doc(UserStore.to.profile.medibotDetail)
          .collection('pillsReminder')
          .doc(docId)
          .set(pillsModel.copyWith(uid: docId).toJson());
      return true;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<void> updatePillsData(PillsModel pillsModel) async {
    await fireStore
        .collection('pillsReminder')
        .doc(pillsModel.uid)
        .update(pillsModel.toJson());
  }

  Future<void> updateMedibotData(PillsModel pillsModel) async {
    await fireStore
        .collection('medibot')
        .doc(UserStore.to.profile.medibotDetail)
        .collection('pillsReminder')
        .doc(pillsModel.uid)
        .update(pillsModel.toJson());
  }

  Future<void> uploadHistoryData(
      HistoryModel historyModel, String docId) async {
    await fireStore
        .collection('History')
        .doc(UserStore.to.uid)
        .collection('history_data')
        .doc(docId)
        .set(historyModel.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> getHistoryData() async {
    var data = await fireStore
        .collection('History')
        .doc(UserStore.to.uid)
        .collection('history_data')
        .get();
    if (data.docs.isNotEmpty) {
      return data;
    } else {
      return null;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getTodayHistory() async {
    var history = await fireStore
        .collection('History')
        .doc(UserStore.to.uid)
        .collection('history_data')
        .doc(
            '${DateTime.now().year}:${DateTime.now().month < 10 ? '0${DateTime.now().month}' : DateTime.now().month}:${DateTime.now().day < 10 ? '0${DateTime.now().day}' : DateTime.now().day}')
        .get();
    log('Getting data : ${history.data()} at : ${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}');
    if (history.exists) {
      return history;
    } else {
      log('Its null');
      return null;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getHistoryDataByDay(
      String docId) async {
    var data = await fireStore
        .collection('History')
        .doc(UserStore.to.uid)
        .collection('history_data')
        .doc(docId)
        .get();
    if (data.exists) {
      return data;
    } else {
      return null;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPillReminder(
      String pillId) async {
    return await fireStore
        .collection('pillsReminder')
        .where('uid', isEqualTo: pillId)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPillsReminder() {
    return fireStore
        .collection('pillsReminder')
        .where('userId', isEqualTo: UserStore.to.uid)
        .snapshots();
  }

  Future<bool> handleSignInByEmail(String email, String password) async {
    try {
      var value = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (value.user != null) {
        UserModel? user = await getUser(value.user!.uid);
        if (user == null) {
          user = UserModel(
            username: '',
            uid: value.user!.uid,
            userProfile: '',
            phoneNumber: '',
            email: email,
            address: '',
            medibotDetail: 'djmmI5mwGsNzprQFbu49',
            age: 0,
            careTaker: const CareTakerModel(
              careTakerAddress: '',
              careTakerName: '',
              caretakerPhone: '',
              uid: '',
            ),
            emergencyPerson: const EmergencyPersonModel(
              emergencyAddress: '',
              emergencyName: '',
              emergencyPhone: '',
              emergencyRelation: '',
            ),
            physicalDeviceLink: '',
            userStatus: AuthStatus.newUser,
          );
          await addUserData(user);
        }
        await UserStore.to.saveProfile(user.uid);
        await UserStore.to.addUsers(user.uid);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> handleSignUpByEmail(String email, String password) async {
    var value = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (value.user != null) {
      UserModel user = UserModel(
        username: '',
        uid: value.user!.uid,
        userProfile: '',
        phoneNumber: '',
        email: email,
        address: '',
        medibotDetail: 'djmmI5mwGsNzprQFbu49',
        age: 0,
        careTaker: const CareTakerModel(
          careTakerAddress: '',
          careTakerName: '',
          caretakerPhone: '',
          uid: '',
        ),
        emergencyPerson: const EmergencyPersonModel(
          emergencyAddress: '',
          emergencyName: '',
          emergencyPhone: '',
          emergencyRelation: '',
        ),
        physicalDeviceLink: '',
        userStatus: AuthStatus.newUser,
      );
      await addUserData(user);
      await UserStore.to.saveProfile(user.uid);
      await UserStore.to.addUsers(user.uid);
      return true;
    }
    return false;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getMedibotId(String docId) async {
    await fireStore
        .collection('medibot')
        .doc(docId)
        .set({'ssId' : 'ssId', 'password' : 'password'});
    return await fireStore.collection('medibot').doc(docId).get();
  }

  Future<void> deletePill(String uid) async {
    await fireStore
        .collection('medibot')
        .doc(UserStore.to.profile.medibotDetail)
        .collection('pillsReminder')
        .doc(uid)
        .update({'userId': ''});
  }
}
