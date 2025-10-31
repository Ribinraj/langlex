import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:langlex/core/urls.dart';
import 'package:langlex/data/models/language_model.dart';
import 'package:langlex/data/models/primary_model.dart';
import 'package:langlex/data/models/secondary_model.dart';
import 'package:langlex/data/models/student_list_model.dart';
import 'package:langlex/data/models/student_model.dart';
import 'package:langlex/presentation/widgets/custom_sharedpreferences.dart';
import 'package:path_provider/path_provider.dart';

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse(
      {this.data,
      required this.message,
      required this.error,
      required this.status});
}

class AppRepo {
  final Dio dio;
  AppRepo({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
                baseUrl: Endpoints.baseUrl,
                headers: {'content-Type': 'application/json'}));
///////------------------fetchlanguages-------------//////////////////////
  Future<ApiResponse<List<LanguageModel>>> fetchlanguages() async {
    try {
      Response response = await dio.get(Endpoints.fetchlanguages);
      final responseData = response.data;
      log(responseData['error'].toString());
      if (!responseData['error'] && responseData['status'] == 200) {
        log(responseData['status'].toString());
        final List<dynamic> languagelists = responseData['data'];
        List<LanguageModel> languages = languagelists
            .map((language) => LanguageModel.fromJson(language))
            .toList();
        log(languages[0].toString());
        return ApiResponse(
            data: languages,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData['status']);
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  ///////////---------------registerStudent----------/////////////
  Future<ApiResponse> registerStudent({required StudentModel student}) async {
    try {
      final token = await getUserToken();

      // Create FormData from student model
      FormData formData = await student.toFormData();

      Response response = await dio.post(
        Endpoints.registerstudent,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        }),
        data: formData,
      );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    } catch (e) {
      // Add a general catch block for other exceptions
      log("Unexpected error: $e");
      return ApiResponse(
        data: null,
        message: 'Unexpected error: $e',
        error: true,
        status: 500,
      );
    }
  }
//   Future<ApiResponse> registerStudent({required StudentModel student}) async {
//     try {
//       final token = await getUserToken();

//       Response response = await dio.post(Endpoints.registerstudent,
//          options: Options(headers: {'Authorization': 'Bearer $token'})
// , data: student);

//       final responseData = response.data;

//       if (!responseData["error"] && responseData["status"] == 200) {
//         return ApiResponse(
//           data: null,
//           message: responseData['message'] ?? 'Success',
//           error: false,
//           status: responseData["status"],
//         );
//       } else {
//         return ApiResponse(
//           data: null,
//           message: responseData['message'] ?? 'Something went wrong',
//           error: true,
//           status: responseData["status"],
//         );
//       }
//     } on DioException catch (e) {
//       debugPrint(e.message);
//       log(e.toString());
//       return ApiResponse(
//         data: null,
//         message: 'Network or server error occurred',
//         error: true,
//         status: 500,
//       );
//     } catch (e) {
//       // Add a general catch block for other exceptions
//       log("Unexpected error: $e");
//       return ApiResponse(
//         data: null,
//         message: 'Unexpected error: $e',
//         error: true,
//         status: 500,
//       );
//     }
//   }

  /////////////------------fetchStudentList-------------//////////////////
  Future<ApiResponse<List<StudentListModel>>> fetchkidsList() async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.get(Endpoints.fetchkids,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      final responseData = response.data;

      if (!responseData['error'] && responseData['status'] == 200) {
        log('studentlists${responseData['status'].toString()}');
        final List<dynamic> studenlists = responseData['data'];
        List<StudentListModel> students = studenlists
            .map((language) => StudentListModel.fromJson(language))
            .toList();

        return ApiResponse(
            data: students,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData['status']);
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  /////////////------------fetchPrimaryCategory-------------//////////////////
  Future<ApiResponse<List<PrimaryCategoryModel>>> fetchprimaryCategory({required String category, required int languageId}) async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.get( "${Endpoints.baseUrl}${Endpoints.fetchprimarycategory}/$languageId",
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"category":category});
      final responseData = response.data;
log('primarycategories${responseData['status'].toString()}');
      if (!responseData['error'] && responseData['status'] == 200) {
        //log('primarycategories${responseData['status'].toString()}');
        final List<dynamic> primarycategorylist = responseData['data'];
        List<PrimaryCategoryModel> primarycategories = primarycategorylist
            .map((category) => PrimaryCategoryModel.fromJson(category))
            .toList();

        return ApiResponse(
            data: primarycategories,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData['status']);
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
    /////////////------------fetchPrimaryCategory-------------//////////////////
  Future<ApiResponse<List<SecondaryModel>>> fetchsecondaryCategory({required String category, required int languageId,required int primaryCategoryId}) async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.get( "${Endpoints.baseUrl}${Endpoints.fetchsecondaryCategory}/$languageId",
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data:  {"category":category,
 "primaryCategoryId":primaryCategoryId
 
 });
      final responseData = response.data;
log('primarycategories${responseData['status'].toString()}');
      if (!responseData['error'] && responseData['status'] == 200) {
        //log('primarycategories${responseData['status'].toString()}');
        final List<dynamic> secondarycategorylist = responseData['data'];
        List<SecondaryModel> secondarycategories = secondarycategorylist
            .map((category) => SecondaryModel.fromJson(category))
            .toList();

        return ApiResponse(
            data:secondarycategories,
            message: responseData['message'] ?? 'Success',
            error: false,
            status: responseData['status']);
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  //////////////////////////////////
//    /// Downloads and extracts knowledge zip file
// Future<Map<String, dynamic>> downloadAndExtractKnowledgeZip({
//   required int secondaryCategoryId,
//   required int primaryCategoryId,
//   required int languageId,
//   Function(double)? onProgress,
// }) async {
//   try {
//     log('=== DOWNLOAD STARTED ===');
//     log('Parameters: secondaryCategoryId=$secondaryCategoryId, primaryCategoryId=$primaryCategoryId, languageId=$languageId');

//     // Get app directory
//     final appDir = await getApplicationDocumentsDirectory();
//     final zipPath = '${appDir.path}/knowledge_$secondaryCategoryId.zip';
//     final extractPath = '${appDir.path}/extracted/knowledge_$secondaryCategoryId';

//     log('App Directory: ${appDir.path}');
//     log('Zip Path: $zipPath');
//     log('Extract Path: $extractPath');

//     // Download zip file
//     log('Downloading zip file...');
//     final response = await dio.post(
//       '${Endpoints.baseUrl}knowledge-zip',
//       data: {
//         'secondaryCategoryId': secondaryCategoryId,
//         'primaryCategoryId': primaryCategoryId,
//         'languageId': languageId,
//       },
//       options: Options(
//         responseType: ResponseType.bytes,
//         followRedirects: false,
//         validateStatus: (status) => status! < 500,
//       ),
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           final progress = (received / total);
//           log('Download progress: ${(progress * 100).toStringAsFixed(1)}%');
//           onProgress?.call(progress);
//         }
//       },
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to download: Status ${response.statusCode}');
//     }

//     log('Download completed. Size: ${response.data.length} bytes');

//     // Save zip file
//     log('Saving zip file...');
//     final zipFile = File(zipPath);
//     await zipFile.writeAsBytes(response.data);
//     log('Zip file saved successfully');

//     // Extract zip file
//     log('=== EXTRACTION STARTED ===');
//     final extractDir = Directory(extractPath);
//     if (await extractDir.exists()) {
//       log('Cleaning existing extract directory...');
//       await extractDir.delete(recursive: true);
//     }
//     await extractDir.create(recursive: true);
//     log('Extract directory created');

//     // Read and extract archive
//     log('Reading archive...');
//     final bytes = zipFile.readAsBytesSync();
//     final archive = ZipDecoder().decodeBytes(bytes);
//     log('Archive decoded. Files count: ${archive.length}');

//     // Extract all files
//     for (final file in archive) {
//       final filename = file.name;
//       final filePath = '$extractPath/$filename';
      
//       if (file.isFile) {
//         final outFile = File(filePath);
//         await outFile.create(recursive: true);
//         await outFile.writeAsBytes(file.content as List<int>);
//         log('Extracted file: $filename');
//       } else {
//         await Directory(filePath).create(recursive: true);
//         log('Created directory: $filename');
//       }
//     }

//     log('=== EXTRACTION COMPLETED ===');

//     // Parse contents.json - FIXED: Search for it recursively
//     log('=== PARSING CONTENTS.JSON ===');
    
//     // Search for contents.json in the extracted directory
//     String? contentsJsonPath;
//     final extractedDir = Directory(extractPath);
    
//     log('Searching for contents.json in: $extractPath');
//     await for (final entity in extractedDir.list(recursive: true)) {
//       if (entity is File && entity.path.endsWith('contents.json')) {
//         contentsJsonPath = entity.path;
//         log('Found contents.json at: $contentsJsonPath');
//         break;
//       }
//     }
    
//     if (contentsJsonPath == null) {
//       log('ERROR: contents.json not found in extracted files');
//       throw Exception('contents.json not found in extracted files');
//     }

//     // Get the base directory containing the actual content files
//     final contentsFile = File(contentsJsonPath);
//     final contentBaseDir = contentsFile.parent.path;
//     log('Content base directory: $contentBaseDir');
    
//     final contentsString = await contentsFile.readAsString();
//     log('Contents.json read successfully');
//     log('Contents.json size: ${contentsString.length} characters');
    
//     final List<dynamic> contentsJson = json.decode(contentsString);
//     log('Parsed ${contentsJson.length} content items');

//     // Convert to content models with absolute paths
//     final List<Map<String, dynamic>> contents = contentsJson.map((item) {
//       // Build absolute paths using contentBaseDir
//       final contentImage = '$contentBaseDir/${item['contentImage']}';
//       final contentAudio = '$contentBaseDir/${item['contentAudio']}';
//       final referenceAudio = '$contentBaseDir/${item['referenceAudio']}';

//       // Verify files exist
//       final imageExists = File(contentImage).existsSync();
//       final audioExists = File(contentAudio).existsSync();
//       final refAudioExists = File(referenceAudio).existsSync();

//       if (!imageExists || !audioExists || !refAudioExists) {
//         log('WARNING: Missing files for ${item['content']}:');
//         if (!imageExists) log('  - Missing image: $contentImage');
//         if (!audioExists) log('  - Missing audio: $contentAudio');
//         if (!refAudioExists) log('  - Missing ref audio: $referenceAudio');
//       }

//       return {
//         'contentId': item['contentId'],
//         'languageId': item['languageId'],
//         'primaryCategoryId': item['primaryCategoryId'].toString(),
//         'secondaryCategoryId': item['secondaryCategoryId'].toString(),
//         'content': item['content'],
//         'contentImage': contentImage,
//         'contentAudio': contentAudio,
//         'referenceAudio': referenceAudio,
//       };
//     }).toList();

//     // Clean up zip file
//     log('Cleaning up zip file...');
//     await zipFile.delete();
//     log('Zip file deleted');

//     log('=== PROCESS COMPLETED SUCCESSFULLY ===');
//     log('Total contents: ${contents.length}');

//     return {
//       'extractPath': contentBaseDir,
//       'contents': contents,
//       'totalItems': contents.length,
//     };
//   } catch (e, stackTrace) {
//     log('=== ERROR OCCURRED ===');
//     log('Error: $e');
//     log('StackTrace: $stackTrace');
//     rethrow;
//   }
// }

// /// Check if knowledge content exists locally
Future<bool> isKnowledgeDownloaded({
  required int secondaryCategoryId,
}) async {
  try {
    final appDir = await getApplicationDocumentsDirectory();
    final extractPath = '${appDir.path}/extracted/knowledge_$secondaryCategoryId';
    
    log('Checking if knowledge exists at: $extractPath');
    
    // Search for contents.json anywhere in the directory
    final extractedDir = Directory(extractPath);
    if (!await extractedDir.exists()) {
      log('Knowledge directory $secondaryCategoryId does not exist');
      return false;
    }
    
    await for (final entity in extractedDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('contents.json')) {
        log('Knowledge $secondaryCategoryId exists locally at: ${entity.path}');
        return true;
      }
    }
    
    log('Knowledge $secondaryCategoryId not found (contents.json missing)');
    return false;
  } catch (e) {
    log('Error checking local knowledge: $e');
    return false;
  }
}

/// Load local knowledge content
Future<Map<String, dynamic>> loadLocalKnowledge({
  required int secondaryCategoryId,
}) async {
  try {
    log('=== LOADING LOCAL KNOWLEDGE ===');
    final appDir = await getApplicationDocumentsDirectory();
    final extractPath = '${appDir.path}/extracted/knowledge_$secondaryCategoryId';

    log('Loading from: $extractPath');

    // Search for contents.json in the extracted directory
    String? contentsJsonPath;
    final extractedDir = Directory(extractPath);
    
    if (!await extractedDir.exists()) {
      throw Exception('Local knowledge directory not found');
    }
    
    await for (final entity in extractedDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('contents.json')) {
        contentsJsonPath = entity.path;
        log('Found contents.json at: $contentsJsonPath');
        break;
      }
    }
    
    if (contentsJsonPath == null) {
      throw Exception('Local knowledge not found (contents.json missing)');
    }

    final contentsFile = File(contentsJsonPath);
    final contentBaseDir = contentsFile.parent.path;
    log('Content base directory: $contentBaseDir');

    final contentsString = await contentsFile.readAsString();
    final List<dynamic> contentsJson = json.decode(contentsString);

    final List<Map<String, dynamic>> contents = contentsJson.map((item) {
      final contentImage = '$contentBaseDir/${item['contentImage']}';
      final contentAudio = '$contentBaseDir/${item['contentAudio']}';
      final referenceAudio = '$contentBaseDir/${item['referenceAudio']}';

      // Verify files exist
      final imageExists = File(contentImage).existsSync();
      final audioExists = File(contentAudio).existsSync();
      final refAudioExists = File(referenceAudio).existsSync();

      if (!imageExists || !audioExists || !refAudioExists) {
        log('WARNING: Missing files for ${item['content']}:');
        if (!imageExists) log('  - Missing image: $contentImage');
        if (!audioExists) log('  - Missing audio: $contentAudio');
        if (!refAudioExists) log('  - Missing ref audio: $referenceAudio');
      }

      return {
        'contentId': item['contentId'],
        'languageId': item['languageId'],
        'primaryCategoryId': item['primaryCategoryId'].toString(),
        'secondaryCategoryId': item['secondaryCategoryId'].toString(),
        'content': item['content'],
        'contentImage': contentImage,
        'contentAudio': contentAudio,
        'referenceAudio': referenceAudio,
      };
    }).toList();

    log('Loaded ${contents.length} content items from local storage');

    return {
      'extractPath': contentBaseDir,
      'contents': contents,
      'totalItems': contents.length,
    };
  } catch (e, stackTrace) {
    log('=== ERROR LOADING LOCAL KNOWLEDGE ===');
    log('Error: $e');
    log('StackTrace: $stackTrace');
    rethrow;
  }
}
/// Downloads and extracts knowledge zip file
/// If forceDownload is true, downloads to temp location first, then replaces old data
Future<Map<String, dynamic>> downloadAndExtractKnowledgeZip({
  required int secondaryCategoryId,
  required int primaryCategoryId,
  required int languageId,
  bool forceDownload = false,
  Function(double)? onProgress,
}) async {
  try {
    log('=== DOWNLOAD STARTED ===');
    log('Parameters: secondaryCategoryId=$secondaryCategoryId, primaryCategoryId=$primaryCategoryId, languageId=$languageId');
    log('Force Download: $forceDownload');

    // Get app directory
    final appDir = await getApplicationDocumentsDirectory();
    
    // If force download, use temporary paths first
    final isRedownload = forceDownload && await isKnowledgeDownloaded(
      secondaryCategoryId: secondaryCategoryId,
    );
    
    String zipPath;
    String extractPath;
    String finalExtractPath = '${appDir.path}/extracted/knowledge_$secondaryCategoryId';
    
    if (isRedownload) {
      // Download to temporary location for re-download
      log('Re-downloading: Using temporary paths');
      zipPath = '${appDir.path}/temp_knowledge_$secondaryCategoryId.zip';
      extractPath = '${appDir.path}/temp_extracted/knowledge_$secondaryCategoryId';
    } else {
      // Normal download or first time download
      zipPath = '${appDir.path}/knowledge_$secondaryCategoryId.zip';
      extractPath = finalExtractPath;
    }

    log('App Directory: ${appDir.path}');
    log('Zip Path: $zipPath');
    log('Extract Path: $extractPath');
    if (isRedownload) {
      log('Final Extract Path (after success): $finalExtractPath');
    }

    // Download zip file
    log('Downloading zip file...');
    final response = await dio.post(
      '${Endpoints.baseUrl}knowledge-zip',
      data: {
        'secondaryCategoryId': secondaryCategoryId,
        'primaryCategoryId': primaryCategoryId,
        'languageId': languageId,
      },
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) => status! < 500,
      ),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final progress = (received / total);
          log('Download progress: ${(progress * 100).toStringAsFixed(1)}%');
          onProgress?.call(progress);
        }
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to download: Status ${response.statusCode}');
    }

    log('Download completed. Size: ${response.data.length} bytes');

    // Save zip file
    log('Saving zip file...');
    final zipFile = File(zipPath);
    await zipFile.writeAsBytes(response.data);
    log('Zip file saved successfully');

    // Extract zip file
    log('=== EXTRACTION STARTED ===');
    final extractDir = Directory(extractPath);
    if (await extractDir.exists()) {
      log('Cleaning existing extract directory...');
      await extractDir.delete(recursive: true);
    }
    await extractDir.create(recursive: true);
    log('Extract directory created');

    // Read and extract archive
    log('Reading archive...');
    final bytes = zipFile.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    log('Archive decoded. Files count: ${archive.length}');

    // Extract all files
    for (final file in archive) {
      final filename = file.name;
      final filePath = '$extractPath/$filename';
      
      if (file.isFile) {
        final outFile = File(filePath);
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
        log('Extracted file: $filename');
      } else {
        await Directory(filePath).create(recursive: true);
        log('Created directory: $filename');
      }
    }

    log('=== EXTRACTION COMPLETED ===');

    // Parse contents.json
    log('=== PARSING CONTENTS.JSON ===');
    
    // Search for contents.json in the extracted directory
    String? contentsJsonPath;
    final extractedDir = Directory(extractPath);
    
    log('Searching for contents.json in: $extractPath');
    await for (final entity in extractedDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('contents.json')) {
        contentsJsonPath = entity.path;
        log('Found contents.json at: $contentsJsonPath');
        break;
      }
    }
    
