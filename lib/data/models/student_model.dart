import 'dart:io';

import 'package:dio/dio.dart';

class StudentModel {
  String name;
  int age;
  String dob;
  String school;
  String city;
  String country;
  List<int> languageId;
  File? image;

  StudentModel({
    required this.name,
    required this.age,
    required this.dob,
    required this.school,
    required this.city,
    required this.country,
    required this.languageId,
     this.image,
  });

  // Factory method to create an object from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      age: json['age'],
      dob: json['dob'],
      school: json['school'],
      city: json['city'],
      country: json['country'],
      languageId: List<int>.from(json['languageId']),
      
    );
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'dob': dob,
      'school': school,
      'city': city,
      'country': country,
      'languageId': languageId,
    };
  }
   // Method to create FormData for API submission
  Future<FormData> toFormData() async {
    Map<String, dynamic> formDataMap = {
      'name': name,
      'age': age.toString(),
      'dob': dob,
      'school': school,
      'city': city,
      'country': country,
      'languageId': languageId.map((id) => id.toString()).toList(),
    };
    
    // Add image if present
    if (image != null) {
      String fileName = image!.path.split('/').last;
      formDataMap['image'] = await MultipartFile.fromFile(
        image!.path,
        filename: fileName,
      );
    }
    
    return FormData.fromMap(formDataMap);
  }
}
