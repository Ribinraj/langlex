class ContentModel {
  final int contentId;
  final int languageId;
  final String primaryCategoryId;
  final String secondaryCategoryId;
  final String content;
  final String contentImage;
  final String contentAudio;
  final String referenceAudio;

  ContentModel({
    required this.contentId,
    required this.languageId,
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
    required this.content,
    required this.contentImage,
    required this.contentAudio,
    required this.referenceAudio,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      contentId: json['contentId'] as int,
      languageId: json['languageId'] as int,
      primaryCategoryId: json['primaryCategoryId'].toString(),
      secondaryCategoryId: json['secondaryCategoryId'].toString(),
      content: json['content'] as String,
      contentImage: json['contentImage'] as String,
      contentAudio: json['contentAudio'] as String,
      referenceAudio: json['referenceAudio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contentId': contentId,
      'languageId': languageId,
      'primaryCategoryId': primaryCategoryId,
      'secondaryCategoryId': secondaryCategoryId,
      'content': content,
      'contentImage': contentImage,
      'contentAudio': contentAudio,
      'referenceAudio': referenceAudio,
    };
  }
}