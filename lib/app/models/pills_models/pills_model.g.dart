// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pills_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PillsModel _$$_PillsModelFromJson(Map<String, dynamic> json) =>
    _$_PillsModel(
          uid: json['uid'] as String,
          userId: json['userId'] as String,
          slot: json['slot'] as int,
          request: json['request'] as int,
          pillName: json['pillName'] as String,
          medicineCategory: json['medicineCategory'] == null ? '' : json['medicineCategory'] as String,
          dosage: json['dosage'] as String,
          interval: json['interval'] as String,
          pillsQuantity: json['pillsQuantity'] as String,
          pillsInterval: (json['pillsInterval'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          pillsDuration: (json['pillsDuration'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          isRange: json['isRange'] as bool,
          isIndividual: json['isIndividual'] as bool,
          inMedibot: json['inMedibot'] as bool,
    );

Map<String, dynamic> _$$_PillsModelToJson(_$_PillsModel instance) =>
    <String, dynamic>{
          'uid': instance.uid,
          'userId': instance.userId,
          'slot': instance.slot,
          'request': instance.request,
          'pillName': instance.pillName,
          'medicineCategory': instance.medicineCategory,
          'dosage': instance.dosage,
          'interval': instance.interval,
          'pillsQuantity': instance.pillsQuantity,
          'pillsInterval': instance.pillsInterval,
          'pillsDuration': instance.pillsDuration,
          'isRange': instance.isRange,
          'isIndividual': instance.isIndividual,
          'inMedibot': instance.inMedibot,
    };