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
    final zipFilePath = await downloadFile();
    final extractedDir = await extractFile(zipFilePath);
    final dataItems = await fetchJsonData(extractedDir);
    await storeDataInDatabase(dataItems);
  }

  Future<String> downloadFile() async {
    final tempDir = await getTemporaryDirectory();
    final zipFilePath = '${tempDir.path}/data.zip';
    await dio.download(downloadUrl, zipFilePath);
    log('TEmporary zip file:$zipFilePath');
    return zipFilePath;
  }

  Future<String> extractFile(String zipFilePath) async {
    final perDir = await getApplicationDocumentsDirectory();
    final extractedDir = '${perDir.path}/extracted';
    final archive =
        ZipDecoder().decodeBytes(File(zipFilePath).readAsBytesSync());
    for (var file in archive) {
      final filePath = '$extractedDir/${file.name}';
      if (file.isFile) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(file.content as List<int>);
      }
    }
    log('Extracted dir :$extractedDir');
    return extractedDir;
  }

  Future<List<DataItem>> fetchJsonData(String extractedDir) async {
    try {
      final jsonFilePath = '$extractedDir/file/import.json';
      final jsonFile = File(jsonFilePath);
      if (!jsonFile.existsSync()) {
        log('Json file not found at :$jsonFilePath');
        return [];
      }
      final jsonString = await jsonFile.readAsString();
      final jsonData = jsonDecode(jsonString);
      final List<dynamic> jsonList = jsonData['data'];
      log('Parsed JSON data');
      return jsonList.map((json) => DataItem.fromJson(json)).toList();
    } catch (e) {
      log('Error decoding Json:$e');
      return [];
    }
  }

  Future<void> storeDataInDatabase(List<DataItem> dataItems) async {
    final db = DatabaseHelper.instance;
    for (var item in dataItems) {
      await db.insertDataItem(item);
    }
    log('Stored ${dataItems.length} items in the database');
  }

  static Future<List<DataItem>> getDataFromDatabase() async {
    final db = DatabaseHelper.instance;
    return await db.getAllDataItems();
  }
}
