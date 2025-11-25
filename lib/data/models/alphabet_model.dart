class AlphabetModel {
  final int alphabetId;
  final int languageId;
  final String alphabet;
  final String illWord;
  final String picture;
  final String audio;
  final String wordAudio;
  final String referencePicture;
  final String referenceText;
  final String referenceAudio;
  final String status;
  final int? createdBy;
  final String? createdAt;
  final String? modifiedAt;
  final String letterType;
  final String courseName;
  final String subcategory;
  final String category;
  final String titleImage;
  final int? levelId;

  AlphabetModel({
    required this.alphabetId,
    required this.languageId,
    required this.alphabet,
    required this.illWord,
    required this.picture,
    required this.audio,
    required this.wordAudio,
    required this.referencePicture,
    required this.referenceText,
    required this.referenceAudio,
    required this.status,
    this.createdBy,
    this.createdAt,
    this.modifiedAt,
    required this.letterType,
    required this.courseName,
    required this.subcategory,
    required this.category,
    required this.titleImage,
    this.levelId,
  });

  factory AlphabetModel.fromJson(Map<String, dynamic> json) {
    return AlphabetModel(
      alphabetId: json['alphabetId'] ?? 0,
      languageId: json['languageId'] ?? 0,
      alphabet: json['alphabet'] ?? '',
      illWord: json['ill_word'] ?? '',
      picture: json['picture'] ?? '',
      audio: json['audio'] ?? '',
      wordAudio: json['word_audio'] ?? '',
      referencePicture: json['referencePicture'] ?? 'NA',
      referenceText: json['referenceText'] ?? 'NA',
      referenceAudio: json['referenceAudio'] ?? 'NA',
      status: json['status'] ?? 'Inactive',
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      modifiedAt: json['modified_at'],
      letterType: json['letter_type'] ?? '',
      courseName: json['coursename'] ?? '',
      subcategory: json['subcategory'] ?? '',
      category: json['category'] ?? '',
      titleImage: json['title_image'] ?? '',
      levelId: json['levelId'],
    );
  }
}
