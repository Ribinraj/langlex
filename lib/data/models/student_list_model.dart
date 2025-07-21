class StudentListModel {
  final int kidId;
  final String name;
  final int age;
  final String dob;
  final String school;
  final String city;
  final String country;
  final String? picture;
  final List<LanguageModel2> languages;

  StudentListModel({
    required this.kidId,
    required this.name,
    required this.age,
    required this.dob,
    required this.school,
    required this.city,
    required this.country,
    required this.picture,
    required this.languages,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> json) {
    return StudentListModel(
      kidId: json['kidId'],
      name: json['name'],
      age: json['age'],
      dob: json['dob'],
      school: json['school'],
      city: json['city'],
      country: json['country'],
      picture: json['picture'],
      languages: (json['languages'] as List)
          .map((lang) => LanguageModel2.fromJson(lang))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kidId': kidId,
      'name': name,
      'age': age,
      'dob': dob,
      'school': school,
      'city': city,
      'country': country,
      'picture': picture,
      'languages': languages.map((lang) => lang.toJson()).toList(),
    };
  }
}
class LanguageModel2 {
  final int languageId;
  final String languageName;

  LanguageModel2({
    required this.languageId,
    required this.languageName,
  });

  factory LanguageModel2.fromJson(Map<String, dynamic> json) {
    return LanguageModel2(
      languageId: json['languageId'],
      languageName: json['languageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languageId': languageId,
      'languageName': languageName,
    };
  }
}
