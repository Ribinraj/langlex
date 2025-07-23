import 'dart:io';

import 'package:dio/dio.dart';


import 'package:http_parser/http_parser.dart';

class StudentModel {
  String name;
  int age;
  String dob;
  String school;
  String city;
  String country;
  List<int> languageId;
  File? image; // Add image field
  
  StudentModel({
    required this.name,
    required this.age,
    required this.dob,
    required this.school,
    required this.city,
    required this.country,
    required this.languageId,
    this.image, // Optional image parameter
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
      // Note: image is not included in fromJson as it's a File object
    );
  }
  
  // Method to convert object to JSON (without image)
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
      
      // Get file size for debugging
      int fileSize = await image!.length();
      print('Image file size: ${fileSize} bytes');
      print('Image file path: ${image!.path}');
      print('Image file name: $fileName');
      
      // Get the file extension to determine content type
      String fileExtension = fileName.split('.').last.toLowerCase();
      String contentType;
      
      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          contentType = 'image/jpeg';
          break;
        case 'png':
          contentType = 'image/png';
          break;
        case 'gif':
          contentType = 'image/gif';
          break;
        default:
          contentType = 'image/jpeg'; // Default to jpeg
      }
      
      print('Content type: $contentType');
      
      formDataMap['image'] = await MultipartFile.fromFile(
        image!.path,
        filename: fileName,
        contentType: MediaType.parse(contentType),
      );
    }
    
    return FormData.fromMap(formDataMap);
  }
}