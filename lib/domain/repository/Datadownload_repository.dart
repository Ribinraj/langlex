import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:langlex/data/models/Data_model.dart';
import 'package:langlex/domain/local_database/database_helper.dart';
import 'package:path_provider/path_provider.dart';

class DownloadRepository {
  final Dio dio = Dio();
  final downloadUrl = 'https://crisantdemo.in/chidanandayoga/data.zip';

  Future<void> download() async {
    try {
      final zipFilePath = await downloadFile();
      final extractedDir = await extractFile(zipFilePath);
      final dataItems = await fetchJsonData(extractedDir);
      await storeDataInDatabase(dataItems);
      
      // Clean up only temporary zip file, keep extracted files
      await _cleanupTempFiles(zipFilePath, extractedDir);
    } catch (e) {
      log('Download failed: $e');
      rethrow;
    }
  }

  Future<String> downloadFile() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final zipFilePath = '${tempDir.path}/data.zip';
      
      // Add timeout and error handling
      await dio.download(
        downloadUrl, 
        zipFilePath,
        options: Options(
          receiveTimeout: const Duration(minutes: 5),
          sendTimeout: const Duration(minutes: 2),
        ),
      );
      
      log('Downloaded zip file: $zipFilePath');
      return zipFilePath;
    } catch (e) {
      log('Download failed: $e');
      throw Exception('Failed to download data: $e');
    }
  }

  Future<String> extractFile(String zipFilePath) async {
    try {
      final perDir = await getApplicationDocumentsDirectory();
      final extractedDir = '${perDir.path}/extracted';
      
      // Clean existing extracted directory
      final dir = Directory(extractedDir);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
      
      final archive = ZipDecoder().decodeBytes(File(zipFilePath).readAsBytesSync());
      
      for (var file in archive) {
        final filePath = '$extractedDir/${file.name}';
        if (file.isFile) {
          File(filePath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(file.content as List<int>);
        }
      }
      
      log('Extracted dir: $extractedDir');
      return extractedDir;
    } catch (e) {
      log('Extraction failed: $e');
      throw Exception('Failed to extract files: $e');
    }
  }

  Future<List<DataItem>> fetchJsonData(String extractedDir) async {
    try {
      final jsonFilePath = '$extractedDir/file/import.json';
      final jsonFile = File(jsonFilePath);
      
      if (!jsonFile.existsSync()) {
        log('JSON file not found at: $jsonFilePath');
        throw Exception('JSON file not found');
      }
      
      final jsonString = await jsonFile.readAsString();
      final jsonData = jsonDecode(jsonString);
      
      if (jsonData['data'] == null) {
        throw Exception('Invalid JSON structure: missing data field');
      }
      
      final List<dynamic> jsonList = jsonData['data'];
      log('Parsed JSON data: ${jsonList.length} items');
      
      return jsonList.map((json) => DataItem.fromJson(json)).toList();
    } catch (e) {
      log('Error parsing JSON: $e');
      throw Exception('Failed to parse JSON data: $e');
    }
  }

  Future<void> storeDataInDatabase(List<DataItem> dataItems) async {
    try {
      final db = DatabaseHelper.instance;
      
      for (var item in dataItems) {
        await db.insertDataItem(item);
      }
      
      log('Stored ${dataItems.length} items in the database');
    } catch (e) {
      log('Database storage failed: $e');
      throw Exception('Failed to store data in database: $e');
    }
  }

  // New method to clear existing data
  Future<void> clearExistingData() async {
    try {
      final db = DatabaseHelper.instance;
      await db.clearAllData();
      log('Cleared existing data from database');
    } catch (e) {
      log('Failed to clear existing data: $e');
      throw Exception('Failed to clear existing data: $e');
    }
  }

  // Helper method to clean up temporary files (but keep extracted files)
  Future<void> _cleanupTempFiles(String zipFilePath, String extractedDir) async {
    try {
      // Only delete zip file, keep extracted directory for app usage
      final zipFile = File(zipFilePath);
      if (await zipFile.exists()) {
        await zipFile.delete();
        log('Cleaned up zip file: $zipFilePath');
      }
      
      // Don't delete extracted directory as it contains the actual content files
      log('Keeping extracted directory for app usage: $extractedDir');
    } catch (e) {
      log('Cleanup failed: $e');
      // Don't throw here as this is not critical
    }
  }

  static Future<List<DataItem>> getDataFromDatabase() async {
    try {
      final db = DatabaseHelper.instance;
      return await db.getAllDataItems();
    } catch (e) {
      log('Failed to get data from database: $e');
      return [];
    }
  }

  static Future<bool> hasDataInDatabase() async {
    try {
      final db = DatabaseHelper.instance;
      return await db.hasData();
    } catch (e) {
      log('Failed to check database status: $e');
      return false;
    }
  }
}