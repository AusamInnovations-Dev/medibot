import 'package:freezed_annotation/freezed_annotation.dart';

part 'pills_model.freezed.dart';
part 'pills_model.g.dart';

@freezed
class PillsModel with _$PillsModel{
  
  const factory PillsModel({
    required String uid,
    required int slot,
    required int request,
    required String pillName,
    required String dosage,
    required String interval,
    required String pillsQuantity,
    required List<String> pillsInterval,
    required List<String> pillsDuration,
    required bool isRange,
    required bool isIndividual,
    required bool inCabinet,
  }) = _PillsModel;

  factory PillsModel.fromJson(Map<String, Object?> json)  => _$PillsModelFromJson(json);
}
