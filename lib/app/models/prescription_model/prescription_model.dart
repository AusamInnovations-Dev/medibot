class PrescriptionModel {
  final String? uid;
  final String? userId;
  final List? presImgUrl;
  final String? pillName;
  final String? medicineCategory;
  final String? dosage;
  final String? interval;
  final List? pillsDuration;
  final bool? isRange;
  final bool? isIndividual;

  PrescriptionModel({
    this.uid,
    this.userId,
    this.pillName,
    this.medicineCategory,
    this.dosage,
    this.interval,
    this.presImgUrl,
    this.pillsDuration,
    this.isRange,
    this.isIndividual,
  });

  PrescriptionModel copyWith({
    String? uid,
    String? userId,
    String? pillName,
    String? medicineCategory,
    String? dosage,
    String? interval,
    List? presImgUrl,
    List? pillsDuration,
    bool? isRange,
    bool? isIndividual,
  }) {
    return PrescriptionModel(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      pillName: pillName ?? this.pillName,
      medicineCategory: medicineCategory ?? this.medicineCategory,
      dosage: dosage ?? this.dosage,
      interval: interval ?? this.interval,
      pillsDuration: pillsDuration ?? this.pillsDuration,
      isRange: isRange ?? this.isRange,
      presImgUrl: presImgUrl?? this.presImgUrl,
      isIndividual: isIndividual ?? this.isIndividual,
    );
  }

  PrescriptionModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String?,
        userId = json['userId'] as String?,
        pillName = json['pillName'] as String?,
        medicineCategory = json['medicineCategory'] as String?,
        dosage = json['dosage'] as String?,
        interval = json['interval'] as String?,
        pillsDuration = json['pillsDuration'] as List?,
        isRange = json['isRange'] as bool?,
        presImgUrl = json['presImgUrl']?? [],
        isIndividual = json['isIndividual'] as bool?;

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'userId' : userId,
    'pillName' : pillName,
    'medicineCategory' : medicineCategory,
    'dosage' : dosage,
    'interval' : interval,
    'pillsDuration' : pillsDuration,
    'isRange' : isRange,
    'isIndividual' : isIndividual,
    'presImgUrl': presImgUrl
  };
}