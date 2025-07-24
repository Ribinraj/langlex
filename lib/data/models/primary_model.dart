class PrimaryCategoryModel {
  final int primaryCategoryId;
  final int languageId;
  final String categoryName;
  final String categoryPicture;
  final int isPremium;
  final int planId;
  final String status;
  final int createdBy;
  final DateTime createdAt;
  final DateTime modifiedAt;

  PrimaryCategoryModel({
    required this.primaryCategoryId,
    required this.languageId,
    required this.categoryName,
    required this.categoryPicture,
    required this.isPremium,
    required this.planId,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory PrimaryCategoryModel.fromJson(Map<String, dynamic> json) {
    return PrimaryCategoryModel(
      primaryCategoryId: json['primaryCategoryId'],
      languageId: json['languageId'],
      categoryName: json['categoryName'],
      categoryPicture: json['categoryPicture'],
      isPremium: json['isPremium'],
      planId: json['planId'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['created_at']),
      modifiedAt: DateTime.parse(json['modified_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primaryCategoryId': primaryCategoryId,
      'languageId': languageId,
      'categoryName': categoryName,
      'categoryPicture': categoryPicture,
      'isPremium': isPremium,
      'planId': planId,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'modified_at': modifiedAt.toIso8601String(),
    };
  }
}