    if (contentsJsonPath == null) {
      log('ERROR: contents.json not found in extracted files');
      
      // Clean up temporary files if re-download failed
      if (isRedownload) {
        log('Cleaning up failed temporary download...');
        await zipFile.delete();
        await extractedDir.delete(recursive: true);
      }
      
      throw Exception('contents.json not found in extracted files');
    }

    // Get the base directory containing the actual content files
    final contentsFile = File(contentsJsonPath);
    var contentBaseDir = contentsFile.parent.path;
    log('Content base directory: $contentBaseDir');
    
    final contentsString = await contentsFile.readAsString();
    log('Contents.json read successfully');
    log('Contents.json size: ${contentsString.length} characters');
    
    final List<dynamic> contentsJson = json.decode(contentsString);
    log('Parsed ${contentsJson.length} content items');

    // Convert to content models with absolute paths
    final List<Map<String, dynamic>> contents = contentsJson.map((item) {
      // Build absolute paths using contentBaseDir
      final contentImage = '$contentBaseDir/${item['contentImage']}';
      final contentAudio = '$contentBaseDir/${item['contentAudio']}';
      final referenceAudio = '$contentBaseDir/${item['referenceAudio']}';

      // Verify files exist
      final imageExists = File(contentImage).existsSync();
      final audioExists = File(contentAudio).existsSync();
      final refAudioExists = File(referenceAudio).existsSync();

      if (!imageExists || !audioExists || !refAudioExists) {
        log('WARNING: Missing files for ${item['content']}:');
        if (!imageExists) log('  - Missing image: $contentImage');
        if (!audioExists) log('  - Missing audio: $contentAudio');
        if (!refAudioExists) log('  - Missing ref audio: $referenceAudio');
      }

      return {
        'contentId': item['contentId'],
        'languageId': item['languageId'],
        'primaryCategoryId': item['primaryCategoryId'].toString(),
        'secondaryCategoryId': item['secondaryCategoryId'].toString(),
        'content': item['content'],
        'contentImage': contentImage,
        'contentAudio': contentAudio,
        'referenceAudio': referenceAudio,
      };
    }).toList();

