import 'package:freezed_annotation/freezed_annotation.dart';

part 'cabinet_model.freezed.dart';
part 'cabinet_model.g.dart';

@freezed
class CabinetModel with _$CabinetModel {
  factory CabinetModel({
    required String uid,
    required String pillName,
    required List<String> interval,
    required int remainingPills,
    required int remainingDays,
  }) = _CabinetModel;

  factory CabinetModel.fromJson(Map<String, Object?> json) =>
      _$CabinetModelFromJson(json);
}
