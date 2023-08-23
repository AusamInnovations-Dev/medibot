import 'package:freezed_annotation/freezed_annotation.dart';

part 'medibot_model.freezed.dart';
part 'medibot_model.g.dart';

@freezed
class MedibotModel with _$MedibotModel {
  factory MedibotModel({
    required String uid,
    required String pillName,
    required List<String> interval,
    required int remainingPills,
    required int remainingDays,
  }) = _MedibotModel;

  factory MedibotModel.fromJson(Map<String, Object?> json) =>
      _$MedibotModelFromJson(json);
}