    // If this was a re-download, now replace the old data with new data
    if (isRedownload) {
      log('=== REPLACING OLD DATA WITH NEW DATA ===');
      
      try {
        // Delete old data
        final oldDir = Directory(finalExtractPath);
        if (await oldDir.exists()) {
          log('Deleting old data directory: $finalExtractPath');
          await oldDir.delete(recursive: true);
          log('Old data deleted successfully');
        }
        
        // Move temp directory to final location
        log('Moving temporary data to final location...');
        final tempDir = Directory(extractPath);
        await tempDir.rename(finalExtractPath);
        log('Data moved successfully to: $finalExtractPath');
        
        // Update contentBaseDir to reflect new location
        final updatedContentBaseDir = finalExtractPath + 
          contentBaseDir.substring(extractPath.length);
        log('Updated content base directory: $updatedContentBaseDir');
        
        // Update all file paths in contents to point to final location
        for (var i = 0; i < contents.length; i++) {
          final item = contentsJson[i];
          final newContentImage = '$updatedContentBaseDir/${item['contentImage']}';
          final newContentAudio = '$updatedContentBaseDir/${item['contentAudio']}';
          final newReferenceAudio = '$updatedContentBaseDir/${item['referenceAudio']}';
          
          contents[i] = {
            'contentId': item['contentId'],
            'languageId': item['languageId'],
            'primaryCategoryId': item['primaryCategoryId'].toString(),
            'secondaryCategoryId': item['secondaryCategoryId'].toString(),
            'content': item['content'],
            'contentImage': newContentImage,
            'contentAudio': newContentAudio,
            'referenceAudio': newReferenceAudio,
          };
        }
        
        log('=== OLD DATA REPLACED SUCCESSFULLY ===');
        
        // Use updated path for return value
        contentBaseDir = updatedContentBaseDir;
        
      } catch (e) {
        log('ERROR: Failed to replace old data: $e');
        // If replacement fails, clean up temp data and throw error
        try {
          await Directory(extractPath).delete(recursive: true);
          await zipFile.delete();
        } catch (_) {}
        throw Exception('Failed to replace old data: $e');
      }
    }

    // Clean up zip file
    log('Cleaning up zip file...');
    await zipFile.delete();
    log('Zip file deleted');

    log('=== PROCESS COMPLETED SUCCESSFULLY ===');
    log('Total contents: ${contents.length}');

    return {
      'extractPath': contentBaseDir,
      'contents': contents,
      'totalItems': contents.length,
    };
  } catch (e, stackTrace) {
    log('=== ERROR OCCURRED ===');
    log('Error: $e');
    log('StackTrace: $stackTrace');
    rethrow;
  }
}
  void dispose() {
    dio.close();
  }
}
