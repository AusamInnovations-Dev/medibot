// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  CareTakerModel get careTaker => throw _privateConstructorUsedError;
  EmergencyPersonModel get emergencyPerson =>
      throw _privateConstructorUsedError;
  String get cabinetDetail => throw _privateConstructorUsedError;
  String get physicalDeviceLink => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get userProfile => throw _privateConstructorUsedError;
  AuthStatus get userStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String uid,
      String phoneNumber,
      int age,
      String address,
      CareTakerModel careTaker,
      EmergencyPersonModel emergencyPerson,
      String cabinetDetail,
      String physicalDeviceLink,
      String email,
      String username,
      String userProfile,
      AuthStatus userStatus});

  $CareTakerModelCopyWith<$Res> get careTaker;
  $EmergencyPersonModelCopyWith<$Res> get emergencyPerson;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? phoneNumber = null,
    Object? age = null,
    Object? address = null,
    Object? careTaker = null,
    Object? emergencyPerson = null,
    Object? cabinetDetail = null,
    Object? physicalDeviceLink = null,
    Object? email = null,
    Object? username = null,
    Object? userProfile = null,
    Object? userStatus = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      careTaker: null == careTaker
          ? _value.careTaker
          : careTaker // ignore: cast_nullable_to_non_nullable
              as CareTakerModel,
      emergencyPerson: null == emergencyPerson
          ? _value.emergencyPerson
          : emergencyPerson // ignore: cast_nullable_to_non_nullable
              as EmergencyPersonModel,
      cabinetDetail: null == cabinetDetail
          ? _value.cabinetDetail
          : cabinetDetail // ignore: cast_nullable_to_non_nullable
              as String,
      physicalDeviceLink: null == physicalDeviceLink
          ? _value.physicalDeviceLink
          : physicalDeviceLink // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userProfile: null == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CareTakerModelCopyWith<$Res> get careTaker {
    return $CareTakerModelCopyWith<$Res>(_value.careTaker, (value) {
      return _then(_value.copyWith(careTaker: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EmergencyPersonModelCopyWith<$Res> get emergencyPerson {
    return $EmergencyPersonModelCopyWith<$Res>(_value.emergencyPerson, (value) {
      return _then(_value.copyWith(emergencyPerson: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String phoneNumber,
      int age,
      String address,
      CareTakerModel careTaker,
      EmergencyPersonModel emergencyPerson,
      String cabinetDetail,
      String physicalDeviceLink,
      String email,
      String username,
      String userProfile,
      AuthStatus userStatus});

  @override
  $CareTakerModelCopyWith<$Res> get careTaker;
  @override
  $EmergencyPersonModelCopyWith<$Res> get emergencyPerson;
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? phoneNumber = null,
    Object? age = null,
    Object? address = null,
    Object? careTaker = null,
    Object? emergencyPerson = null,
    Object? cabinetDetail = null,
    Object? physicalDeviceLink = null,
    Object? email = null,
    Object? username = null,
    Object? userProfile = null,
    Object? userStatus = null,
  }) {
    return _then(_$_UserModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      careTaker: null == careTaker
          ? _value.careTaker
          : careTaker // ignore: cast_nullable_to_non_nullable
              as CareTakerModel,
      emergencyPerson: null == emergencyPerson
          ? _value.emergencyPerson
          : emergencyPerson // ignore: cast_nullable_to_non_nullable
              as EmergencyPersonModel,
      cabinetDetail: null == cabinetDetail
          ? _value.cabinetDetail
          : cabinetDetail // ignore: cast_nullable_to_non_nullable
              as String,
      physicalDeviceLink: null == physicalDeviceLink
          ? _value.physicalDeviceLink
          : physicalDeviceLink // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userProfile: null == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as String,
      userStatus: null == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  const _$_UserModel(
      {required this.uid,
      required this.phoneNumber,
      required this.age,
      required this.address,
      required this.careTaker,
      required this.emergencyPerson,
      required this.cabinetDetail,
      required this.physicalDeviceLink,
      required this.email,
      required this.username,
      required this.userProfile,
      required this.userStatus});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String uid;
  @override
  final String phoneNumber;
  @override
  final int age;
  @override
  final String address;
  @override
  final CareTakerModel careTaker;
  @override
  final EmergencyPersonModel emergencyPerson;
  @override
  final String cabinetDetail;
  @override
  final String physicalDeviceLink;
  @override
  final String email;
  @override
  final String username;
  @override
  final String userProfile;
  @override
  final AuthStatus userStatus;

  @override
  String toString() {
    return 'UserModel(uid: $uid, phoneNumber: $phoneNumber, age: $age, address: $address, careTaker: $careTaker, emergencyPerson: $emergencyPerson, cabinetDetail: $cabinetDetail, physicalDeviceLink: $physicalDeviceLink, email: $email, username: $username, userProfile: $userProfile, userStatus: $userStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.careTaker, careTaker) ||
                other.careTaker == careTaker) &&
            (identical(other.emergencyPerson, emergencyPerson) ||
                other.emergencyPerson == emergencyPerson) &&
            (identical(other.cabinetDetail, cabinetDetail) ||
                other.cabinetDetail == cabinetDetail) &&
            (identical(other.physicalDeviceLink, physicalDeviceLink) ||
                other.physicalDeviceLink == physicalDeviceLink) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      phoneNumber,
      age,
      address,
      careTaker,
      emergencyPerson,
      cabinetDetail,
      physicalDeviceLink,
      email,
      username,
      userProfile,
      userStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String uid,
      required final String phoneNumber,
      required final int age,
      required final String address,
      required final CareTakerModel careTaker,
      required final EmergencyPersonModel emergencyPerson,
      required final String cabinetDetail,
      required final String physicalDeviceLink,
      required final String email,
      required final String username,
      required final String userProfile,
      required final AuthStatus userStatus}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get uid;
  @override
  String get phoneNumber;
  @override
  int get age;
  @override
  String get address;
  @override
  CareTakerModel get careTaker;
  @override
  EmergencyPersonModel get emergencyPerson;
  @override
  String get cabinetDetail;
  @override
  String get physicalDeviceLink;
  @override
  String get email;
  @override
  String get username;
  @override
  String get userProfile;
  @override
  AuthStatus get userStatus;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

CareTakerModel _$CareTakerModelFromJson(Map<String, dynamic> json) {
  return _CareTakerModel.fromJson(json);
}

/// @nodoc
mixin _$CareTakerModel {
  String get uid => throw _privateConstructorUsedError;
  String get careTakerName => throw _privateConstructorUsedError;
  String get careTakerAddress => throw _privateConstructorUsedError;
  String get caretakerPhone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CareTakerModelCopyWith<CareTakerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CareTakerModelCopyWith<$Res> {
  factory $CareTakerModelCopyWith(
          CareTakerModel value, $Res Function(CareTakerModel) then) =
      _$CareTakerModelCopyWithImpl<$Res, CareTakerModel>;
  @useResult
  $Res call(
      {String uid,
      String careTakerName,
      String careTakerAddress,
      String caretakerPhone});
}

/// @nodoc
class _$CareTakerModelCopyWithImpl<$Res, $Val extends CareTakerModel>
    implements $CareTakerModelCopyWith<$Res> {
  _$CareTakerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? careTakerName = null,
    Object? careTakerAddress = null,
    Object? caretakerPhone = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      careTakerName: null == careTakerName
          ? _value.careTakerName
          : careTakerName // ignore: cast_nullable_to_non_nullable
              as String,
      careTakerAddress: null == careTakerAddress
          ? _value.careTakerAddress
          : careTakerAddress // ignore: cast_nullable_to_non_nullable
              as String,
      caretakerPhone: null == caretakerPhone
          ? _value.caretakerPhone
          : caretakerPhone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CareTakerModelCopyWith<$Res>
    implements $CareTakerModelCopyWith<$Res> {
  factory _$$_CareTakerModelCopyWith(
          _$_CareTakerModel value, $Res Function(_$_CareTakerModel) then) =
      __$$_CareTakerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String careTakerName,
      String careTakerAddress,
      String caretakerPhone});
}

/// @nodoc
class __$$_CareTakerModelCopyWithImpl<$Res>
    extends _$CareTakerModelCopyWithImpl<$Res, _$_CareTakerModel>
    implements _$$_CareTakerModelCopyWith<$Res> {
  __$$_CareTakerModelCopyWithImpl(
      _$_CareTakerModel _value, $Res Function(_$_CareTakerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? careTakerName = null,
    Object? careTakerAddress = null,
    Object? caretakerPhone = null,
  }) {
    return _then(_$_CareTakerModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      careTakerName: null == careTakerName
          ? _value.careTakerName
          : careTakerName // ignore: cast_nullable_to_non_nullable
              as String,
      careTakerAddress: null == careTakerAddress
          ? _value.careTakerAddress
          : careTakerAddress // ignore: cast_nullable_to_non_nullable
              as String,
      caretakerPhone: null == caretakerPhone
          ? _value.caretakerPhone
          : caretakerPhone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CareTakerModel implements _CareTakerModel {
  const _$_CareTakerModel(
      {required this.uid,
      required this.careTakerName,
      required this.careTakerAddress,
      required this.caretakerPhone});

  factory _$_CareTakerModel.fromJson(Map<String, dynamic> json) =>
      _$$_CareTakerModelFromJson(json);

  @override
  final String uid;
  @override
  final String careTakerName;
  @override
  final String careTakerAddress;
  @override
  final String caretakerPhone;

  @override
  String toString() {
    return 'CareTakerModel(uid: $uid, careTakerName: $careTakerName, careTakerAddress: $careTakerAddress, caretakerPhone: $caretakerPhone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CareTakerModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.careTakerName, careTakerName) ||
                other.careTakerName == careTakerName) &&
            (identical(other.careTakerAddress, careTakerAddress) ||
                other.careTakerAddress == careTakerAddress) &&
            (identical(other.caretakerPhone, caretakerPhone) ||
                other.caretakerPhone == caretakerPhone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, uid, careTakerName, careTakerAddress, caretakerPhone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CareTakerModelCopyWith<_$_CareTakerModel> get copyWith =>
      __$$_CareTakerModelCopyWithImpl<_$_CareTakerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CareTakerModelToJson(
      this,
    );
  }
}

abstract class _CareTakerModel implements CareTakerModel {
  const factory _CareTakerModel(
      {required final String uid,
      required final String careTakerName,
      required final String careTakerAddress,
      required final String caretakerPhone}) = _$_CareTakerModel;

  factory _CareTakerModel.fromJson(Map<String, dynamic> json) =
      _$_CareTakerModel.fromJson;

  @override
  String get uid;
  @override
  String get careTakerName;
  @override
  String get careTakerAddress;
  @override
  String get caretakerPhone;
  @override
  @JsonKey(ignore: true)
  _$$_CareTakerModelCopyWith<_$_CareTakerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

EmergencyPersonModel _$EmergencyPersonModelFromJson(Map<String, dynamic> json) {
  return _EmergencyPersonModel.fromJson(json);
}

/// @nodoc
mixin _$EmergencyPersonModel {
  String get emergencyName => throw _privateConstructorUsedError;
  String get emergencyAddress => throw _privateConstructorUsedError;
  String get emergencyPhone => throw _privateConstructorUsedError;
  String get emergencyRelation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmergencyPersonModelCopyWith<EmergencyPersonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmergencyPersonModelCopyWith<$Res> {
  factory $EmergencyPersonModelCopyWith(EmergencyPersonModel value,
          $Res Function(EmergencyPersonModel) then) =
      _$EmergencyPersonModelCopyWithImpl<$Res, EmergencyPersonModel>;
  @useResult
  $Res call(
      {String emergencyName,
      String emergencyAddress,
      String emergencyPhone,
      String emergencyRelation});
}

/// @nodoc
class _$EmergencyPersonModelCopyWithImpl<$Res,
        $Val extends EmergencyPersonModel>
    implements $EmergencyPersonModelCopyWith<$Res> {
  _$EmergencyPersonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emergencyName = null,
    Object? emergencyAddress = null,
    Object? emergencyPhone = null,
    Object? emergencyRelation = null,
  }) {
    return _then(_value.copyWith(
      emergencyName: null == emergencyName
          ? _value.emergencyName
          : emergencyName // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyAddress: null == emergencyAddress
          ? _value.emergencyAddress
          : emergencyAddress // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPhone: null == emergencyPhone
          ? _value.emergencyPhone
          : emergencyPhone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyRelation: null == emergencyRelation
          ? _value.emergencyRelation
          : emergencyRelation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EmergencyPersonModelCopyWith<$Res>
    implements $EmergencyPersonModelCopyWith<$Res> {
  factory _$$_EmergencyPersonModelCopyWith(_$_EmergencyPersonModel value,
          $Res Function(_$_EmergencyPersonModel) then) =
      __$$_EmergencyPersonModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String emergencyName,
      String emergencyAddress,
      String emergencyPhone,
      String emergencyRelation});
}

/// @nodoc
class __$$_EmergencyPersonModelCopyWithImpl<$Res>
    extends _$EmergencyPersonModelCopyWithImpl<$Res, _$_EmergencyPersonModel>
    implements _$$_EmergencyPersonModelCopyWith<$Res> {
  __$$_EmergencyPersonModelCopyWithImpl(_$_EmergencyPersonModel _value,
      $Res Function(_$_EmergencyPersonModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emergencyName = null,
    Object? emergencyAddress = null,
    Object? emergencyPhone = null,
    Object? emergencyRelation = null,
  }) {
    return _then(_$_EmergencyPersonModel(
      emergencyName: null == emergencyName
          ? _value.emergencyName
          : emergencyName // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyAddress: null == emergencyAddress
          ? _value.emergencyAddress
          : emergencyAddress // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyPhone: null == emergencyPhone
          ? _value.emergencyPhone
          : emergencyPhone // ignore: cast_nullable_to_non_nullable
              as String,
      emergencyRelation: null == emergencyRelation
          ? _value.emergencyRelation
          : emergencyRelation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EmergencyPersonModel implements _EmergencyPersonModel {
  const _$_EmergencyPersonModel(
      {required this.emergencyName,
      required this.emergencyAddress,
      required this.emergencyPhone,
      required this.emergencyRelation});

  factory _$_EmergencyPersonModel.fromJson(Map<String, dynamic> json) =>
      _$$_EmergencyPersonModelFromJson(json);

  @override
  final String emergencyName;
  @override
  final String emergencyAddress;
  @override
  final String emergencyPhone;
  @override
  final String emergencyRelation;

  @override
  String toString() {
    return 'EmergencyPersonModel(emergencyName: $emergencyName, emergencyAddress: $emergencyAddress, emergencyPhone: $emergencyPhone, emergencyRelation: $emergencyRelation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmergencyPersonModel &&
            (identical(other.emergencyName, emergencyName) ||
                other.emergencyName == emergencyName) &&
            (identical(other.emergencyAddress, emergencyAddress) ||
                other.emergencyAddress == emergencyAddress) &&
            (identical(other.emergencyPhone, emergencyPhone) ||
                other.emergencyPhone == emergencyPhone) &&
            (identical(other.emergencyRelation, emergencyRelation) ||
                other.emergencyRelation == emergencyRelation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, emergencyName, emergencyAddress,
      emergencyPhone, emergencyRelation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmergencyPersonModelCopyWith<_$_EmergencyPersonModel> get copyWith =>
      __$$_EmergencyPersonModelCopyWithImpl<_$_EmergencyPersonModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EmergencyPersonModelToJson(
      this,
    );
  }
}

abstract class _EmergencyPersonModel implements EmergencyPersonModel {
  const factory _EmergencyPersonModel(
      {required final String emergencyName,
      required final String emergencyAddress,
      required final String emergencyPhone,
      required final String emergencyRelation}) = _$_EmergencyPersonModel;

  factory _EmergencyPersonModel.fromJson(Map<String, dynamic> json) =
      _$_EmergencyPersonModel.fromJson;

  @override
  String get emergencyName;
  @override
  String get emergencyAddress;
  @override
  String get emergencyPhone;
  @override
  String get emergencyRelation;
  @override
  @JsonKey(ignore: true)
  _$$_EmergencyPersonModelCopyWith<_$_EmergencyPersonModel> get copyWith =>
      throw _privateConstructorUsedError;
}
