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
      kidId: json['kidId'] ?? 0, // Provide default value for null
      name: json['name'] ?? '', // Provide default value for null
      age: json['age'] ?? 0, // Provide default value for null
      dob: json['dob'] ?? '', // Provide default value for null
      school: json['school'] ?? '', // Provide default value for null
      city: json['city'] ?? '', // Provide default value for null
      country: json['country'] ?? '', // Provide default value for null
      picture: json['picture'], // This can be null as per your model
      languages: json['languages'] != null
          ? (json['languages'] as List)
              .map((lang) => LanguageModel2.fromJson(lang))
              .toList()
          : [], // Provide empty list if languages is null
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
      languageId: json['languageId'] ?? 0, // Provide default value for null
      languageName: json['languageName'] ?? '', // Provide default value for null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languageId': languageId,
      'languageName': languageName,
    };
  }
}

// Alternative approach with better error handling and validation
class StudentListModelSafe {
  final int kidId;
  final String name;
  final int age;
  final String dob;
  final String school;
  final String city;
  final String country;
  final String? picture;
  final List<LanguageModel2> languages;

  StudentListModelSafe({
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

  factory StudentListModelSafe.fromJson(Map<String, dynamic> json) {
    try {
      return StudentListModelSafe(
        kidId: _parseToInt(json['kidId']),
        name: _parseToString(json['name']),
        age: _parseToInt(json['age']),
        dob: _parseToString(json['dob']),
        school: _parseToString(json['school']),
        city: _parseToString(json['city']),
        country: _parseToString(json['country']),
        picture: json['picture']?.toString(),
        languages: _parseLanguages(json['languages']),
      );
    } catch (e) {
      throw FormatException('Error parsing StudentListModel: $e');
    }
  }

  // Helper methods for safe parsing
  static int _parseToInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static String _parseToString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static List<LanguageModel2> _parseLanguages(dynamic languages) {
    if (languages == null) return [];
    if (languages is! List) return [];
    
    return languages
        .where((lang) => lang != null)
        .map((lang) {
          try {
            return LanguageModel2.fromJson(lang as Map<String, dynamic>);
          } catch (e) {
            print('Error parsing language: $e');
            return null;
          }
        })
        .where((lang) => lang != null)
        .cast<LanguageModel2>()
        .toList();
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