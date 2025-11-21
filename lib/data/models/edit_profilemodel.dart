// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';

// class EditProfileModel {
//   String userName;
//   String emailAddress;
//   String mobileNumber;
//   File? image;

//   EditProfileModel({
//     required this.userName,
//     required this.emailAddress,
//     required this.mobileNumber,
//     this.image,
//   });

//   // Create model from API JSON
//   factory EditProfileModel.fromJson(Map<String, dynamic> json) {
//     return EditProfileModel(
//       userName: json['userName'],
//       emailAddress: json['emailAddress'],
//       mobileNumber: json['mobileNumber'],
//       // image is skipped - cannot convert JSON to File
//     );
//   }

//   // Convert model to JSON (without image)
//   Map<String, dynamic> toJson() {
//     return {
//       'userName': userName,
//       'emailAddress': emailAddress,
//       'mobileNumber': mobileNumber,
//     };
//   }

//   // FormData for API request (supports image upload)
//   Future<FormData> toFormData() async {
//     Map<String, dynamic> formMap = {
//       'userName': userName,
//       'emailAddress': emailAddress,
//       'mobileNumber': mobileNumber,
//     };

//     if (image != null) {
//       String fileName = image!.path.split('/').last;
//       String ext = fileName.split('.').last.toLowerCase();

//       // Detect content type
//       String contentType;
//       switch (ext) {
//         case 'jpg':
//         case 'jpeg':
//           contentType = 'image/jpeg';
//           break;
//         case 'png':
//           contentType = 'image/png';
//           break;
//         case 'gif':
//           contentType = 'image/gif';
//           break;
//         default:
//           contentType = 'image/jpeg';
//       }

//       formMap['image'] = await MultipartFile.fromFile(
//         image!.path,
//         filename: fileName,
//         contentType: MediaType.parse(contentType),
//       );
//     }

//     return FormData.fromMap(formMap);
//   }
// }
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class EditProfileModel {
  String userName;
  String emailAddress;
  String mobileNumber;
  File? image;

  EditProfileModel({
    required this.userName,
    required this.emailAddress,
    required this.mobileNumber,
    this.image,
  });

  // Create model from API JSON
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      userName: json['userName'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
    );
  }

  // Convert model to JSON (without image)
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
    };
  }

  // FormData for API request (supports image upload)
  Future<FormData> toFormData() async {
    Map<String, dynamic> formMap = {
      'userName': userName,
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
    };

    if (image != null) {
      try {
        // Verify file exists
        if (!image!.existsSync()) {
          throw Exception('Image file does not exist at path: ${image!.path}');
        }

        // Safe filename extraction
        String fileName = _getFileName(image!.path);
        String ext = _getFileExtension(fileName);

        // Detect content type
        String contentType = _getContentType(ext);

        formMap['image'] = await MultipartFile.fromFile(
          image!.path,
          filename: fileName,
          contentType: MediaType.parse(contentType),
        );
      } catch (e) {
        throw Exception('Error processing image file: $e');
      }
    }

    return FormData.fromMap(formMap);
  }

  /// Safely extract filename from path
  String _getFileName(String path) {
    try {
      // Handle both Unix (/) and Windows (\) separators
      final parts = path.replaceAll('\\', '/').split('/');
      final fileName = parts.isNotEmpty ? parts.last : 'image';
      
      // If filename is empty or looks invalid, generate a new one
      if (fileName.isEmpty || !fileName.contains('.')) {
        return 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      }
      
      return fileName;
    } catch (e) {
      return 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    }
  }

  /// Safely extract file extension
  String _getFileExtension(String fileName) {
    try {
      if (!fileName.contains('.')) {
        return 'jpg'; // Default extension
      }
      final parts = fileName.split('.');
      return parts.isNotEmpty ? parts.last.toLowerCase() : 'jpg';
    } catch (e) {
      return 'jpg';
    }
  }

  /// Determine content type from extension
  String _getContentType(String ext) {
    switch (ext.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg'; // Default to JPEG
    }
  }
}