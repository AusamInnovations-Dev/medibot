// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HistoryModel _$$_HistoryModelFromJson(Map<String, dynamic> json) =>
    _$_HistoryModel(
      userId: json['userId'] as String,
      historyData: (json['historyData'] as List<dynamic>)
          .map((e) => HistoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_HistoryModelToJson(_$_HistoryModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'historyData': instance.historyData.map((element) => element.toJson()).toList(),
    };

_$_HistoryData _$$_HistoryDataFromJson(Map<String, dynamic> json) =>
    _$_HistoryData(
      pillId: json['pillId'] as String,
      med_status: (json['med_status'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timeTaken: (json['timeTaken'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      timeToTake: (json['timeToTake'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_HistoryDataToJson(_$_HistoryData instance) =>
    <String, dynamic>{
      'pillId': instance.pillId,
      'med_status': instance.med_status,
      'timeTaken': instance.timeTaken.map((e) => e.toIso8601String()).toList(),
      'timeToTake': instance.timeToTake,
    };
