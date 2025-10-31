class SecondaryModel {
  final int secondaryCategoryId;
  final int primaryCategoryId;
  final int languageId;
  final String categoryName;
  final String categoryPicture;
  final int isPremium;
  final int? planId;
  final String status;
  final int createdBy;
  final String createdAt;
  final String modifiedAt;

  SecondaryModel({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
    required this.languageId,
    required this.categoryName,
    required this.categoryPicture,
    required this.isPremium,
    this.planId,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory SecondaryModel.fromJson(Map<String, dynamic> json) {
    return SecondaryModel(
      secondaryCategoryId: json['secondaryCategoryId'] ?? 0,
      primaryCategoryId: json['primaryCategoryId'] ?? 0,
      languageId: json['languageId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      categoryPicture: json['categoryPicture'] ?? '',
      isPremium: json['isPremium'] ?? 0,
      planId: json['planId'],
      status: json['status'] ?? '',
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] ?? '',
      modifiedAt: json['modified_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secondaryCategoryId': secondaryCategoryId,
      'primaryCategoryId': primaryCategoryId,
      'languageId': languageId,
      'categoryName': categoryName,
      'categoryPicture': categoryPicture,
      'isPremium': isPremium,
      'planId': planId,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt,
      'modified_at': modifiedAt,
    };
  }
}
