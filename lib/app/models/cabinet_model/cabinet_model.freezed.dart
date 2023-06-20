// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cabinet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CabinetModel _$CabinetModelFromJson(Map<String, dynamic> json) {
  return _CabinetModel.fromJson(json);
}

/// @nodoc
mixin _$CabinetModel {
  String get uid => throw _privateConstructorUsedError;
  String get pillName => throw _privateConstructorUsedError;
  List<String> get interval => throw _privateConstructorUsedError;
  int get remainingPills => throw _privateConstructorUsedError;
  int get remainingDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CabinetModelCopyWith<CabinetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CabinetModelCopyWith<$Res> {
  factory $CabinetModelCopyWith(
          CabinetModel value, $Res Function(CabinetModel) then) =
      _$CabinetModelCopyWithImpl<$Res, CabinetModel>;
  @useResult
  $Res call(
      {String uid,
      String pillName,
      List<String> interval,
      int remainingPills,
      int remainingDays});
}

/// @nodoc
class _$CabinetModelCopyWithImpl<$Res, $Val extends CabinetModel>
    implements $CabinetModelCopyWith<$Res> {
  _$CabinetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? pillName = null,
    Object? interval = null,
    Object? remainingPills = null,
    Object? remainingDays = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      pillName: null == pillName
          ? _value.pillName
          : pillName // ignore: cast_nullable_to_non_nullable
              as String,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as List<String>,
      remainingPills: null == remainingPills
          ? _value.remainingPills
          : remainingPills // ignore: cast_nullable_to_non_nullable
              as int,
      remainingDays: null == remainingDays
          ? _value.remainingDays
          : remainingDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CabinetModelCopyWith<$Res>
    implements $CabinetModelCopyWith<$Res> {
  factory _$$_CabinetModelCopyWith(
          _$_CabinetModel value, $Res Function(_$_CabinetModel) then) =
      __$$_CabinetModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String pillName,
      List<String> interval,
      int remainingPills,
      int remainingDays});
}

/// @nodoc
class __$$_CabinetModelCopyWithImpl<$Res>
    extends _$CabinetModelCopyWithImpl<$Res, _$_CabinetModel>
    implements _$$_CabinetModelCopyWith<$Res> {
  __$$_CabinetModelCopyWithImpl(
      _$_CabinetModel _value, $Res Function(_$_CabinetModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? pillName = null,
    Object? interval = null,
    Object? remainingPills = null,
    Object? remainingDays = null,
  }) {
    return _then(_$_CabinetModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      pillName: null == pillName
          ? _value.pillName
          : pillName // ignore: cast_nullable_to_non_nullable
              as String,
      interval: null == interval
          ? _value._interval
          : interval // ignore: cast_nullable_to_non_nullable
              as List<String>,
      remainingPills: null == remainingPills
          ? _value.remainingPills
          : remainingPills // ignore: cast_nullable_to_non_nullable
              as int,
      remainingDays: null == remainingDays
          ? _value.remainingDays
          : remainingDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CabinetModel implements _CabinetModel {
  _$_CabinetModel(
      {required this.uid,
      required this.pillName,
      required final List<String> interval,
      required this.remainingPills,
      required this.remainingDays})
      : _interval = interval;

  factory _$_CabinetModel.fromJson(Map<String, dynamic> json) =>
      _$$_CabinetModelFromJson(json);

  @override
  final String uid;
  @override
  final String pillName;
  final List<String> _interval;
  @override
  List<String> get interval {
    if (_interval is EqualUnmodifiableListView) return _interval;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interval);
  }

  @override
  final int remainingPills;
  @override
  final int remainingDays;

  @override
  String toString() {
    return 'CabinetModel(uid: $uid, pillName: $pillName, interval: $interval, remainingPills: $remainingPills, remainingDays: $remainingDays)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CabinetModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.pillName, pillName) ||
                other.pillName == pillName) &&
            const DeepCollectionEquality().equals(other._interval, _interval) &&
            (identical(other.remainingPills, remainingPills) ||
                other.remainingPills == remainingPills) &&
            (identical(other.remainingDays, remainingDays) ||
                other.remainingDays == remainingDays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      pillName,
      const DeepCollectionEquality().hash(_interval),
      remainingPills,
      remainingDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CabinetModelCopyWith<_$_CabinetModel> get copyWith =>
      __$$_CabinetModelCopyWithImpl<_$_CabinetModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CabinetModelToJson(
      this,
    );
  }
}

abstract class _CabinetModel implements CabinetModel {
  factory _CabinetModel(
      {required final String uid,
      required final String pillName,
      required final List<String> interval,
      required final int remainingPills,
      required final int remainingDays}) = _$_CabinetModel;

  factory _CabinetModel.fromJson(Map<String, dynamic> json) =
      _$_CabinetModel.fromJson;

  @override
  String get uid;
  @override
  String get pillName;
  @override
  List<String> get interval;
  @override
  int get remainingPills;
  @override
  int get remainingDays;
  @override
  @JsonKey(ignore: true)
  _$$_CabinetModelCopyWith<_$_CabinetModel> get copyWith =>
      throw _privateConstructorUsedError;
}
