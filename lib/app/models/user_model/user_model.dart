import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel{
  
  const factory UserModel({
    required String uid,
    required String phoneNumber,
    required int age,
    required String address,
    required CareTakerModel careTaker,
    required EmergencyPersonModel emergencyPerson,
    required String medibotDetail,
    required String physicalDeviceLink,
    required String email,
    required String username,
    required String userProfile,
    required AuthStatus userStatus
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json)  => _$UserModelFromJson(json);
}

enum AuthStatus{
  newUser,
  existingUser
}

@freezed
class CareTakerModel with _$CareTakerModel{
  
  const factory CareTakerModel({
    required String uid,
    required String careTakerName,
    required String careTakerAddress,
    required String caretakerPhone,
  }) = _CareTakerModel;

  factory CareTakerModel.fromJson(Map<String, Object?> json)  => _$CareTakerModelFromJson(json);
}

@freezed
class EmergencyPersonModel with _$EmergencyPersonModel{
  
  const factory EmergencyPersonModel({
    required String emergencyName,
    required String emergencyAddress,
    required String emergencyPhone,
    required String emergencyRelation,
  }) = _EmergencyPersonModel;

  factory EmergencyPersonModel.fromJson(Map<String, Object?> json)  => _$EmergencyPersonModelFromJson(json);
}