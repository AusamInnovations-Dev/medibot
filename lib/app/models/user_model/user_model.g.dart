// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      userProfile: json['userProfile'] as String,
      userStatus: $enumDecode(_$AuthStatusEnumMap, json['userStatus']),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'username': instance.username,
      'userProfile': instance.userProfile,
      'userStatus': _$AuthStatusEnumMap[instance.userStatus]!,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.newUser: 'newUser',
  AuthStatus.existingUser: 'existingUser',
};
