// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String,
      phoneNumber: json['phoneNumber'] as String,
      age: json['age'] as int,
      address: json['address'] as String,
      careTaker:
          CareTakerModel.fromJson(json['careTaker'] as Map<String, dynamic>),
      emergencyPerson: EmergencyPersonModel.fromJson(
          json['emergencyPerson'] as Map<String, dynamic>),
      cabinetDetail: json['cabinetDetail'] as String,
      physicalDeviceLink: json['physicalDeviceLink'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      userProfile: json['userProfile'] as String,
      userStatus: $enumDecode(_$AuthStatusEnumMap, json['userStatus']),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'phoneNumber': instance.phoneNumber,
      'age': instance.age,
      'address': instance.address,
      'careTaker': instance.careTaker.toJson(),
      'emergencyPerson': instance.emergencyPerson.toJson(),
      'cabinetDetail': instance.cabinetDetail,
      'physicalDeviceLink': instance.physicalDeviceLink,
      'email': instance.email,
      'username': instance.username,
      'userProfile': instance.userProfile,
      'userStatus': _$AuthStatusEnumMap[instance.userStatus]!,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.newUser: 'newUser',
  AuthStatus.existingUser: 'existingUser',
};

_$_CareTakerModel _$$_CareTakerModelFromJson(Map<String, dynamic> json) =>
    _$_CareTakerModel(
      uid: json['uid'] as String,
      careTakerName: json['careTakerName'] as String,
      careTakerAddress: json['careTakerAddress'] as String,
      caretakerPhone: json['caretakerPhone'] as String,
    );

Map<String, dynamic> _$$_CareTakerModelToJson(_$_CareTakerModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'careTakerName': instance.careTakerName,
      'careTakerAddress': instance.careTakerAddress,
      'caretakerPhone': instance.caretakerPhone,
    };

_$_EmergencyPersonModel _$$_EmergencyPersonModelFromJson(
        Map<String, dynamic> json) =>
    _$_EmergencyPersonModel(
      emergencyName: json['emergencyName'] as String,
      emergencyAddress: json['emergencyAddress'] as String,
      emergencyPhone: json['emergencyPhone'] as String,
      emergencyRelation: json['emergencyRelation'] as String,
    );

Map<String, dynamic> _$$_EmergencyPersonModelToJson(
        _$_EmergencyPersonModel instance) =>
    <String, dynamic>{
      'emergencyName': instance.emergencyName,
      'emergencyAddress': instance.emergencyAddress,
      'emergencyPhone': instance.emergencyPhone,
      'emergencyRelation': instance.emergencyRelation,
    };
