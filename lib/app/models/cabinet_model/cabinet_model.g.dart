// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabinet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CabinetModel _$$_CabinetModelFromJson(Map<String, dynamic> json) =>
    _$_CabinetModel(
      uid: json['uid'] as String,
      pillName: json['pillName'] as String,
      interval:
          (json['interval'] as List<dynamic>).map((e) => e as String).toList(),
      remainingPills: json['remainingPills'] as int,
      remainingDays: json['remainingDays'] as int,
    );

Map<String, dynamic> _$$_CabinetModelToJson(_$_CabinetModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'pillName': instance.pillName,
      'interval': instance.interval,
      'remainingPills': instance.remainingPills,
      'remainingDays': instance.remainingDays,
    };
