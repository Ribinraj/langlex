class LanguageModel {
  int languageId;
  String languageName;
  String isoCode;
  dynamic languagePicture;
  dynamic createdBy;
  String status;
  DateTime createdAt;
  DateTime modifiedAt;

  LanguageModel({
    required this.languageId,
    required this.languageName,
    required this.isoCode,
    required this.languagePicture,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  // 🔁 From JSON
factory LanguageModel.fromJson(Map<String, dynamic> json) {
  return LanguageModel(
    languageId: json['languageId'],
    languageName: json['languageName'],
    isoCode: json['isoCode'],
    languagePicture: json['languagePicture'],
    createdBy: json['created_by'], // ✅ FIXED
    status: json['status'],
    createdAt: DateTime.parse(json['created_at']), // ✅ FIXED
    modifiedAt: DateTime.parse(json['modified_at']), // ✅ FIXED
  );
}


  // 🔄 To JSON (optional, useful for API POST/PUT)
Map<String, dynamic> toJson() {
  return {
    'languageId': languageId,
    'languageName': languageName,
    'isoCode': isoCode,
    'languagePicture': languagePicture,
    'created_by': createdBy,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'modified_at': modifiedAt.toIso8601String(),
  };
}

}
